import 'dart:io';
import 'package:flutter/foundation.dart';
import 'package:flutter/services.dart';
import 'package:google_mlkit_subject_segmentation/google_mlkit_subject_segmentation.dart';
import 'package:image/image.dart' as img;
import 'package:path_provider/path_provider.dart';

class MLKitService {
  /// Removes the background from an image using on-device ML Kit Subject Segmentation.
  /// Free, offline, no API key required.
  ///
  /// [autoCrop]: if true, crops to the bounding box of the subject. If false,
  /// keeps original image dimensions with transparent background.
  static Future<Uint8List> removeBackground(
    String imagePath, {
    bool autoCrop = false,
  }) async {
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
      late final SubjectSegmentationResult result;
      try {
        result = await segmenter.processImage(inputImage);
      } on PlatformException catch (e) {
        debugPrint('[MLKit] PlatformException: ${e.code} - ${e.message}');
        final code = e.code.toLowerCase();
        if (code.contains('module_not_found') ||
            code.contains('not_downloaded') ||
            code.contains('not_available')) {
          throw Exception('Modello AI non ancora pronto.\n\n'
              'Sta scaricando in background (~12MB). '
              'Aspetta 30-60 secondi e riprova.\n\n'
              'Se il problema persiste:\n'
              '1. Verifica connessione internet\n'
              '2. Aggiorna Google Play Services\n'
              '3. Riavvia l\'app');
        }
        rethrow;
      }

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
      debugPrint('[MLKit] Image: ${w}x$h, mask length: ${mask.length}');

      if (mask.length != w * h) {
        throw Exception(
            'Dimensioni mask incompatibili: ${mask.length} vs ${w * h}.');
      }

      // 4. Build output PNG with smooth alpha from mask
      // Using SOFT mapping: full mask value 0..1 → alpha 0..255
      // (no hard threshold, smoother edges)
      final output = img.Image(width: w, height: h, numChannels: 4);
      int strongFgCount = 0;
      for (int y = 0; y < h; y++) {
        for (int x = 0; x < w; x++) {
          final idx = y * w + x;
          final confidence = mask[idx];
          if (confidence > 0.95) strongFgCount++;
          // Soft alpha: keep full color, modulate alpha by confidence
          // Apply a slight curve to make edges sharper but still smooth
          double alpha = confidence;
          if (alpha < 0.05) {
            alpha = 0.0;
          } else if (alpha > 0.95) {
            alpha = 1.0;
          } else {
            // Smoothstep curve for natural transitions
            alpha = alpha * alpha * (3.0 - 2.0 * alpha);
          }
          final alphaByte = (alpha * 255).toInt();
          if (alphaByte > 0) {
            final p = original.getPixel(x, y);
            output.setPixelRgba(x, y, p.r.toInt(), p.g.toInt(), p.b.toInt(), alphaByte);
          } else {
            output.setPixelRgba(x, y, 0, 0, 0, 0);
          }
        }
      }

      if (strongFgCount < 100) {
        throw Exception(
            'Soggetto troppo piccolo. Prova con una foto dove il soggetto occupa più spazio.');
      }

      debugPrint('[MLKit] Strong fg pixels: $strongFgCount / ${w * h}');

      // 5. Optional crop to bounding box
      final finalImage = autoCrop ? _cropToForeground(output) : output;

      return Uint8List.fromList(img.encodePng(finalImage));
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

  /// Find bounding box of non-transparent pixels and crop with 10% padding.
  static img.Image _cropToForeground(img.Image image) {
    int minX = image.width;
    int minY = image.height;
    int maxX = 0;
    int maxY = 0;

    // Use higher alpha threshold for crop bounds (avoids cropping too tight on feathered edges)
    const cropThreshold = 80;
    for (int y = 0; y < image.height; y++) {
      for (int x = 0; x < image.width; x++) {
        final p = image.getPixel(x, y);
        if (p.a > cropThreshold) {
          if (x < minX) minX = x;
          if (y < minY) minY = y;
          if (x > maxX) maxX = x;
          if (y > maxY) maxY = y;
        }
      }
    }

    if (minX >= maxX || minY >= maxY) return image;

    // 10% padding around the subject
    final padX = ((maxX - minX) * 0.10).round();
    final padY = ((maxY - minY) * 0.10).round();
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
