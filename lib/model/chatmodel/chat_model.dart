// To parse this JSON data, do
//
//     final chatModel = chatModelFromJson(jsonString);

import 'dart:convert';

ChatModel chatModelFromJson(String str) => ChatModel.fromJson(json.decode(str));

String chatModelToJson(ChatModel data) => json.encode(data.toJson());

class ChatModel {
  bool? isRead;
  String? message;
  String? msgId;
  String? receiverId;
  DateTime? sendTime;
  String? senderId;

  ChatModel({
    this.isRead,
    this.message,
    this.msgId,
    this.receiverId,
    this.sendTime,
    this.senderId,
  });

  ChatModel copyWith({
    bool? isRead,
    String? message,
    String? msgId,
    String? receiverId,
    DateTime? sendTime,
    String? senderId,
  }) =>
      ChatModel(
        isRead: isRead ?? this.isRead,
        message: message ?? this.message,
        msgId: msgId ?? this.msgId,
        receiverId: receiverId ?? this.receiverId,
        sendTime: sendTime ?? this.sendTime,
        senderId: senderId ?? this.senderId,
      );

  factory ChatModel.fromJson(Map<String, dynamic> json) => ChatModel(
    isRead: json["isRead"],
    message: json["message"],
    msgId: json["msgId"],
    receiverId: json["receiverId"],
    // sendTime: json["sendTime"].toDate(),
    sendTime : json['sendTime'] != null
        ? json['sendTime'].toDate()
        : DateTime.now(),
    senderId: json["senderId"],
  );

  Map<String, dynamic> toJson() => {
    "isRead": isRead,
    "message": message,
    "msgId": msgId,
    "receiverId": receiverId,
    "sendTime": sendTime,
    "senderId": senderId,
  };
}
