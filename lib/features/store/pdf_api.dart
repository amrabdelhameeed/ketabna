import 'dart:io';
import 'package:flutter/services.dart';
import 'package:path/path.dart';
import 'dart:async';
import 'package:path_provider/path_provider.dart';

class PdfApi {
  static Future<File> loadAsset(String path) async {
    final data = await rootBundle.load(path);
    final bytes = data.buffer.asUint8List();
    return _storeFiles(path, bytes);
  }

  static Future<File> _storeFiles(String url, List<int> bytes) async {
    final fileName = basename(url);
    final dir = await getApplicationDocumentsDirectory();
    final file =File('${dir.path}/$fileName');
    await file.writeAsBytes(bytes ,flush: true);
    return file;
  }
}
