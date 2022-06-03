import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import '../../../core/models/book_model.dart';
import '../../../core/utils/shared_pref_helper.dart';
import '../../../core/widgets/components.dart';
import '../../chat/chat_screen.dart';

String conversationDocId = '';
final _firestore = FirebaseFirestore.instance;
final String? myUid = FirebaseAuth.instance.currentUser?.uid.toString();

class BookItem extends StatelessWidget {
  final myName = SharedPrefHelper.getStr(key: 'userName');
  Future<String> checkForOldConversation(
      {bookOwnerUid, bookOwnerName, myId}) async {
    String ids;
    bool containUid_1 = false;
    bool containUid_2 = false;
    bool oldChat = false;
    try {
      await FirebaseFirestore.instance
          .collection("chats")
          .get()
          .then((value) => {
                value.docs.forEach((element) {
                  print('start check');
                  ids = element.data()['ids'].toString();
                  final numberOfMessagesOfChat =
                      element.data()['messages'].length;
                  containUid_1 = ids.contains(bookOwnerUid);
                  containUid_2 = ids.contains(myId);

                  if (containUid_1 && containUid_2) {
                    oldChat = true;
                    print("element.id : " + element.id);
                    conversationDocId = element.id;
                    _firestore
                        .collection('chats')
                        .doc(conversationDocId)
                        .update({
                      'readed_messages': {
                        '$myId': '$numberOfMessagesOfChat',
                      },
                    });
                  }
                })
              });
    } catch (error) {
      print(error.toString());
    }
    if (!oldChat) {
      await setNewConversation(
          bookOwnerUid: bookOwnerUid, bookOwnerName: bookOwnerName);
    }
    return conversationDocId;
  }

  Future setNewConversation({bookOwnerUid, bookOwnerName}) async {
    await _firestore.collection("chats").add({
      'names': [bookOwnerName, myName],
      'ids': [
        bookOwnerUid,
        myUid,
      ],
      'messages': [],
      'readed_messages': {
        '$myUid': '0',
        '$bookOwnerUid': '0',
      },
    }).then((documentSnapshot) => {
          print("Added Data with ID: ${documentSnapshot.id}"),
          conversationDocId = documentSnapshot.id,
        });
  }

  BookItem({Key? key, required this.bookModel}) : super(key: key);
  final BookModel bookModel;

  @override
  Widget build(BuildContext context) {
    return InkWell(
      onTap: () async {
        // String ownerUid = bookModel.ownerUid.toString();
        // print('ownerUid'+ownerUid);
        // String ownerName = '';
        // await FirebaseFirestore.instance
        //     .collection('users')
        //     .doc(ownerUid)
        //     .get()
        //     .then((value) => {
        //           ownerName = value['name'],
        //   print('ownerName :'+ownerName)
        //         });
        // checkForOldConversation(bookOwnerUid: ownerUid,myId:myUid,bookOwnerName: ownerName ).then((value) => {
        //   navigateTo(context : context , widget :ChatScreen(
        //     ownerName: ownerName,
        //     ownerUid: ownerUid,
        //     conversationDocId: value,
        //   )),

        // });
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
                            fit: BoxFit.fill,
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
              style: TextStyle(
                  color: Colors.grey[500],
                  fontSize: 12,
                  fontWeight: FontWeight.w300),
              maxLines: 2,
              overflow: TextOverflow.ellipsis,
              textAlign: TextAlign.center,
            ),
          ],
        ),
      ),
    );
  }
}
