import 'package:flutter/material.dart';
import 'package:ketabna/core/models/book_model.dart';
import 'package:ketabna/features/home/widgets/book_item.dart';

class CustomListView extends StatelessWidget {
  const CustomListView({
    Key? key,
    required this.books,
  }) : super(key: key);
  final List<BookModel> books;
  @override
  Widget build(BuildContext context) {
    return SizedBox(
      height: 250,
      child: ListView.separated(
        itemBuilder: (context, index) {
          return BookItem(bookModel: books[index]);
        },
        separatorBuilder: (context, index) {
          return const SizedBox(
            width: 5,
          );
        },
        itemCount: books.length,
        shrinkWrap: true,
        scrollDirection: Axis.horizontal,
        physics: const BouncingScrollPhysics(),
      ),
    );
  }
}
