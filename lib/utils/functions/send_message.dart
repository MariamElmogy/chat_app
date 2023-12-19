import 'package:chatty_app/constants.dart';
import 'package:chatty_app/views/models/message_model.dart';
import 'package:cloud_firestore/cloud_firestore.dart';

Future<void> sendMessage(MessageModel message) async {
  FirebaseFirestore firestore = FirebaseFirestore.instance;
  CollectionReference messages = firestore.collection(kMessagesCollections);

  await messages.add(message.toJson());
}
