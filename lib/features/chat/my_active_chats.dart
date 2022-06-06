import 'package:cached_network_image/cached_network_image.dart';
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
int readMessagesForOwner = 0;

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
        centerTitle: true,
        title: const Text('Your Chats',style: TextStyle(color: Colors.black87),),
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
late String chatOwnerImage ;
 Future<String> getChatOwnerData({required uid})async{

    await fireStore.collection('users').doc(uid).get().then((value) =>
    {
      chatOwnerImage = value['picture'],

    });
    return chatOwnerImage;
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
        String? lastMessageSent;
        String chatOwnerImage = '';

        for (var chat in activeChats!) {
          List messageSender = chat.get('ids');
          if(messageSender[0] == myId){
            chatOwnerId = messageSender[1];
          }else{
            chatOwnerId = messageSender[0];
          }
          if (messageSender.contains(myId)) {
            conversationDocId = chat.id;
            final lastMessageTime = chat.get('lastMessageTime');

            try{
               lastMessageSent = chat
                  .get('messages')
                  .last['text'];
            }catch (error){}

            // ignore: unnecessary_null_comparison
            if(lastMessageSent==null){
              lastMessageSent = 'No messages yet';
            }
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

            readMessagesForOwner = chat.get('readed_messages')[chatOwnerId];

            final numberOfUnreadMessage = numberOfMessagesOfChat - readed_messages;
            chatOwnerImage = chat.get('images')[chatOwnerId];
            activeChatWidget.add(ActiveChatWidget(
              conversationDocId: conversationDocId,
              chatOwnerName: chatOwnerName,
              numberOfMessagesOfChat: numberOfMessagesOfChat,
              chatOwnerId: chatOwnerId,
              chatOwnerImage: chatOwnerImage,
              numberOfUnreadMessage: numberOfUnreadMessage,
              readMessagesForOwner: readMessagesForOwner,
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
  final String chatOwnerImage;
  final String lastMessageSent;
  final String lastMessageTime;
  final int numberOfUnreadMessage;
  final int readMessagesForOwner;
  final int numberOfMessagesOfChat;
  final String conversationDocId;

  ActiveChatWidget({required this.chatOwnerName,
    required this.numberOfUnreadMessage,
    required this.lastMessageTime,
    required this.chatOwnerId,
    required this.chatOwnerImage,
    required this.numberOfMessagesOfChat,
    required this.readMessagesForOwner,
    required this.conversationDocId,
    required this.lastMessageSent});

  @override
  Widget build(BuildContext context) {
    print('chatOwnerImage : '+chatOwnerImage);
    return InkWell(
      onTap: ()async{
        await fireStore.collection('chats').doc(conversationDocId).update({
          'readed_messages':{
            '$myId':numberOfMessagesOfChat,
            '$chatOwnerId':readMessagesForOwner,
          },
        }).then((value) => {
          navigateTo(context : context , widget :ChatScreen(
            ownerName: chatOwnerName,
            ownerUid: chatOwnerId,
            conversationDocId: conversationDocId,
          ))
        });
        // navigateTo(context : context , widget :ChatScreen(
        //   ownerName: chatOwnerName,
        //   ownerUid: chatOwnerId,
        //   conversationDocId: conversationDocId,
        // ));
      },
      child: Card(
        elevation: 3,
        shadowColor: AppColors.secondaryColor,
        child: ListTile(
          leading: CircleAvatar(
            backgroundImage: NetworkImage(chatOwnerImage),
            radius: 30,
          ),
          title: Text(chatOwnerName,style: const TextStyle(color: Colors.black),),
          subtitle: Text(lastMessageSent),

          trailing:numberOfUnreadMessage==0 ?const Text('') : CircleAvatar(
            radius: 10,
            child:Text(numberOfUnreadMessage.toString()),
          ),
        ),
      ),
    );
  }
}
