import 'package:flutter/material.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:image_picker/image_picker.dart';

import 'constants.dart';

final _firestore = FirebaseFirestore.instance;
final String? _auth = FirebaseAuth.instance.currentUser?.uid.toString();
int numberOfMessages = 0;
int readedMessages = 0;
int totalMessages = 0;

class ChatScreen extends StatefulWidget {
  final String ownerName;
  final String ownerUid;

  const ChatScreen({required this.ownerName, required this.ownerUid});

  @override
  _ChatScreenState createState() => _ChatScreenState();
}

class _ChatScreenState extends State<ChatScreen> {
  final messageTextController = TextEditingController();
  String conversationDocId = '';


  late String message;

  @override
  void initState() {
    super.initState();
    checkForOldConversation();
  }
  @override
  void dispose() {
    numberOfMessages = 0;
    super.dispose();
  }

  Future<bool> checkForOldConversation() async {
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
                  containUid_1 = ids.contains(widget.ownerUid);
                  containUid_2 = ids.contains(_auth!);
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
      setNewConversation();
    }
    return containUid_1;
  }

  // Future getMessages() async {
  //   await FirebaseFirestore.instance.collection("chats").get().then((value) => {
  //         value.docs.forEach((element) {
  //           try {
  //             numberOfMessages = element.data()['messages'].length;
  //             print("numberOfMessages : " + numberOfMessages.toString());
  //             readedMessages = element.data()['readedMessages'];
  //             totalMessages = element.data()['totalMessages'];
  //             for (int i = 0; i < numberOfMessages; i++) {
  //               final text = element.data()['messages'][i]['text'];
  //               final sender = element.data()['messages'][i]['sender'];
  //               final time =
  //                   DateTime.parse(element.data()['messages'][i]['time']);
  //
  //               messagesWidget.add(MessageBuble(
  //                 text: text,
  //                 sender: sender,
  //                 time: time,
  //                 isMe: element.data()['messages'][i]['sender'] == _auth,
  //               ));
  //             }
  //             messagesWidget.sort((a, b) => a.time.compareTo(b.time));
  //             print("sender : " + messagesWidget[0].text);
  //           } catch (error) {
  //             print(error.toString());
  //             return;
  //           }
  //         })
  //       });
  // }

  Future setNewConversation() async {
    await _firestore.collection("chats").add({
      'ids': [
        widget.ownerUid,
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

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        centerTitle: true,
        title: Text(widget.ownerName),
        backgroundColor: Colors.lightBlueAccent,
      ),
      body: SafeArea(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          crossAxisAlignment: CrossAxisAlignment.stretch,
          children: <Widget>[
            MessageStream(),
            Container(
              decoration: kMessageContainerDecoration,
              child: Row(
                crossAxisAlignment: CrossAxisAlignment.center,
                children: <Widget>[
                  IconButton(
                    onPressed: () {
                      pickImage();
                    },
                    icon: const Icon(Icons.photo_size_select_actual),
                  ),
                  Expanded(
                    child: TextField(
                      controller: messageTextController,
                      onChanged: (value) {
                        //Do something with the user input.
                        message = value;
                      },
                      decoration: kMessageTextFieldDecoration,
                    ),
                  ),
                  FlatButton(
                    onPressed: () async {
                      messageTextController.clear();
                      message = '';
                      //Implement send functionality.
                      await _firestore
                          .collection('chats')
                          .doc(conversationDocId)
                          .update({
                        'messages': FieldValue.arrayUnion([
                          {
                            'sender': _auth,
                            'text': message,
                            'time': DateTime.now().toIso8601String().toString(),
                          }
                        ])
                      }, );
                    },
                    child: const Text(
                      'Send',
                      style: kSendButtonTextStyle,
                    ),
                  ),
                ],
              ),
            ),
          ],
        ),
      ),
    );
  }
}

class MessageStream extends StatelessWidget {

  @override
  Widget build(BuildContext context) {
    return StreamBuilder<DocumentSnapshot>(
        stream: _firestore.collection('chats').doc('').snapshots(),
        builder: (context, snapshot) {
          if (snapshot.connectionState == ConnectionState.waiting) {
            return const Text("Loading");
          }
          if (!snapshot.hasData) {
            return const Center(
              child: CircularProgressIndicator(
                backgroundColor: Colors.lightBlueAccent,
              ),
            );
          }

          List<MessageBuble> messagesWidget = [];
          print(snapshot.data!['ids'][0]);

          return Expanded(
            child: ListView(
              children: messagesWidget,
            ),
          );
        });
  }
}

class MessageBuble extends StatelessWidget {
  final String sender;
  final String text;
  final DateTime time;
  final bool isMe;

  MessageBuble(
      {required this.sender,
      required this.text,
      required this.isMe,
      required this.time});

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.all(10.0),
      child: Column(
        crossAxisAlignment:
            isMe ? CrossAxisAlignment.end : CrossAxisAlignment.start,
        children: [
          Text(
            isMe ? '' : '',
            style: const TextStyle(color: Colors.black45),
          ),
          Material(
            elevation: 5.0,
            borderRadius: isMe
                ? const BorderRadius.only(
                    topLeft: Radius.circular(30.0),
                    bottomLeft: Radius.circular(30.0),
                    bottomRight: Radius.circular(30.0),
                  )
                : const BorderRadius.only(
                    topRight: Radius.circular(30.0),
                    bottomLeft: Radius.circular(30.0),
                    bottomRight: Radius.circular(30.0),
                  ),
            child: Padding(
              padding: const EdgeInsets.symmetric(horizontal: 20, vertical: 10),
              child: Text(
                text,
                style: TextStyle(
                  color: isMe ? Colors.white : Colors.black45,
                  fontSize: 15.0,
                ),
              ),
            ),
            color: isMe ? Colors.lightBlueAccent : Colors.white,
          ),
        ],
      ),
    );
  }
}

pickImage()async{
  final ImagePicker _picker = ImagePicker();
  final XFile? image = await _picker.pickImage(source: ImageSource.gallery);
}

// Future getMessages(messagesWidget) async {
//
//   await FirebaseFirestore.instance.collection("chats").get().then((value) => {
//     value.docs.forEach((element) {
//       try {
//         numberOfMessages = element.data()['messages'].length;
//         print("numberOfMessages : " + numberOfMessages.toString());
//         readedMessages = element.data()['readedMessages'];
//         totalMessages = element.data()['totalMessages'];
//         for (int i = 0; i < numberOfMessages; i++) {
//           final text = element.data()['messages'][i]['text'];
//           final sender = element.data()['messages'][i]['sender'];
//           final time =
//           DateTime.parse(element.data()['messages'][i]['time']);
//
//           messagesWidget.add(MessageBuble(
//             text: text,
//             sender: sender,
//             time: time,
//             isMe: element.data()['messages'][i]['sender'] == _auth,
//           ));
//
//         }
//        messagesWidget.sort((a, b) => a.time.compareTo(b.time));
//
//       } catch (error) {
//         print(error.toString());
//         return;
//       }
//     })
//
//   });
//   _messagesWidget = messagesWidget;
//   print('text :'+messagesWidget[0].text);
//   return  messagesWidget;
// }