import 'dart:async';

import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/src/material/time.dart';

// class StoreDetailsModel {
//   // double?deliveryCharge;
//   double?totalSales;
//   String?storeName;
//   String?blockedReason;
//   List? storeCategory;
//    // List<dynamic> ?productCategory;
//    List<dynamic> ?shopAdmins;
//   String? storeAddress;
//   String? location;
//   String? storeId;
//   String? shopImage;
//   // String? userId;
//   // double? latitude;
//   // double? longitude;
//   // bool? online;
//   String ?storeQR;
//   bool ?storeVerification;
//   String? localBodyName;
//   String? localBodyDoc;
//   String? localBodyDocName;
//   Map? position;
//   bool? block;
//   bool? type;
//   int ?status;
//   bool? reject;
//   String? rejectedReason;
//   // String? contactNumber;
//   String? state;
//   String? district;
//   String? ward;
//   String? localBodyCategory;
//   DateTime? date;
//   String? country;
//   String? description;
//   String? phoneNumber;
//   String? pinCode;
//   String? instagramLink;
//   double? adminReward;
//   double? customerReward;
//   DateTime? openingTime;
//   DateTime? closingTime;
//   StoreDetailsModel(
//       {this.storeName,
//         // this.deliveryCharge,
//         this.totalSales,
//         required this.storeCategory,
//         // required this.productCategory,
//          required this.shopAdmins,
//         this.storeAddress,
//         this.location,
//         this.storeId,
//         this.shopImage,
//         // this.userId,
//         // this.longitude,
//         // this.latitude,
//         this.position,
//         // this.online,
//         this.storeQR,
//         this.storeVerification,
//         this.localBodyName,
//         this.localBodyDoc,
//         this.localBodyDocName,
//         this.block,
//         this.status,
//         this.reject,
//         this.rejectedReason,
//         // this.contactNumber,
//         this.blockedReason,
//         this.district,
//         this.state,
//         this.ward,
//         this.localBodyCategory,
//         this.date,
//         this.adminReward,
//         this.customerReward,
//         this.country,
//         this.phoneNumber,
//         this.pinCode,
//         this.type,
//         this.instagramLink,
//         this.description,
//          this. openingTime,
//          this. closingTime,});
//
//   StoreDetailsModel.fromJson(Map<String, dynamic> json) {
//     // deliveryCharge = double.tryParse(json['deliveryCharge'].toString());
//     totalSales = double.tryParse(json['totalSales'].toString());
//     storeName = json['storeName'];
//     storeCategory = json['storeCategory'];
//     shopAdmins = json['shopAdmins'];
//     // productCategory = json['productCategory'];
//     storeAddress = json['storeAddress'];
//     location = json['location'];
//     storeId = json['storeId'];
//     shopImage = json['shopImage'];
//     // longitude = double.tryParse(json['longitude'].toString());
//     // latitude = double.tryParse(json['latitude'].toString());
//     position = json['position'];
//     // online=json['online'];
//     storeQR=json['storeQR'];
//     storeVerification=json['storeVerification'];
//     localBodyName=json['localBodyName'];
//     localBodyDoc=json['localBodyDoc'];
//     localBodyDocName=json['localBodyDocName'];
//     block=json['block'];
//     status=json['status'];
//     blockedReason=json['blockedReason'];
//     localBodyCategory=json['localBodyCategory'];
//     // userId = json['userId'];
//     reject=json['reject'];
//     rejectedReason=json['rejectedReason'];
//     district=json['district'];
//     state=json['state'];
//     country=json['country'];
//     ward=json['ward'];
//     description=json['description'];
//     adminReward=json['adminReward'];
//     instagramLink=json['instagramLink'];
//     phoneNumber=json['phoneNumber'];
//     pinCode=json['pinCode'];
//     customerReward=json['customerReward'];
//     closingTime=json['closingTime'].toDate();
//     openingTime=json['openingTime'].toDate();
//     type=json['type'];
//     date=json['date'].toDate();
//
//
//   }
//
//   Map<String, dynamic> toJson() {
//     final Map<String, dynamic> data = new Map<String, dynamic>();
//     // data['deliveryCharge'] = this.deliveryCharge;
//     data['totalSales'] = this.totalSales;
//     data['storeName'] = this.storeName;
//     data['storeCategory'] = this.storeCategory;
//     // data['productCategory'] = this.productCategory;
//     data['shopAdmins'] = this.shopAdmins;
//     data['storeAddress'] = this.storeAddress;
//     data['location'] = this.location;
//     data['storeId'] = this.storeId;
//     data['shopImage'] = this.shopImage;
//     // data['longitude'] = this.longitude;
//     // data['userId'] = this.userId;
//     // data['latitude'] = this.latitude;
//     data['position'] = this.position;
//     // data['online']=this.online;
//     data['storeQR']=this.storeQR;
//     data['type']=this.type;
//     data['localBodyName']=this.localBodyName;
//     data['localBodyDoc']=this.localBodyDoc;
//     data['storeVerification']=this.storeVerification;
//     data['localBodyDocName']=this.localBodyDocName;
//     data['block']=this.block;
//     data['blockedReason']=this.blockedReason;
//     data['instagramLink']=this.instagramLink;
//     data['status']=this.status;
//
//     data['reject']=this.reject;
//     data['rejectedReason']=this.rejectedReason;
//     data['state']=this.state;
//     data['ward']=this.ward;
//     data['district']=this.district;
//     data['localBodyCategory']=this.localBodyCategory;
//     data['date']=this.date;
//     data['country']=this.country;
//     data['adminReward']=this.adminReward;
//     data['phoneNumber']=this.phoneNumber;
//     data['pinCode']=this.pinCode;
//     data['customerReward']=this.customerReward;
//     data['description']=this.description;
//     data['closingTime']=this.closingTime;
//     data['openingTime']=this.openingTime;
//     return data;
//   }
// }


