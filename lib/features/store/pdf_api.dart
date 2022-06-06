import 'dart:io';
import 'package:firebase_storage/firebase_storage.dart';
import 'package:path/path.dart';
import 'dart:async';
import 'package:path_provider/path_provider.dart';
import 'package:http/http.dart' as http;

class PdfApi {

  static Future<File>loadNetwork(Uri url)async{
    final response=await http.get(url);
    final bytes=response.bodyBytes;
    return _storeFiles(url.toString(),bytes);
  }

  static Future<File> _storeFiles(String url, List<int> bytes) async {
    final fileName = basename(url);
    final dir = await getApplicationDocumentsDirectory();
    final file =File('${dir.path}/$fileName');
    await file.writeAsBytes(bytes ,flush: true);
    return file;
  }
}
