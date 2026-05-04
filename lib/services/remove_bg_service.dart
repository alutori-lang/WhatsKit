import 'dart:io';
import 'package:flutter/foundation.dart';
import 'package:http/http.dart' as http;

class RemoveBgService {
  static const String _apiKey = String.fromEnvironment('REMOVE_BG_API_KEY');
  static const String _endpoint = 'https://api.remove.bg/v1.0/removebg';

  static bool get hasApiKey => _apiKey.isNotEmpty;

  /// Quota info from response headers (populated after each call).
  static int? lastQuotaRemaining;
  static int? lastQuotaTotal;

  /// Calls remove.bg API and returns raw cutout PNG bytes (transparent bg).
  /// Throws on failure.
  static Future<Uint8List> removeBackground(String imagePath) async {
    if (_apiKey.isEmpty) {
      throw Exception('REMOVE_BG_API_KEY non configurata.');
    }

    final imageFile = File(imagePath);
    if (!await imageFile.exists()) {
      throw Exception('File immagine non trovato.');
    }

    final request = http.MultipartRequest('POST', Uri.parse(_endpoint));
    request.headers['X-Api-Key'] = _apiKey;
    request.headers['Accept'] = 'image/png';
    request.fields['size'] = 'auto'; // auto, preview, full
    request.fields['format'] = 'png';
    request.files.add(await http.MultipartFile.fromPath(
      'image_file',
      imagePath,
      filename: 'input.${imagePath.split('.').last}',
    ));

    debugPrint('[RemoveBg] Sending image (${(await imageFile.length()) ~/ 1024}KB)...');
    final streamedResponse = await request.send().timeout(const Duration(seconds: 60));

    // Read quota info from headers
    final remaining = streamedResponse.headers['x-credits-charged'];
    final total = streamedResponse.headers['x-credits-total'];
    if (remaining != null) {
      try {
        lastQuotaRemaining = int.parse(remaining);
      } catch (_) {}
    }
    if (total != null) {
      try {
        lastQuotaTotal = int.parse(total);
      } catch (_) {}
    }

    if (streamedResponse.statusCode == 200) {
      final bytes = await streamedResponse.stream.toBytes();
      debugPrint('[RemoveBg] OK: ${bytes.length} bytes');
      return bytes;
    }

    final errorBody = await streamedResponse.stream.bytesToString();
    debugPrint('[RemoveBg] Error ${streamedResponse.statusCode}: $errorBody');

    if (streamedResponse.statusCode == 402) {
      throw Exception(
          'Quota mensile remove.bg esaurita (50 sticker/mese gratis).\n'
          'Aspetta il prossimo mese o usa la modalità offline (ML Kit).');
    } else if (streamedResponse.statusCode == 403) {
      throw Exception('API key remove.bg non valida o disabilitata.');
    } else if (streamedResponse.statusCode == 429) {
      throw Exception('Troppi tentativi remove.bg. Aspetta un attimo e riprova.');
    } else {
      throw Exception('Errore remove.bg ${streamedResponse.statusCode}: $errorBody');
    }
  }
}
