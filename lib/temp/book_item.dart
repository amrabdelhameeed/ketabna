import 'package:flutter/material.dart';
import 'package:ketabna/core/models/book_model.dart';

class BookItem extends StatelessWidget {
  const BookItem({Key? key, required this.bookModel}) : super(key: key);
  final BookModel bookModel;
  @override
  Widget build(BuildContext context) {
    return SizedBox(
      width: 120,
      height: 130,
      child: Column(
        children: [
          Container(
            decoration: BoxDecoration(
                image: bookModel.picture != ""
                    ? DecorationImage(
                        image: NetworkImage(
                          bookModel.picture!,
                        ),
                        fit: BoxFit.fill,
                      )
                    : const DecorationImage(
                        image: AssetImage(
                          'assets/image/Books.png',
                        ),
                      ),
                borderRadius: BorderRadius.circular(13),
                border: Border.all(width: 1)),
            height: 170,
          ),
          Text(
            bookModel.name!,
            overflow: TextOverflow.ellipsis,
            maxLines: 2,
            textAlign: TextAlign.center,
            style: const TextStyle(fontSize: 16, fontWeight: FontWeight.bold),
          ),
          Text(
            bookModel.authorName!,
            overflow: TextOverflow.ellipsis,
            style: const TextStyle(fontSize: 12, fontWeight: FontWeight.w300),
          )
        ],
      ),
    );
  }
}
/*
FadeInImage(
                    fit: BoxFit.fill,
                    height: 150,
                    placeholder: const AssetImage('assets/image/Books.png'),
                    image: NetworkImage(bookModel.picture!),
                  )

 */