import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:firebase_core/firebase_core.dart';
import 'package:flutter/material.dart';
import 'package:ketabna/core/models/book_model.dart';

import '../features/chat/chat_screen.dart';

/*
list view in recommended in home screen
 */
String conversationDocId = '';
final _firestore = FirebaseFirestore.instance;
final String? _auth = FirebaseAuth.instance.currentUser?.uid.toString();

class BookItem extends StatelessWidget {
  const BookItem({Key? key, required this.bookModel}) : super(key: key);
  final BookModel bookModel;


  @override
  Widget build(BuildContext context) {
    final myId = FirebaseAuth.instance.currentUser?.uid.toString();

    return InkWell(
      onTap: () async {
        String ownerUid = bookModel.ownerUid.toString();
        String ownerName = '';
        await FirebaseFirestore.instance
            .collection('users')
            .doc(ownerUid)
            .get()
            .then((value) => {ownerName = value['name']});
        checkForOldConversation(ownerUid: ownerUid,myId:myId ).then((value) => {
          Navigator.push(
              context,
              MaterialPageRoute(
                  builder: (context) => ChatScreen(
                        ownerName: ownerName,
                        ownerUid: ownerUid,
                        conversationDocId: conversationDocId,
                      )))
        });

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
Future<bool> checkForOldConversation(
    {ownerUid, myId}) async {
  String ids;
  bool containUid_1 = false;
  bool containUid_2 = false;
  bool oldchat = false;
  try {
    await FirebaseFirestore.instance
        .collection("chats")
        .get()
        .then((value) => {
      value.docs.forEach((element) {
        ids = element.data()['ids'].toString();
        containUid_1 = ids.contains(ownerUid);
        containUid_2 = ids.contains(myId);
        if (containUid_1 && containUid_2) {
          print("element.id : "+element.id);
          conversationDocId = element.id;
        }
        oldchat = true;
      })
    });
  } catch (error) {
    print(error.toString());
  }
  if (!oldchat) {
     await setNewConversation(ownerUid);
  }
  return containUid_1;
}
Future setNewConversation(ownerUid) async {
  await _firestore.collection("chats").add({
    'ids': [
      ownerUid,
      _auth,
    ],
    'messages': [],
    'readedMessages': 0,
    'totalMessages': 0,
  }).then((documentSnapshot) => {
    print("Added Data with ID: ${documentSnapshot.id}"),
    conversationDocId = documentSnapshot.id,
  });
}