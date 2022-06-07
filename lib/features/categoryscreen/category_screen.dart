import 'package:flutter/material.dart';
import 'package:ketabna/core/models/book_model.dart';
import 'package:ketabna/features/home/widgets/bookitem.dart';
import '../../core/constants/strings.dart';
import '../../core/models/book_model.dart';
import '../../core/utils/size_config.dart';

class CategoryScreen extends StatelessWidget {
  CategoryScreen({Key? key, required this.categoryName, required this.book})
      : super(key: key);
  final String? categoryName;
  List<BookModel> book;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        centerTitle: true,
        elevation: 0.0,
        backgroundColor: Colors.transparent,
        iconTheme: const IconThemeData(
          color: Color(0xfff5b53f),
          size: 25,
        ),
        title: Text(
          categoryName!,
          textAlign: TextAlign.center,
          style: const TextStyle(
            fontSize: 25,
            color: Color(0xfff5b53f),
          ),
        ),
      ),
      body: Padding(
        padding: const EdgeInsets.symmetric(horizontal: 15),

        child: Wrap(
          children: book
              .map((e) => InkWell(
                  onTap: () {
                    Navigator.pushNamed(context, bookScreen, arguments: e);
                  },
                  child: Padding(
                    padding: const EdgeInsets.all(8.0),
                    child: BookItem(bookModel: e),
                  )))
              .toList(),
        ),
      ),
    );
  }
}
