import 'package:flutter/material.dart';
import 'package:ketabna/core/models/book_model.dart';
import 'package:ketabna/core/utils/app_colors.dart';
import 'package:firestore_search/firestore_search.dart';
import 'package:ketabna/temp/book_item.dart';

class SearchScreen extends StatelessWidget {
  const SearchScreen({Key? key, required this.searchBy}) : super(key: key);
  final String searchBy;
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: FirestoreSearchScaffold(
        appBarTitle: 'search with $searchBy',
        scaffoldBody: const Center(
          child: Text('No searched items'),
        ),
        appBarBackgroundColor: AppColors.mainColor,
        backButtonColor: AppColors.mainColor,
        firestoreCollectionName: 'books',
        searchBy: searchBy,
        dataListFromSnapshot: BookModel().dataListFromSnapshot,
        builder: (context, snapshot) {
          if (snapshot.hasData) {
            final List<BookModel>? dataList = snapshot.data;
            if (dataList!.isEmpty) {
              return const Center(
                child: Text('No Results Returned'),
              );
            }
            return Wrap(
              children: dataList
                  .map((e) => Padding(
                padding: const EdgeInsets.all(8.0),
                child: BookItem(
                  bookModel: e,
                ),
              ))
                  .toList(),
            );
          }
          if (snapshot.connectionState == ConnectionState.done) {
            if (!snapshot.hasData) {
              return const Center(
                child: Text('No Results Returned'),
              );
            }
          }
          return const Center(
            child: CircularProgressIndicator(),
          );
        },
      ),
    );
  }
}
