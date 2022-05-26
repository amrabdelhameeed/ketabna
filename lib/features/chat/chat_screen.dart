import 'package:flutter/material.dart';
import 'package:flash_chat/constants.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:cloud_firestore/cloud_firestore.dart';

final _firestore = FirebaseFirestore.instance;
late User loggedUser;

class ChatScreen extends StatefulWidget {
  static String id = 'Chat_Screen';
  final userData;


  const ChatScreen({this.userData});

  @override
  _ChatScreenState createState() => _ChatScreenState();
}

class _ChatScreenState extends State<ChatScreen> {
  final messageTextController = TextEditingController();
  final _auth = FirebaseAuth.instance;
  List<MessageBuble> messagesWidget = [];
  int numberOfMessages = 0;

  late String message;

  @override
  void initState(){
    super.initState();
    getUserData();
    getMessages();
  }

  Future getUserData() async {
    var loggedUser = await _auth.currentUser;
    var userEmail = loggedUser?.email;
    print(userEmail);
  }
  Future getMessages() async {
    // print(FirebaseFirestore.instance.collection("chats").doc('ZevO7IDZJZl6EonKGUCv'));
    await FirebaseFirestore.instance.collection("chats").get().then((value) => {
      value.docs.forEach((element) {
        String ids = element.data()['ids'].toString();
        bool contain = ids.contains('PdIjVD5AU7T0fYKDJPyZlp6TRl52');
        try {
          if (contain) {
            numberOfMessages = element.data()['messages'].length;
            print("numberOfMessages : " + numberOfMessages.toString());
            for (int i = 0; i < numberOfMessages; i++) {

              final text = element.data()['messages'][i]['text'];
              final sender = element.data()['messages'][i]['sender'];
              final time = DateTime.parse(element.data()['messages'][i]['time']) ;

              messagesWidget.add(MessageBuble(
                text: text,
                sender: sender,
                time: time,
                isMe: element.data()['messages'][i]['sender'] ==
                    'PdIjVD5AU7T0fYKDJPyZlp6TRl52',
              ));
            }
            messagesWidget.sort((a, b) => a.time.compareTo(b.time));
            print("sender : " + messagesWidget[0].sender);
          }else{

          }
        } catch (error) {
          return;
        }
      })
    });
  }
  Future setNewConversation()async{
    await FirebaseFirestore.instance.collection("chats").add({
      'ids':[FirebaseAuth.instance.currentUser?.uid.toString(),]
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        leading: null,
        actions: <Widget>[
          IconButton(
              icon: Icon(Icons.close),
              onPressed: () {
                _auth.signOut();
                Navigator.pop(context);
              }),
          IconButton(icon: Icon(Icons.chat), onPressed: () {}),
        ],
        title: Text('⚡️Chat'),
        backgroundColor: Colors.lightBlueAccent,
      ),
      body: SafeArea(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          crossAxisAlignment: CrossAxisAlignment.stretch,
          children: <Widget>[
            MessageStream(messagesWidget: messagesWidget,),
            Container(
              decoration: kMessageContainerDecoration,
              child: Row(
                crossAxisAlignment: CrossAxisAlignment.center,
                children: <Widget>[
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
                      //Implement send functionality.
                      await _firestore.collection('messages').add({
                        'text': message,
                        'sender': widget.userData,
                        'date': DateTime.now().toIso8601String().toString(),
                      });
                    },
                    child: Text(
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

  final List<MessageBuble> messagesWidget;

  MessageStream({

    required this.messagesWidget
  });

  @override
  Widget build(BuildContext context) {
    return StreamBuilder<QuerySnapshot>(
        stream: _firestore.collection('chats').snapshots(),
        builder: (context, snapshot) {
          if (!snapshot.hasData) {
            return const Center(
              child: CircularProgressIndicator(
                backgroundColor: Colors.lightBlueAccent,
              ),
            );
          }


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
            sender,
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
