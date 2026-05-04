import 'dart:io';
import 'package:flutter/foundation.dart';
import 'package:flutter/services.dart';
import 'package:google_mlkit_subject_segmentation/google_mlkit_subject_segmentation.dart';
import 'package:image/image.dart' as img;
import 'package:path_provider/path_provider.dart';

class MLKitService {
  /// Removes the background and turns the image into a proper WhatsApp sticker.
  ///
  /// [stickerMode]: if true (default), produces a 512x512 sticker with white outline,
  /// centered on transparent canvas (real sticker look).
  /// If false, returns just the cutout with original dimensions (raw cutout).
  static Future<Uint8List> removeBackground(
    String imagePath, {
    bool stickerMode = true,
    bool whiteOutline = true,
  }) async {
    // 1. Resize input
    final resizedPath = await _resizeImage(imagePath);

    // 2. Run ML Kit segmentation
    final inputImage = InputImage.fromFilePath(resizedPath);
    final segmenter = SubjectSegmenter(
      options: SubjectSegmenterOptions(
        enableForegroundBitmap: false,
        enableForegroundConfidenceMask: true,
        enableMultipleSubjects: SubjectResultOptions(
          enableConfidenceMask: false,
          enableSubjectBitmap: false,
        ),
      ),
    );

    try {
      debugPrint('[MLKit] Segmenting: $resizedPath');
      late final SubjectSegmentationResult result;
      try {
        result = await segmenter.processImage(inputImage);
      } on PlatformException catch (e) {
        debugPrint('[MLKit] PlatformException: ${e.code}');
        final code = e.code.toLowerCase();
        if (code.contains('module_not_found') ||
            code.contains('not_downloaded') ||
            code.contains('not_available')) {
          throw Exception('Modello AI non ancora pronto.\n\n'
              'Sta scaricando in background (~12MB). '
              'Aspetta 30-60 secondi e riprova.\n\n'
              'Se persiste:\n'
              '1. Verifica internet\n'
              '2. Aggiorna Google Play Services\n'
              '3. Riavvia l\'app');
        }
        rethrow;
      }

      final mask = result.foregroundConfidenceMask;
      if (mask == null || mask.isEmpty) {
        throw Exception(
            'Nessun soggetto rilevato. Prova con una foto in cui il soggetto è ben visibile.');
      }

      final originalBytes = await File(resizedPath).readAsBytes();
      final original = img.decodeImage(originalBytes);
      if (original == null) {
        throw Exception('Immagine non valida.');
      }

      final w = original.width;
      final h = original.height;
      if (mask.length != w * h) {
        throw Exception('Mask incompatibile (${mask.length} vs ${w * h}).');
      }

      // 3. Apply mask with sharp-ish edges (sticker-style)
      // Hard threshold near edges for crisp cutout
      final cutout = img.Image(width: w, height: h, numChannels: 4);
      int strongFgCount = 0;
      for (int y = 0; y < h; y++) {
        for (int x = 0; x < w; x++) {
          final c = mask[y * w + x];
          if (c > 0.95) strongFgCount++;
          // Sticker-style alpha: sharper edges
          int alphaByte;
          if (c < 0.4) {
            alphaByte = 0;
          } else if (c > 0.7) {
            alphaByte = 255;
          } else {
            // Linear ramp 0.4-0.7 → 0-255 for thin antialiased edge
            alphaByte = (((c - 0.4) / 0.3) * 255).round().clamp(0, 255);
          }
          if (alphaByte > 0) {
            final p = original.getPixel(x, y);
            cutout.setPixelRgba(
                x, y, p.r.toInt(), p.g.toInt(), p.b.toInt(), alphaByte);
          } else {
            cutout.setPixelRgba(x, y, 0, 0, 0, 0);
          }
        }
      }

      if (strongFgCount < 100) {
        throw Exception(
            'Soggetto troppo piccolo. Riprova con foto dove il soggetto è ben visibile.');
      }

      if (!stickerMode) {
        return Uint8List.fromList(img.encodePng(cutout));
      }

      // 4. Crop to bounding box (tight)
      final cropped = _cropTight(cutout);

      // 5. Fit cropped subject into a max box leaving room for outline+padding
      final stickerSize = 512;
      final outlinePx = whiteOutline ? 12 : 0;
      final padding = 8;
      final maxSubjectSize = stickerSize - 2 * (outlinePx + padding); // e.g. 472

      img.Image scaled = cropped;
      if (cropped.width > maxSubjectSize || cropped.height > maxSubjectSize) {
        if (cropped.width >= cropped.height) {
          scaled = img.copyResize(cropped, width: maxSubjectSize, interpolation: img.Interpolation.cubic);
        } else {
          scaled = img.copyResize(cropped, height: maxSubjectSize, interpolation: img.Interpolation.cubic);
        }
      }

      // 6. Add white outline if requested
      img.Image withOutline = scaled;
      if (whiteOutline) {
        withOutline = _addWhiteOutline(scaled, strokeWidth: outlinePx);
      }

      // 7. Center on 512x512 transparent canvas
      final canvas = img.Image(width: stickerSize, height: stickerSize, numChannels: 4);
      img.fill(canvas, color: img.ColorRgba8(0, 0, 0, 0));
      final dx = (stickerSize - withOutline.width) ~/ 2;
      final dy = (stickerSize - withOutline.height) ~/ 2;
      img.compositeImage(canvas, withOutline, dstX: dx, dstY: dy);

      return Uint8List.fromList(img.encodePng(canvas));
    } finally {
      await segmenter.close();
    }
  }

