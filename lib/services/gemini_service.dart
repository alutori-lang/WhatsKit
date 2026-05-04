import 'dart:convert';
import 'package:flutter/foundation.dart';
import 'package:http/http.dart' as http;
import 'package:image/image.dart' as img;

class GeminiService {
  static const String _apiKey = String.fromEnvironment('GEMINI_API_KEY');
  static const String _baseUrl = 'https://generativelanguage.googleapis.com/v1beta';

  // Try multiple model names — Gemini image generation models have been renamed
  // a few times. We try the GA name first, then the preview name.
  static const List<String> _imageModels = [
    'gemini-2.5-flash-image',
    'gemini-2.5-flash-image-preview',
    'gemini-2.0-flash-exp-image-generation',
  ];

  static bool get hasApiKey => _apiKey.isNotEmpty;

  /// Resizes the image to max 1024px on the longest side and re-encodes as PNG.
  static Uint8List _resizeForUpload(Uint8List bytes) {
    final decoded = img.decodeImage(bytes);
    if (decoded == null) {
      throw Exception('Immagine non valida o formato non supportato.');
    }
    img.Image resized = decoded;
    const maxSize = 1024;
    if (decoded.width > maxSize || decoded.height > maxSize) {
      if (decoded.width >= decoded.height) {
        resized = img.copyResize(decoded, width: maxSize);
      } else {
        resized = img.copyResize(decoded, height: maxSize);
      }
    }
    return Uint8List.fromList(img.encodePng(resized));
  }

  /// Removes the background using Gemini image editing.
  /// Tries multiple model names until one works.
  static Future<Uint8List> removeBackground(Uint8List imageBytes) async {
    if (_apiKey.isEmpty) {
      throw Exception(
        'GEMINI_API_KEY non configurata.\n'
        'Compila con: --dart-define=GEMINI_API_KEY=la_tua_chiave',
      );
    }

    final resized = _resizeForUpload(imageBytes);
    debugPrint('[Gemini] Image resized: ${imageBytes.length} → ${resized.length} bytes');

    Object? lastError;
    for (final model in _imageModels) {
      try {
        debugPrint('[Gemini] Trying model: $model');
        final result = await _callImageApi(
          model: model,
          imageBytes: resized,
          prompt:
              'Remove the background from this image completely. Keep only the main subject. '
              'Output a clean cutout with transparent or pure white background. '
              'Make it square format suitable for a WhatsApp sticker.',
        );
        debugPrint('[Gemini] Success with model: $model');
        return result;
      } catch (e) {
        debugPrint('[Gemini] Model $model failed: $e');
        lastError = e;
        continue;
      }
    }
    throw Exception('Tutti i modelli AI hanno fallito.\n\nUltimo errore: $lastError');
  }

  static Future<Uint8List> _callImageApi({
    required String model,
    required Uint8List imageBytes,
    required String prompt,
  }) async {
    final url = Uri.parse('$_baseUrl/models/$model:generateContent?key=$_apiKey');

    final body = {
      'contents': [
        {
          'parts': [
            {
              'inline_data': {
                'mime_type': 'image/png',
                'data': base64Encode(imageBytes),
              }
            },
            {'text': prompt},
          ]
        }
      ],
      'generationConfig': {
        'responseModalities': ['IMAGE', 'TEXT'],
      }
    };

    final response = await http
        .post(
          url,
          headers: {'Content-Type': 'application/json'},
          body: jsonEncode(body),
        )
        .timeout(const Duration(seconds: 60));

    if (response.statusCode != 200) {
      // Extract user-friendly error from Gemini API response
      String errorMsg = 'HTTP ${response.statusCode}';
      try {
        final json = jsonDecode(response.body) as Map<String, dynamic>;
        final error = json['error'] as Map<String, dynamic>?;
        if (error != null) {
          errorMsg = '${error['message'] ?? errorMsg}';
        }
      } catch (_) {
        errorMsg = '$errorMsg: ${response.body.substring(0, response.body.length > 200 ? 200 : response.body.length)}';
      }
      throw Exception(errorMsg);
    }

    final json = jsonDecode(response.body) as Map<String, dynamic>;
    final candidates = json['candidates'] as List?;
    if (candidates == null || candidates.isEmpty) {
      // Check for prompt feedback (safety filtering, etc.)
      final feedback = json['promptFeedback'] as Map<String, dynamic>?;
      if (feedback != null) {
        final blockReason = feedback['blockReason'];
        if (blockReason != null) {
          throw Exception('Immagine bloccata: $blockReason');
        }
      }
      throw Exception('Nessun risultato dall\'AI.');
    }

    final candidate = candidates[0] as Map<String, dynamic>;
    final finishReason = candidate['finishReason'];
    final content = candidate['content'] as Map<String, dynamic>?;
    if (content == null) {
      throw Exception('Risposta vuota (finishReason: $finishReason).');
    }

    final parts = content['parts'] as List?;
    if (parts == null || parts.isEmpty) {
      throw Exception('Nessuna parte nella risposta.');
    }

    for (final part in parts) {
      final inlineData = (part['inline_data'] ?? part['inlineData']) as Map<String, dynamic>?;
      if (inlineData != null && inlineData['data'] != null) {
        return base64Decode(inlineData['data'] as String);
      }
    }

    // No image part — log text part if any for debugging
    for (final part in parts) {
      if (part['text'] != null) {
        debugPrint('[Gemini] Got text instead of image: ${part['text']}');
      }
    }
    throw Exception('AI ha risposto con testo invece di un\'immagine. Prova con una foto più chiara.');
  }

  /// Generates a sticker from a text prompt (creative mode).
  static Future<Uint8List> generateStickerFromPrompt(String prompt) async {
    if (_apiKey.isEmpty) {
      throw Exception('GEMINI_API_KEY non configurata.');
    }

    Object? lastError;
    for (final model in _imageModels) {
      try {
        // For text-only prompts we still call the same API but without the image part
        final url = Uri.parse('$_baseUrl/models/$model:generateContent?key=$_apiKey');
        final body = {
          'contents': [
            {
              'parts': [
                {
                  'text':
                      'Generate a fun WhatsApp sticker: $prompt. Style: cartoon, vibrant colors, '
                          'transparent background, sticker-style with thick white outline. Square 512x512.',
                },
              ]
            }
          ],
          'generationConfig': {
            'responseModalities': ['IMAGE', 'TEXT'],
          }
        };
        final response = await http.post(
          url,
          headers: {'Content-Type': 'application/json'},
          body: jsonEncode(body),
        );
        if (response.statusCode != 200) {
          throw Exception('HTTP ${response.statusCode}: ${response.body}');
        }
        final json = jsonDecode(response.body) as Map<String, dynamic>;
        final candidates = json['candidates'] as List?;
        if (candidates == null || candidates.isEmpty) throw Exception('No candidates');
        final parts = (candidates[0]['content']['parts']) as List;
        for (final part in parts) {
          final inlineData = part['inline_data'] ?? part['inlineData'];
          if (inlineData != null && inlineData['data'] != null) {
            return base64Decode(inlineData['data'] as String);
          }
        }
        throw Exception('No image in response');
      } catch (e) {
        lastError = e;
        continue;
      }
    }
    throw Exception('Generazione fallita: $lastError');
  }
}
