// To parse this JSON data, do
//
//     final bookModel = bookModelFromJson(jsonString);

import 'dart:convert';

BookModel bookModelFromJson(String str) => BookModel.fromJson(json.decode(str));

String bookModelToJson(BookModel data) => json.encode(data.toJson());

class BookModel {
  String? bookId;
  String? bookName;
  String? shopName;
  String? shopId;
  String? company;
  double? creditLimit;
  List<String>? members;
  List<String>? search;
  DateTime? createdDate;
  DateTime? update;
  double? credit;
  bool? block;
  bool? delete;

  BookModel({
    this.bookId,
    this.bookName,
    this.shopName,
    this.creditLimit,
    this.shopId,
    this.company,
    this.members,
    this.createdDate,
    this.update,
    this.search,
    this.credit,
    this.block,
    this.delete,
  });

  BookModel copyWith({
    String? bookId,
    String? bookName,
    String? shopName,
    double? creditLimit,
    String? shopId,
    String? company,
    List<String>? members,
    List<String>? search,
    DateTime? createdDate,
    DateTime? update,
    double? credit,
    bool? block,
    bool? delete,
  }) =>
      BookModel(
        bookId: bookId ?? this.bookId,
        bookName: bookName ?? this.bookName,
        creditLimit: creditLimit ?? this.creditLimit,
        shopName: shopName ?? this.shopName,
        company: company ?? this.company,
        shopId: shopId ?? this.shopId,
        members: members ?? this.members,
        search: members ?? this.search,
        createdDate: createdDate ?? this.createdDate,
        update: update ?? this.update,
        credit: credit ?? this.credit,
        block: block ?? this.block,
        delete: delete ?? this.delete,
      );

  factory BookModel.fromJson(Map<String, dynamic> json) => BookModel(
    bookId: json["bookId"],
    bookName: json["bookName"],
    creditLimit: json["creditLimit"]==null?0.00:json["creditLimit"].toDouble(),
    shopName: json["shopName"],
    shopId: json["shopId"],
    company: json["company"],
    members: json["members"] == null ? [] : List<String>.from(json["members"]!.map((x) => x)),
    search: json["search"] == null ? [] : List<String>.from(json["search"]!.map((x) => x)),
    createdDate: json["createdDate"].toDate(),
    update: json["update"].toDate(),
    credit:double.tryParse(json["credit"].toString()),
    block: json["block"],
    delete: json["delete"],
  );

  Map<String, dynamic> toJson() => {
    "bookId": bookId,
    "bookName": bookName,
    "creditLimit": creditLimit,
    "shopName": shopName,
    "shopId": shopId,
    "company": company,
    "members": members == null ? [] : List<dynamic>.from(members!.map((x) => x)),
    "search": search == null ? [] : List<dynamic>.from(search!.map((x) => x)),
    "createdDate": createdDate,
    "update": update,
    "credit": credit,
    "block": block,
    "delete": delete,
  };
}