  /// Resize input image to max 1024px and save to temp file.
  static Future<String> _resizeImage(String inputPath) async {
    final bytes = await File(inputPath).readAsBytes();
    final decoded = img.decodeImage(bytes);
    if (decoded == null) {
      throw Exception('Impossibile decodificare l\'immagine.');
    }

    img.Image processed = decoded;
    const maxSize = 1024;
    if (decoded.width > maxSize || decoded.height > maxSize) {
      if (decoded.width >= decoded.height) {
        processed = img.copyResize(decoded, width: maxSize);
      } else {
        processed = img.copyResize(decoded, height: maxSize);
      }
    }

    final dir = await getTemporaryDirectory();
    final tempPath =
        '${dir.path}/mlkit_input_${DateTime.now().millisecondsSinceEpoch}.png';
    await File(tempPath).writeAsBytes(img.encodePng(processed));
    return tempPath;
  }

  /// Find tight bounding box and crop (no padding).
  static img.Image _cropTight(img.Image image) {
    int minX = image.width;
    int minY = image.height;
    int maxX = 0;
    int maxY = 0;

    for (int y = 0; y < image.height; y++) {
      for (int x = 0; x < image.width; x++) {
        final p = image.getPixel(x, y);
        if (p.a > 80) {
          if (x < minX) minX = x;
          if (y < minY) minY = y;
          if (x > maxX) maxX = x;
          if (y > maxY) maxY = y;
        }
      }
    }

    if (minX >= maxX || minY >= maxY) return image;

    return img.copyCrop(
      image,
      x: minX,
      y: minY,
      width: maxX - minX + 1,
      height: maxY - minY + 1,
    );
  }

  /// Add white outline (sticker-style) around the foreground subject.
  /// Uses morphological dilation: each transparent pixel within strokeWidth
  /// of a foreground pixel becomes white opaque.
  static img.Image _addWhiteOutline(img.Image input, {required int strokeWidth}) {
    final w = input.width;
    final h = input.height;
    // New canvas larger by 2*strokeWidth on each side to fit the outline
    final ow = w + 2 * strokeWidth;
    final oh = h + 2 * strokeWidth;
    final output = img.Image(width: ow, height: oh, numChannels: 4);
    img.fill(output, color: img.ColorRgba8(0, 0, 0, 0));

    // Pre-compute alpha grid for input (offset by strokeWidth in output coords)
    // For each output pixel, check if any input pixel within stroke radius
    // is foreground.
    final radiusSq = strokeWidth * strokeWidth;

    for (int y = 0; y < oh; y++) {
      for (int x = 0; x < ow; x++) {
        // Coordinates in input image (offset by strokeWidth)
        final ix = x - strokeWidth;
        final iy = y - strokeWidth;

        // First check: if this pixel itself is in input bounds, get its alpha
        int selfAlpha = 0;
        if (ix >= 0 && ix < w && iy >= 0 && iy < h) {
          selfAlpha = input.getPixel(ix, iy).a.toInt();
        }

        if (selfAlpha > 80) {
          // Foreground pixel: copy from input
          final p = input.getPixel(ix, iy);
          output.setPixelRgba(
              x, y, p.r.toInt(), p.g.toInt(), p.b.toInt(), p.a.toInt());
          continue;
        }

        // Otherwise check if within stroke radius of any foreground pixel
        bool nearFg = false;
        // Limit search to circle around (ix, iy)
        final yMin = (iy - strokeWidth).clamp(0, h - 1).toInt();
        final yMax = (iy + strokeWidth).clamp(0, h - 1).toInt();
        for (int yy = yMin; yy <= yMax && !nearFg; yy++) {
          final dy = yy - iy;
          final remSq = radiusSq - dy * dy;
          if (remSq < 0) continue;
          final dxMax = _isqrt(remSq);
          final xMin = (ix - dxMax).clamp(0, w - 1).toInt();
          final xMax = (ix + dxMax).clamp(0, w - 1).toInt();
          for (int xx = xMin; xx <= xMax; xx++) {
            if (input.getPixel(xx, yy).a > 80) {
              nearFg = true;
              break;
            }
          }
        }

        if (nearFg) {
          // White outline pixel
          output.setPixelRgba(x, y, 255, 255, 255, 255);
        } else if (selfAlpha > 0) {
          // Antialiased edge of original, but no near foreground (rare)
          final p = input.getPixel(ix, iy);
          output.setPixelRgba(
              x, y, p.r.toInt(), p.g.toInt(), p.b.toInt(), p.a.toInt());
        }
      }
    }

    return output;
  }

  /// Integer square root for circular dilation.
  static int _isqrt(int n) {
    if (n < 2) return n;
    int x = n;
    int y = (x + 1) >> 1;
    while (y < x) {
      x = y;
      y = (x + n ~/ x) >> 1;
    }
    return x;
  }
}