// To parse this JSON data, do
//
//     final storeDetailsModel = storeDetailsModelFromJson(jsonString);

import 'dart:convert';

StoreDetailsModel storeDetailsModelFromJson(String str) => StoreDetailsModel.fromJson(json.decode(str));

String storeDetailsModelToJson(StoreDetailsModel data) => json.encode(data.toJson());

class StoreDetailsModel {
  StoreDetailsModel({
    this.totalCredit,
    this.storeName,
    this.blockedReason,
    this.shopAdmins,
    this.storeAddress,
    this.shopId,
    this.shopImage,
    this.storeVerification,
    this.block,
    this.type,
    this.status,
    this.reject,
    this.rejectedReason,
    this.phoneNumber,
    this.pinCode,
    this.openingTime,
    this.closingTime,
    this.state,
    this.city,
    this.date,
    this.country,
    this.description,
    this. currencyName,
    this. currencyShort,
    this. fileName,
    this. bookName,
    this. document,
    this. pEnd,
    this. companies,
    this. isoCode,
  });

  double? totalCredit;
  int? offerCoupon;

  String? storeName;
  String? blockedReason;

  List<dynamic>? shopAdmins;
  List<dynamic>? companies;
  String? storeAddress;
  String? shopId;
  String? shopImage;
  String? storeQr;
  bool? storeVerification;

  Map? position;
  bool? block;
  bool? type;
  int? status;
  bool? reject;
  String? rejectedReason;
  String? phoneNumber;
  String? pinCode;
  String? instagramLink;
  DateTime? openingTime;
  DateTime? closingTime;
  String? state;
  String? city;
  String? fileName;
  String? document;
  String? bookName;


  DateTime? date;
  String? country;
  String? description;
  String?currencyName;
  String?currencyShort;
  String?isoCode;
  DateTime?pEnd;

