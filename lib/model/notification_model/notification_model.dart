// To parse this JSON data, do
//
//     final notificationModel = notificationModelFromJson(jsonString);

import 'dart:convert';

import 'package:cloud_firestore/cloud_firestore.dart';

NotificationModel notificationModelFromJson(String str) => NotificationModel.fromJson(json.decode(str));

String notificationModelToJson(NotificationModel data) => json.encode(data.toJson());

class NotificationModel {
  String? shopId;
  String? ownerEmail;
  String? heading;
  String? content;
  DateTime? date;
  List<dynamic>? tokens;
  bool? view;
  String? shopName;
  String? userName;
  String? userId;
  String? docId;
  DocumentReference? docRef;

  NotificationModel({
    this.shopId,
    this.ownerEmail,
    this.heading,
    this.content,
    this.date,
    this.tokens,
    this.view,
    this.shopName,
    this.userName,
    this.userId,
    this.docId,
    this.docRef,
  });

  NotificationModel copyWith({
    String? shopId,
    String? ownerEmail,
    String? heading,
    String? content,
    DateTime? date,
    List<String>? tokens,
    bool? view,
    String? shopName,
    String? userName,
    String? userId,
    String? docId,
    DocumentReference? docRef,
  }) =>
      NotificationModel(
        shopId: shopId ?? this.shopId,
        ownerEmail: ownerEmail ?? this.ownerEmail,
        heading: heading ?? this.heading,
        content: content ?? this.content,
        date: date ?? this.date,
        tokens: tokens ?? this.tokens,
        view: view ?? this.view,
        shopName: shopName ?? this.shopName,
        userName: userName ?? this.userName,
        userId: userId ?? this.userId,
        docId: docId ?? this.docId,
        docRef: docRef ?? this.docRef,
      );

  factory NotificationModel.fromJson(Map<String, dynamic> json) => NotificationModel(
    shopId: json["shopId"],
    ownerEmail: json["ownerEmail"],
    heading: json["heading"],
    content: json["content"],
    date: DateTime.tryParse(json["date"].toString()),
    tokens: json["tokens"] == null ? [] : List<String>.from(json["tokens"]!.map((x) => x)),
    view: json["view"],
    shopName: json["shopName"],
    userName: json["userName"],
    userId: json["userId"],
    docId: json["docId"],
    docRef: json["docRef"],
  );

  Map<String, dynamic> toJson() => {
    "shopId": shopId,
    "ownerEmail": ownerEmail,
    "heading": heading,
    "content": content,
    "date": date,
    "tokens": tokens == null ? [] : List<dynamic>.from(tokens!.map((x) => x)),
    "view": view,
    "shopName": shopName,
    "userName": userName,
    "userId": userId,
    "docId": docId,
    "docRef": docRef,
  };
}
