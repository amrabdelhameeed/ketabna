import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:ketabna/core/utils/shared_pref_helper.dart';

import '../../core/utils/app_colors.dart';
import '../../core/widgets/components.dart';
import 'chat_screen.dart';

final myId = FirebaseAuth.instance.currentUser?.uid;
final fireStore = FirebaseFirestore.instance;
final myName = SharedPrefHelper.getStr(key: 'userName');

class MyActiveChats extends StatefulWidget {
  const MyActiveChats({Key? key}) : super(key: key);

  @override
  _MyActiveChatsState createState() => _MyActiveChatsState();
}

class _MyActiveChatsState extends State<MyActiveChats> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        backgroundColor: Colors.transparent,
        elevation: 0.0,
        iconTheme: const IconThemeData(
          color: AppColors.secondaryColor,
          size: 32,
        ),
      ),
      body:SafeArea(
        child: Column(
          children: [
            ChatsStream()
          ],
        ),
      ), //ChatsStream(),
    );
  }
}

class ChatsStream extends StatelessWidget {
late String chatOwnerName ;
 Future<String> getChatOwnerName({required messageSender,required chatOwnerUidIndex})async{

    await fireStore.collection('users').doc(
        messageSender[chatOwnerUidIndex]).get().then((value) =>
    {
     chatOwnerName = value['name'],
      print('chatOwnerName :'+chatOwnerName)

    });
    return messageSender;
  }
  @override
  Widget build(BuildContext context) {
    return StreamBuilder<QuerySnapshot>(
      stream: fireStore.collection('chats').snapshots(),
      builder: ( context, snapshot) {
        if (!snapshot.hasData ||
            snapshot.connectionState == ConnectionState.waiting) {
          return const Center(
            child: CircularProgressIndicator(
              backgroundColor: AppColors.secondaryColor,
            ),
          );
        }

        final activeChats = snapshot.data?.docs;
        List<ActiveChatWidget> activeChatWidget = [];
        String conversationDocId = '';
        String chatOwnerId = '';
        String chatOwnerName = '';

        for (var chat in activeChats!) {
          List messageSender = chat.get('ids');
          if(myId == 1){
            chatOwnerId = messageSender[0];
          }else{
            chatOwnerId = messageSender[1];
          }

          if (messageSender.contains(myId)) {
            conversationDocId = chat.id;
            final lastMessageTime = chat.get('lastMessageTime');
            final lastMessageSent = chat
                .get('messages')
                .last['text'];
            final numberOfMessagesOfChat = chat
                .get('messages')
                .length;


            final List nameOfTwoUsers = chat.get('names');
            final myNameIndex = nameOfTwoUsers.indexOf(myName);
            if(myNameIndex == 1){
              chatOwnerName = nameOfTwoUsers[0];
            }else{
              chatOwnerName = nameOfTwoUsers[1];
            }
            final readed_messages= chat.get('readed_messages')[myId];
             int myReadedMessage = int.parse(readed_messages);

            final numberOfUnreadMessage = numberOfMessagesOfChat - myReadedMessage;

            activeChatWidget.add(ActiveChatWidget(
              conversationDocId: conversationDocId,
              chatOwnerName: chatOwnerName,
              numberOfMessagesOfChat: numberOfMessagesOfChat.toString(),
              chatOwnerId: chatOwnerId,
              numberOfUnreadMessage: numberOfUnreadMessage.toString(),
              lastMessageTime: lastMessageTime,
              lastMessageSent: lastMessageSent,),);
            activeChatWidget.sort((a, b) => a.lastMessageTime.compareTo(b.lastMessageTime));
          }


        }
        return Expanded(
          child: ListView(
            children: activeChatWidget,
          ),
        );
      },
    );
  }
}
class ActiveChatWidget extends StatelessWidget {
  final String chatOwnerName;
  final String chatOwnerId;
  final String lastMessageSent;
  final String lastMessageTime;
  final String numberOfUnreadMessage;
  final String numberOfMessagesOfChat;
  final String conversationDocId;

  ActiveChatWidget({required this.chatOwnerName,
    required this.numberOfUnreadMessage,
    required this.lastMessageTime,
    required this.chatOwnerId,
    required this.numberOfMessagesOfChat,
    required this.conversationDocId,
    required this.lastMessageSent});

  @override
  Widget build(BuildContext context) {
    return InkWell(
      onTap: ()async{
        fireStore.collection('chats').doc(conversationDocId).update({
          'readed_messages':{
            '$myId':numberOfMessagesOfChat,
          },
        });
        navigateTo(context : context , widget :ChatScreen(
          ownerName: chatOwnerName,
          ownerUid: chatOwnerId,
          conversationDocId: conversationDocId,
        ));
      },
      child: Card(
        elevation: 3,
        shadowColor: AppColors.secondaryColor,
        child: ListTile(
          leading: const CircleAvatar(
            backgroundImage: AssetImage('assets/image/Cooking.jpg'),
            radius: 30,
          ),
          title: Text(chatOwnerName,style: TextStyle(color: Colors.black),),
          subtitle: Text(lastMessageSent), 
         
          trailing:int.parse(numberOfUnreadMessage)==0 ?const Text('') : CircleAvatar(
            radius: 10,
            child:Text(numberOfUnreadMessage),
          ),
        ),
      ),
    );
  }
}