  StoreDetailsModel copyWith({
    double? totalCredit,

    String? storeName,
    String? currencyName,
    String? currencyShort,
    String? blockedReason,
    String? bookName,


    List<dynamic>? shopAdmins,
    List<dynamic>? companies,

    String? storeAddress,
    String? location,
    String? shopId,
    String? shopImage,
    bool? storeVerification,

    bool? block,
    bool? type,
    int? status,
    bool? reject,
    String? rejectedReason,
    String? phoneNumber,
    String? pinCode,

    DateTime? openingTime,
    DateTime? pEnd,
    DateTime? closingTime,
    String? state,
    String? district,
    DateTime? date,
    String? country,
    String? description,
    String? fileName,
    String? document,
    String? isoCode,

  }) =>
      StoreDetailsModel(
        totalCredit: totalCredit ?? this.totalCredit,
        currencyName: storeName ?? this.currencyName,
        currencyShort: storeName ?? this.currencyShort,
        storeName: storeName ?? this.storeName,
        blockedReason: blockedReason ?? this.blockedReason,
        shopAdmins: shopAdmins ?? this.shopAdmins,
        companies: companies ?? this.companies,
        storeAddress: storeAddress ?? this.storeAddress,
        shopId: shopId ?? this.shopId,
        shopImage: shopImage ?? this.shopImage,
        storeVerification: storeVerification ?? this.storeVerification,
        block: block ?? this.block,
        type: type ?? this.type,
        status: status ?? this.status,
        bookName: bookName ?? this.bookName,
        reject: reject ?? this.reject,
        rejectedReason: rejectedReason ?? this.rejectedReason,
        phoneNumber: phoneNumber ?? this.phoneNumber,
        pinCode: pinCode ?? this.pinCode,

        openingTime: openingTime ?? this.openingTime,
        closingTime: closingTime ?? this.closingTime,
        state: state ?? this.state,
        city: district ?? this.city,
        date: date ?? this.date,
        country: country ?? this.country,
        description: description ?? this.description,
        fileName: description ?? this.fileName,
        document: description ?? this.document,
        pEnd: pEnd ?? this.pEnd,
        isoCode: isoCode ?? this.isoCode,
      );

  factory StoreDetailsModel.fromJson(Map<String, dynamic> json) => StoreDetailsModel(
    totalCredit: json["totalCredit"]?.toDouble(),
    currencyShort: json["currencyShort"],
    currencyName: json["currencyName"],
    bookName: json["bookName"],
    storeName: json["storeName"],
    blockedReason: json["blockedReason"],
    shopAdmins: json["shopAdmins"] == null ? [] : List<dynamic>.from(json["shopAdmins"]!.map((x) => x)),
    companies: json["companies"] == null ? [] : List<dynamic>.from(json["companies"]!.map((x) => x)),
    storeAddress: json["storeAddress"],
    shopId: json["shopId"],
    shopImage: json["shopImage"],
    storeVerification: json["storeVerification"],

    block: json["block"],
    type: json["type"],
    status: json["status"],
    reject: json["reject"],
    rejectedReason: json["rejectedReason"],
    phoneNumber: json["phoneNumber"],
    pinCode: json["pinCode"],

    // openingTime: json["openingTime"].toDate(),
    openingTime :json['openingTime'] != null
        ? json['openingTime'].toDate()
        : DateTime.now(),
    closingTime :json['closingTime'] != null
        ? json['closingTime'].toDate()
        : DateTime.now(),
    pEnd :json['pEnd'] != null
        ? json['pEnd'].toDate()
        : DateTime.now(),
    // closingTime: json["closingTime"].toDate(),

    state: json["state"],
    city: json["city"],

    date: json["date"].toDate(),
    country: json["country"],
    description: json["description"],
    fileName: json["fileName"],
    document: json["document"],
    isoCode: json["isoCode"],
  );

  Map<String, dynamic> toJson() => {
    "totalCredit": totalCredit,


    "storeName": storeName,
    "bookName": bookName,
    "currencyShort": currencyShort,
    "currencyName": currencyName,
    "blockedReason": blockedReason,
    "shopAdmins": shopAdmins == null ? [] : List<dynamic>.from(shopAdmins!.map((x) => x)),
    "companies": companies == null ? [] : List<dynamic>.from(companies!.map((x) => x)),
    "storeAddress": storeAddress,
    "shopId": shopId,
    "shopImage": shopImage,
    "storeVerification": storeVerification,

    "block": block,
    "type": type,
    "status": status,
    "reject": reject,
    "rejectedReason": rejectedReason,
    "phoneNumber": phoneNumber,
    "pinCode": pinCode,


    "openingTime": openingTime,
    "closingTime": closingTime,
    "state": state,
    "city": city,

    "date": date,
    "country": country,
    "description": description,
    "document": document,
    "fileName": fileName,
    "isoCode": isoCode,
    "pEnd": pEnd,

  };
}