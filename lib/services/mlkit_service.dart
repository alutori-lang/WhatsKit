import 'dart:io';
import 'package:flutter/foundation.dart';
import 'package:flutter/services.dart';
import 'package:google_mlkit_subject_segmentation/google_mlkit_subject_segmentation.dart';
import 'package:image/image.dart' as img;
import 'package:path_provider/path_provider.dart';

class MLKitService {
  /// Removes the background using on-device ML Kit Subject Segmentation.
  /// Returns the raw cutout PNG (with transparent background) at the resized
  /// dimensions. Use [StickerFormatter] to format as a 512x512 sticker.
  ///
  /// Free, offline, no API key required. Quality is lower than remove.bg.
  static Future<Uint8List> removeBackground(String imagePath) async {
    final resizedPath = await _resizeImage(imagePath);

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
          throw Exception('Modello AI offline non ancora pronto.\n\n'
              'Aspetta 30-60 secondi (download in background ~12MB) e riprova.');
        }
        rethrow;
      }

      final mask = result.foregroundConfidenceMask;
      if (mask == null || mask.isEmpty) {
        throw Exception(
            'Nessun soggetto rilevato. Prova con una foto più chiara.');
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

      // Apply mask with sticker-style sharp edges
      final cutout = img.Image(width: w, height: h, numChannels: 4);
      int strongFgCount = 0;
      for (int y = 0; y < h; y++) {
        for (int x = 0; x < w; x++) {
          final c = mask[y * w + x];
          if (c > 0.95) strongFgCount++;
          int alphaByte;
          if (c < 0.4) {
            alphaByte = 0;
          } else if (c > 0.7) {
            alphaByte = 255;
          } else {
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
        throw Exception('Soggetto troppo piccolo nella foto.');
      }

      return Uint8List.fromList(img.encodePng(cutout));
    } finally {
      await segmenter.close();
    }
  }

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
}
