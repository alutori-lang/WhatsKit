import 'dart:io';
import 'package:flutter/foundation.dart';
import 'package:google_mlkit_subject_segmentation/google_mlkit_subject_segmentation.dart';
import 'package:image/image.dart' as img;
import 'package:path_provider/path_provider.dart';

class MLKitService {
  /// Removes the background from an image using on-device ML Kit Subject Segmentation.
  /// Free, offline, no API key required.
  static Future<Uint8List> removeBackground(String imagePath) async {
    // 1. Resize to manageable size (faster + less memory)
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
      debugPrint('[MLKit] Running segmentation on: $resizedPath');
      final result = await segmenter.processImage(inputImage);

      final mask = result.foregroundConfidenceMask;
      if (mask == null || mask.isEmpty) {
        throw Exception(
            'Nessun soggetto rilevato. Prova con una foto in cui il soggetto è ben visibile e illuminato.');
      }

      // 3. Load resized image and apply mask
      final originalBytes = await File(resizedPath).readAsBytes();
      final original = img.decodeImage(originalBytes);
      if (original == null) {
        throw Exception('Immagine non valida.');
      }

      final w = original.width;
      final h = original.height;
      debugPrint('[MLKit] Image: ${w}x$h, mask length: ${mask.length} (expected ${w * h})');

      // Verify mask dimensions
      if (mask.length != w * h) {
        throw Exception(
            'Dimensioni mask incompatibili: ${mask.length} vs ${w * h}.');
      }

      // 4. Build output PNG with alpha channel from mask
      final output = img.Image(width: w, height: h, numChannels: 4);
      int foregroundCount = 0;
      for (int y = 0; y < h; y++) {
        for (int x = 0; x < w; x++) {
          final idx = y * w + x;
          final confidence = mask[idx];
          final alpha = (confidence * 255).clamp(0, 255).toInt();
          if (alpha > 30) {
            // Foreground pixel: copy color, apply confidence as alpha
            final p = original.getPixel(x, y);
            output.setPixelRgba(
              x,
              y,
              p.r.toInt(),
              p.g.toInt(),
              p.b.toInt(),
              alpha,
            );
            foregroundCount++;
          } else {
            // Background pixel: fully transparent
            output.setPixelRgba(x, y, 0, 0, 0, 0);
          }
        }
      }

      if (foregroundCount < 100) {
        throw Exception(
            'Soggetto troppo piccolo per essere uno sticker. Prova con una foto dove il soggetto occupa più spazio.');
      }

      debugPrint('[MLKit] Foreground pixels: $foregroundCount / ${w * h}');

      // 5. Crop to bounding box of foreground (tighter sticker)
      final cropped = _cropToForeground(output);

      return Uint8List.fromList(img.encodePng(cropped));
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
    final tempPath = '${dir.path}/mlkit_input_${DateTime.now().millisecondsSinceEpoch}.png';
    await File(tempPath).writeAsBytes(img.encodePng(processed));
    return tempPath;
  }

  /// Find bounding box of non-transparent pixels and crop with small padding.
  static img.Image _cropToForeground(img.Image image) {
    int minX = image.width;
    int minY = image.height;
    int maxX = 0;
    int maxY = 0;

    for (int y = 0; y < image.height; y++) {
      for (int x = 0; x < image.width; x++) {
        final p = image.getPixel(x, y);
        if (p.a > 30) {
          if (x < minX) minX = x;
          if (y < minY) minY = y;
          if (x > maxX) maxX = x;
          if (y > maxY) maxY = y;
        }
      }
    }

    if (minX >= maxX || minY >= maxY) return image;

    // Add 5% padding around the subject
    final padX = ((maxX - minX) * 0.05).round();
    final padY = ((maxY - minY) * 0.05).round();
    minX = (minX - padX).clamp(0, image.width).toInt();
    minY = (minY - padY).clamp(0, image.height).toInt();
    maxX = (maxX + padX).clamp(0, image.width).toInt();
    maxY = (maxY + padY).clamp(0, image.height).toInt();

    return img.copyCrop(
      image,
      x: minX,
      y: minY,
      width: maxX - minX,
      height: maxY - minY,
    );
  }
}
