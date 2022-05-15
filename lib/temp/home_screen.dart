// ignore_for_file: must_be_immutable

import 'dart:math';

import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:ketabna/bloc/cubit/auth_cubit.dart';
import 'package:ketabna/core/constants/strings.dart';
import 'package:ketabna/core/models/book_model.dart';
import 'package:ketabna/core/models/intersts_model.dart';
import 'package:ketabna/features/home/widgets/text_with_listview.dart';

class HomeTemp extends StatelessWidget {
  HomeTemp({Key? key}) : super(key: key);
  List<BookModel> reccomendedBooks = [];
  List<BookModel> fantasyInterstBooks = [];
  List<BookModel> fictionInterstBooks = [];
  List<BookModel> horrorInterstBooks = [];
  List<BookModel> novelInterstBooks = [];
  List<BookModel> studingInterstBooks = [];
  List<BookModel> technologyInterstBooks = [];

  @override
  Widget build(BuildContext context) {
    return BlocBuilder<AuthCubit, AuthState>(
      builder: (context, state) {
        var cubit = BlocProvider.of<AuthCubit>(context);

        return Scaffold(
          floatingActionButton: FloatingActionButton.extended(
              onPressed: () {
                cubit.addBook(
                    category: InterstsModel.categorys[
                        Random().nextInt(InterstsModel.categorys.length)],
                    nameAr: ' nameAr',
                    nameEn: ' nameEn',
                    authorName: ' authorName');
              },
              label: Text('Add Book')),
          appBar: AppBar(
            actions: [
              IconButton(
                  onPressed: () {
                    Navigator.pushNamed(
                      context,
                      profileScreen,
                    );
                  },
                  icon: Icon(Icons.person))
            ],
            title: const Text('Home'),
            centerTitle: true,
          ),
          body: SingleChildScrollView(
            child: Column(
              children: [
                TextWithListView(
                    books: cubit.reccomendedBooks, title: 'Recommended'),
                TextWithListView(
                    books: cubit.horrorInterstBooks, title: 'Horror'),
                TextWithListView(
                    books: cubit.technologyInterstBooks, title: 'tech'),
                TextWithListView(
                    books: cubit.fantasyInterstBooks, title: 'fantasy'),
                TextWithListView(
                    books: cubit.fictionInterstBooks, title: 'fiction'),
                TextWithListView(
                    books: cubit.studingInterstBooks, title: 'studying'),
                TextWithListView(
                    books: cubit.novelInterstBooks, title: 'novel'),
                BlocListener<AuthCubit, AuthState>(
                  listener: (context, state) {
                    if (state is BookAddedSuccessState) {
                      ScaffoldMessenger.of(context).showSnackBar(const SnackBar(
                          content: Text('Uploaded Successfully')));
                    }
                  },
                  child: Container(),
                )
              ],
            ),
          ),
        );
      },
    );
  }
}
