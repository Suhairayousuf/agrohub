


class OfflineUserModel {
  String? userName;
  String? userEmail;
  String? phone;
  // String? password;
  String? icamaNumber;
  String? companyName;
  String? country;
  String? code;
  // String? city;
  String? cabName;
  String? doorNumber;
  List<dynamic>? cardImage;
  String? userId;
  // String? qrImage;
  int? status;
  DateTime? createdDate;
  String? countryCode;
  String? currencyShort;
   // List<String>? token;

  OfflineUserModel(
      {this.userName,
        this.userEmail,
        this.phone,
        // this.password,
        this.icamaNumber,
        this.companyName,
        this.country,
        this.code,
        // this.city,
        this.cabName,
        this.doorNumber,
        this.cardImage,
        this.userId,
        // this.qrImage,
        this.status,
        this.createdDate,
        this.countryCode,
        this.currencyShort,
        // this.token
      });

  OfflineUserModel.fromJson(Map<String, dynamic> json) {
    userName = json['userName'];
    userEmail = json['userEmail'];
    phone = json['phone'];
    // password = json['password'];
    icamaNumber = json['icamaNumber'];
    companyName = json['companyName'];
    country = json['country'];
    countryCode = json['countryCode'];
    code = json['code'];
    // city = json['city'];
    cabName = json['cabName'];
    doorNumber = json['doorNumber'];
    cardImage = json['cardImage']??[];
    userId = json['userId'];
    // qrImage = json['qrImage'];
    status = json['status'];
    currencyShort = json['currencyShort'];
    // createdDate = json['createdDate'];
    createdDate = json['createdDate'] != null
        ? json['createdDate'].toDate()
        : DateTime.now();
    // token = json['token'].cast<String>();
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['userName'] = this.userName;
    data['userEmail'] = this.userEmail;
    data['phone'] = this.phone;
    // data['password'] = this.password;
    data['icamaNumber'] = this.icamaNumber;
    data['companyName'] = (this.companyName??"NA").toUpperCase();
    data['country'] = this.country;
    data['countryCode'] = this.countryCode;
    data['code'] = this.code;
    // data['city'] = this.city;
    data['cabName'] = this.cabName;
    data['doorNumber'] = this.doorNumber;
    data['cardImage'] = this.cardImage;
    data['userId'] = this.userId;
    // data['qrImage'] = this.qrImage;
    data['status'] = this.status;
    data['currencyShort'] = this.currencyShort;
    data['createdDate'] = this.createdDate;
    // data['token'] = this.token;
    return data;
  }
}



