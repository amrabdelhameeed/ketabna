import 'package:flutter/material.dart';
import 'package:ketabna/core/constants/constants.dart';
import 'package:ketabna/core/models/book_model.dart';
import 'package:ketabna/features/home/widgets/custom_listview.dart';

class TextWithListView extends StatelessWidget {
  const TextWithListView({Key? key, required this.books, required this.title})
      : super(key: key);
  final List<BookModel> books;

  final String title;
  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        Text(
          title,
          style: textStyleBig,
        ),
        books.isNotEmpty
            ? CustomListView(
                books: books,
              )
            : const Text('There is no items'),
      ],
    );
  }
}
