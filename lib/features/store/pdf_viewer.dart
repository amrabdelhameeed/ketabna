import'dart:io';
import'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_windowmanager/flutter_windowmanager.dart';
import 'package:path/path.dart';
import 'package:uc_pdfview/uc_pdfview.dart';

import '../../core/utils/app_colors.dart';

class PdfViewerPage extends StatefulWidget {
  const PdfViewerPage({Key? key, required this.file}) : super(key: key);
  final File file;

  @override
  _PdfViewerPageState createState() => _PdfViewerPageState();
}

class _PdfViewerPageState extends State<PdfViewerPage> {
  preventScreenShot()async{
    print('start secure');
    await FlutterWindowManager.addFlags(FlutterWindowManager.FLAG_SECURE);
  }
  @override
  void initState() {
    preventScreenShot();
    super.initState();
  }
  late PDFViewController pdfViewController;
  int pages=0;
  int indexPages=0;
  @override
  Widget build(BuildContext context) {
    final name = basename(widget.file.path);
    final text = '${indexPages + 1}of $pages';
    return Scaffold(
      appBar: AppBar(
        backgroundColor: Colors.transparent,
        title: Text(
          name,
          style: const TextStyle(color: Colors.black87),
        ),
        elevation: 0.0,
        iconTheme: const IconThemeData(
          color: AppColors.secondaryColor,
          size: 32,
        ),
        actions: pages>=0? [
          Center(child: Text(text),),
          IconButton(onPressed: (){
            final page=indexPages == 0 ?pages:indexPages+1;
            pdfViewController.setPage(page);
          }, icon: const Icon(Icons.chevron_left),),
          IconButton(onPressed: (){
            final page=indexPages == pages -1  ? 0 :indexPages+1;
            pdfViewController.setPage(page);
          }, icon: const Icon(Icons.chevron_right),),
        ]: null,
      ),
      body: UCPDFView(
        filePath: widget.file.path,
        onRender: (pages)=>setState(()=>this.pages = pages!),
        onViewCreated: (pdfViewController)=>this.pdfViewController = pdfViewController,
        onPageChanged: (indexPages,_)=>setState(()=>this.indexPages = indexPages!),
      ),
    );
  }
}

