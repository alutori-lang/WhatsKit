import 'dart:convert';
import 'dart:typed_data';
import 'package:http/http.dart' as http;

class GeminiService {
  static const String _apiKey = String.fromEnvironment('GEMINI_API_KEY');
  static const String _model = 'gemini-2.5-flash-image-preview';
  static const String _baseUrl = 'https://generativelanguage.googleapis.com/v1beta';

  static bool get hasApiKey => _apiKey.isNotEmpty;

  /// Removes the background from an image using Gemini's image editing model.
  /// Returns the edited image bytes (PNG with transparent or white background).
  /// Throws on failure with a user-friendly message.
  static Future<Uint8List> removeBackground(Uint8List imageBytes) async {
    if (_apiKey.isEmpty) {
      throw Exception(
        'GEMINI_API_KEY non configurata. Compila con:\n'
        '--dart-define=GEMINI_API_KEY=la_tua_chiave',
      );
    }

    final url = Uri.parse('$_baseUrl/models/$_model:generateContent?key=$_apiKey');

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
            {
              'text':
                  'Remove the background from this image completely. Keep only the main subject (person, object, animal). '
                      'The output should be a clean cutout with a fully transparent background. '
                      'Do not add any new elements. Output a high-quality PNG suitable for a WhatsApp sticker.',
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
      final errorBody = response.body;
      throw Exception('Errore API (${response.statusCode}): $errorBody');
    }

    final json = jsonDecode(response.body) as Map<String, dynamic>;
    final candidates = json['candidates'] as List?;
    if (candidates == null || candidates.isEmpty) {
      throw Exception('Nessuna immagine generata dall\'AI.');
    }

    final parts = candidates[0]['content']['parts'] as List;
    for (final part in parts) {
      final inlineData = part['inline_data'] ?? part['inlineData'];
      if (inlineData != null && inlineData['data'] != null) {
        return base64Decode(inlineData['data'] as String);
      }
    }

    throw Exception('Risposta AI senza immagine. Riprova con una foto più chiara.');
  }

  /// Generates a custom sticker from a text prompt (e.g. "cute cat with glasses").
  static Future<Uint8List> generateStickerFromPrompt(String prompt) async {
    if (_apiKey.isEmpty) {
      throw Exception('GEMINI_API_KEY non configurata.');
    }

    final url = Uri.parse('$_baseUrl/models/$_model:generateContent?key=$_apiKey');

    final body = {
      'contents': [
        {
          'parts': [
            {
              'text':
                  'Generate a fun WhatsApp sticker: $prompt. '
                      'Style: cartoon, vibrant colors, transparent background, sticker-style with thick white outline. '
                      'Square format, 512x512.',
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
      throw Exception('Errore API (${response.statusCode}): ${response.body}');
    }

    final json = jsonDecode(response.body) as Map<String, dynamic>;
    final candidates = json['candidates'] as List?;
    if (candidates == null || candidates.isEmpty) {
      throw Exception('Nessuna immagine generata.');
    }

    final parts = candidates[0]['content']['parts'] as List;
    for (final part in parts) {
      final inlineData = part['inline_data'] ?? part['inlineData'];
      if (inlineData != null && inlineData['data'] != null) {
        return base64Decode(inlineData['data'] as String);
      }
    }

    throw Exception('Generazione fallita.');
  }
}
