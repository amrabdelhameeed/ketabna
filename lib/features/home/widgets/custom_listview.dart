import 'package:conditional_builder_null_safety/conditional_builder_null_safety.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';

import '../../../core/models/book_model.dart';
import 'bookitem.dart';

class CustomListView extends StatelessWidget {
  const CustomListView({Key? key, required this.listOfBook}) : super(key: key);
  final List<BookModel> listOfBook;

  @override
  Widget build(BuildContext context) {
    return ConditionalBuilder(
      condition: listOfBook.isNotEmpty,
      builder:(context) =>  SizedBox(
        height: MediaQuery.of(context).size.height / 3,
        child: ListView.separated(
          physics:const BouncingScrollPhysics(),
          scrollDirection: Axis.horizontal,
          itemBuilder: (context, index) => BookItem(bookModel: listOfBook[index]),
          separatorBuilder: (context, index) => const SizedBox(
            width: 0,
          ),
          itemCount: listOfBook.length,
        ),
      ),
      fallback: (context) => SizedBox(
          height: MediaQuery.of(context).size.height / 3,
          child: const Center(child: CircularProgressIndicator(
            color: Color(0xfff5b53f),
          ))),
    );
  }
}
