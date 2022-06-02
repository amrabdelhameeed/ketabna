import 'dart:io';

import 'package:flutter/material.dart';
import 'package:ketabna/core/widgets/components.dart';
import 'package:ketabna/features/store/pdf_api.dart';
import 'package:ketabna/features/store/pdf_viewer.dart';

import '../../core/utils/app_colors.dart';

List<String> books=[
  'compiler',
  'simulation',
  'book_scientific_computing',
];

class SemesterBooks extends StatelessWidget {
  const SemesterBooks({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        backgroundColor: Colors.transparent,
        title: const Text(
          'Your Books',
          style: TextStyle(color: Colors.black87),
        ),
        centerTitle: true,
        elevation: 0.0,
        iconTheme: const IconThemeData(
          color: AppColors.secondaryColor,
          size: 32,
        ),
      ),
      body:ListView.builder(
          itemCount: 3,
          itemBuilder: (BuildContext context,int index){
            late String? gradeNumber = (index+1).toString();
            return InkWell(
              onTap: () async {
                  final path = 'assets/${books[index]}.pdf';
                  final filePdf = await PdfApi.loadAsset(path);
                  openPdf(context, filePdf);
                },
              child: Card(
                elevation: 2,
                shadowColor: AppColors.secondaryColor,
                child: ListTile(
                  leading: CircleAvatar(
                    child: Text(gradeNumber,style: const TextStyle(color: AppColors.mainColor),),
                    backgroundColor: AppColors.secondaryColor,
                    radius: 20,
                  ),
                  title: Text(
                    books[index],
                    style: TextStyle(color: Colors.black),
                  ),
                ),
              ),
            );
          }
      )
    );
  }

  void openPdf(BuildContext context, File file) {
    navigateTo(context: context,widget: PdfViewerPage(file: file),);
  }
}
// Center(
// child: ElevatedButton(
// onPressed: () async {
// const path='assets/data.pdf';
// final filePdf=await PdfApi.loadAsset(path);
// openPdf(context,filePdf);
// }, child: const Text('let\'s go'),
// ),
// ),