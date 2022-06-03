import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
// import 'package:firebase_core/firebase_core.dart';
import 'package:flutter/material.dart';
import 'package:ketabna/core/models/book_model.dart';
import 'package:ketabna/core/widgets/components.dart';

import '../core/utils/shared_pref_helper.dart';
import '../features/chat/chat_screen.dart';

/*
list view in recommended in home screen
 */
String conversationDocId = '';
final _firestore = FirebaseFirestore.instance;
final String? myUid = FirebaseAuth.instance.currentUser?.uid.toString();
final myName = SharedPrefHelper.getStr(key: 'userName');


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
        checkForOldConversation(bookOwnerUid: ownerUid,myId:myUid ).then((value) => {
          navigateTo(context : context , widget :ChatScreen(
            ownerName: ownerName,
            ownerUid: ownerUid,
            conversationDocId: value,
          )),

        });

      },
      child: SizedBox(
        height: MediaQuery.of(context).size.height / 3,
        width: 130,
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            Expanded(
              child: Container(
                decoration: BoxDecoration(
                    image: bookModel.picture != ""
                        ? DecorationImage(
                      image: NetworkImage(
                        bookModel.picture!,
                      ),
                      fit: BoxFit.cover,
                    )
                        : const DecorationImage(
                      image: AssetImage(
                        'assets/image/Books.png',
                      ),
                    ),
                    borderRadius: BorderRadius.circular(13),
                    border: Border.all(width: 1)),
                height: 140,
              ),
            ),


            Text(
              '${bookModel.name}',
              style: const TextStyle(fontSize: 16, fontWeight: FontWeight.bold),
              overflow: TextOverflow.ellipsis,
              textAlign: TextAlign.center,
              maxLines: 3,
            ),

            Text(
              '${bookModel.authorName}',
              style: TextStyle( color: Colors.grey[500],fontSize: 12, fontWeight: FontWeight.w300),
              maxLines: 2,
              overflow: TextOverflow.ellipsis,
              textAlign: TextAlign.center,
            ),
          ],
        ),
      ),
      // child: SizedBox(
      //   width: 120,
      //   height: 130,
      //   child: Column(
      //     children: [
      //       Container(
      //         decoration: BoxDecoration(
      //             boxShadow: [
      //               BoxShadow(
      //                   color: Colors.black.withOpacity(0.5),
      //                   blurStyle: BlurStyle.normal,
      //                   blurRadius: 10,
      //                   offset: Offset(6 , 3))
      //             ],
      //             image: bookModel.picture != ""
      //                 ? DecorationImage(
      //                     image: NetworkImage(
      //                       bookModel.picture!,
      //                     ),
      //                     fit: BoxFit.fill,
      //                   )
      //                 : const DecorationImage(
      //                     image: AssetImage(
      //                       'assets/image/Books.png',
      //                     ),
      //                   ),
      //             borderRadius: BorderRadius.circular(13),
      //             border: Border.all(width: 1)),
      //         height: 170,
      //       ),
      //       Text(
      //         bookModel.name!,
      //         overflow: TextOverflow.ellipsis,
      //         maxLines: 2,
      //         textAlign: TextAlign.center,
      //         style: const TextStyle(fontSize: 16, fontWeight: FontWeight.bold),
      //       ),
      //       Text(
      //         bookModel.authorName!,
      //         overflow: TextOverflow.ellipsis,
      //         style: TextStyle( color: Colors.grey[500],fontSize: 12, fontWeight: FontWeight.w300),
      //       )
      //     ],
      //   ),
      // ),
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
Future<String> checkForOldConversation(
    {bookOwnerUid,bookOwnerName, myId}) async {
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
        final numberOfMessagesOfChat = element.data()['messages'].length;
        containUid_1 = ids.contains(bookOwnerUid);
        containUid_2 = ids.contains(myId);

        if (containUid_1 && containUid_2) {
          conversationDocId = element.id;
          _firestore.collection('chats').doc(conversationDocId).update({
            'readed_messages':{
              '$myId':'$numberOfMessagesOfChat',
            },
          });
        }

        oldchat = true;
      })
    });
  } catch (error) {
    print(error.toString());
  }
  if (!oldchat) {
     await setNewConversation(bookOwnerUid:bookOwnerUid,bookOwnerName: bookOwnerName);
  }
  return conversationDocId;
}
Future setNewConversation({bookOwnerUid, bookOwnerName}) async {
  await _firestore.collection("chats").add({
    'names':[bookOwnerName,myName],
    'ids': [
      bookOwnerUid,
      myUid,
    ],
    'messages': [],
    'readed_messages': {
      '$bookOwnerUid':'0',
      '$myUid':'0',
    },

  }).then((documentSnapshot) => {
    print("Added Data with ID: ${documentSnapshot.id}"),
    conversationDocId = documentSnapshot.id,
  });
}