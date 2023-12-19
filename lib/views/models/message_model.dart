import 'package:cloud_firestore/cloud_firestore.dart';

class MessageModel {
  final String content;
  final String avatar;
  final String senderID;
  final Timestamp timeStamp; // 34an l tarteb bta3 l message

  MessageModel(
      {required this.content,
      required this.avatar,
      required this.senderID,
      required this.timeStamp});

  factory MessageModel.fromJson(Map<String, dynamic> json) {
    return MessageModel(
        content: json['content'],
        avatar: json['avatar'],
        senderID: json['senderID'],
        timeStamp: Timestamp.now());
  }

  Map<String, dynamic> toJson() {
    return {
      'content': content,
      'avatar': avatar,
      'senderID': senderID,
      'timeStamp': timeStamp,
    };
  }
}
