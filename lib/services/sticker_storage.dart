import 'dart:io';
import 'dart:typed_data';
import 'package:path_provider/path_provider.dart';

class StickerStorage {
  static Future<Directory> _stickerDir() async {
    final docs = await getApplicationDocumentsDirectory();
    final dir = Directory('${docs.path}/stickers');
    if (!await dir.exists()) {
      await dir.create(recursive: true);
    }
    return dir;
  }

  static Future<File> save(Uint8List bytes) async {
    final dir = await _stickerDir();
    final file = File('${dir.path}/sticker_${DateTime.now().millisecondsSinceEpoch}.png');
    await file.writeAsBytes(bytes);
    return file;
  }

  static Future<List<File>> list() async {
    final dir = await _stickerDir();
    final files = await dir
        .list()
        .where((e) => e is File && e.path.endsWith('.png'))
        .cast<File>()
        .toList();
    files.sort((a, b) => b.path.compareTo(a.path));
    return files;
  }

  static Future<void> delete(File file) async {
    if (await file.exists()) {
      await file.delete();
    }
  }
}
