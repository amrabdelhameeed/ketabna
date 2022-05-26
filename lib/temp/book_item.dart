import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:ketabna/core/models/book_model.dart';

import '../features/chat/chat_screen.dart';

/*
list view in recommended in home screen
 */
class BookItem extends StatelessWidget {
  const BookItem({Key? key, required this.bookModel}) : super(key: key);
  final BookModel bookModel;

  @override
  Widget build(BuildContext context) {
    return InkWell(
      onTap: () async {
        String ownerUid = bookModel.ownerUid.toString();
        String ownerName = '';
        await FirebaseFirestore.instance
            .collection('users')
            .doc(ownerUid)
            .get()
            .then((value) => {ownerName = value['name']});
        Navigator.push(
            context,
            MaterialPageRoute(
                builder: (context) => ChatScreen(
                      ownerName: ownerName,
                      ownerUid: ownerUid,
                    )));
      },
      child: SizedBox(
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
