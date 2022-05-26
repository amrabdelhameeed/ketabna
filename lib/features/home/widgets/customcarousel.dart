import 'package:carousel_slider/carousel_slider.dart';
import 'package:conditional_builder_null_safety/conditional_builder_null_safety.dart';
import 'package:flutter/material.dart';
import 'package:ketabna/core/models/book_model.dart';
import 'package:ketabna/temp/book_item.dart';

class CustomCarousel extends StatelessWidget {
  final List<BookModel> listOfBookModel;
  const CustomCarousel({Key? key, required this.listOfBookModel}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return ConditionalBuilder(
      condition: listOfBookModel.isNotEmpty,
      builder: (context) => CarouselSlider.builder(
          itemCount:listOfBookModel.length,
          itemBuilder: (context, index, realIndex) =>BookItem(bookModel: listOfBookModel[index]),
          options: CarouselOptions(
            height: MediaQuery.of(context).size.height / 3,
            viewportFraction: 0.5,
            enlargeCenterPage: true,
            autoPlay: true,
          )),
      fallback: (context) =>   SizedBox(
          height: MediaQuery.of(context).size.height / 3,
          child: const Center(child: CircularProgressIndicator(
            color: Color(0xfff5b53f),
          ))) ,
    );
  }
}
