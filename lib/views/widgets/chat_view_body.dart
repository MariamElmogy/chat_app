import 'dart:developer';

import 'package:chatty_app/constants.dart';
import 'package:chatty_app/views/models/message_model.dart';
import 'package:chatty_app/views/widgets/my_messgae_bubble.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:shared_preferences/shared_preferences.dart';

import '../../utils/functions/send_message.dart';
import 'message_bubble.dart';

class ChatViewBody extends StatefulWidget {
  const ChatViewBody({super.key});

  @override
  State<ChatViewBody> createState() => _ChatViewBodyState();
}

class _ChatViewBodyState extends State<ChatViewBody> {
  late TextEditingController textEditingController;
  late ScrollController scrollController;

  @override
  void initState() {
    textEditingController = TextEditingController();
    scrollController = ScrollController();
    super.initState();
  }

  @override
  void dispose() {
    textEditingController.dispose();
    scrollController.dispose();
    super.dispose();
  }

  final Stream<QuerySnapshot> _messagesStream = FirebaseFirestore.instance
      .collection(kMessagesCollections)
      .orderBy('timeStamp', descending: true)
      .snapshots();

  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        Expanded(
          child: StreamBuilder<QuerySnapshot>(
            builder: (context, snapshot) {
              log('rebuild');
              List<MessageModel> messages = [];

              if (snapshot.hasData) {
                for (var document in snapshot.data!.docs) {
                  messages.add(MessageModel.fromJson(
                      document.data() as Map<String, dynamic>));
                }
              }

              return ListView.builder(
                controller: scrollController,
                reverse: true,
                itemCount: messages.length,
                itemBuilder: ((context, index) {
                  return getMessageBubble(messages[index]);
                }),
              );
            },
            stream: _messagesStream,
          ),
        ),
        Row(
          children: [
            Expanded(
              child: Padding(
                padding: const EdgeInsets.symmetric(horizontal: 16),
                child: TextField(
                  controller: textEditingController,
                  onSubmitted: (data) async {
                    String? avatar = await fetchAvatar();

                    String uid = FirebaseAuth.instance.currentUser!.uid;
                    MessageModel messageModel = MessageModel(
                      avatar: avatar!,
                      content: data,
                      timeStamp: Timestamp.now(),
                      senderID: uid,
                    );
                    sendMessage(messageModel);
                    textEditingController.clear();
                    scrollController.animateTo(0,
                        duration: const Duration(microseconds: 300),
                        curve: Curves.easeIn);
                  },
                  decoration: const InputDecoration(
                    hintText: 'Type your message',
                  ),
                ),
              ),
            ),
          ],
        ),
      ],
    );
  }

  Future<String?> fetchAvatar() async {
    final SharedPreferences prefs = await SharedPreferences.getInstance();
    var avatar = prefs.getString(kAvatar);
    return avatar;
  }

  Widget getMessageBubble(MessageModel message) {
    var uid = FirebaseAuth.instance.currentUser!.uid;
    if (uid == message.senderID) {
      return MyMessageBubble(messageModel: message);
    } else {
      return MessageBubble(messageModel: message);
    }
  }
}
