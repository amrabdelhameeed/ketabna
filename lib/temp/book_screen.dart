// ignore_for_file: prefer_const_constructors

import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:ketabna/bloc/cubit/auth_cubit.dart';
import 'package:ketabna/core/models/book_model.dart';
import 'package:ketabna/core/models/request_model.dart';

class BookScreen extends StatelessWidget {
  const BookScreen({Key? key, required this.bookModel}) : super(key: key);
  final BookModel bookModel;
  @override
  Widget build(BuildContext context) {
    return BlocBuilder<AuthCubit, AuthState>(
      builder: (context, state) {
        var cubit = AuthCubit.get(context);
        return Scaffold(
          body: Column(
            // ignore: prefer_const_literals_to_create_immutables
            children: [
              SizedBox(
                height: 200,
                child: bookModel.picture != null
                    ? Image.network(
                        bookModel.picture!,
                        fit: BoxFit.cover,
                      )
                    : SizedBox(
                        child: CircularProgressIndicator(),
                      ),
              ),
              ElevatedButton(
                  onPressed: () {
                    cubit.makeRequest(
                        requestModel: RequestModel(
                            senderUid: cubit.instance.currentUser!.uid,
                            reciverUid: bookModel.ownerUid,
                            bookId: bookModel.bookId));
                  },
                  child: Text("Request"))
            ],
          ),
        );
      },
    );
  }
}
