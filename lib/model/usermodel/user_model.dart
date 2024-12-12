


class UserModel {
  String? userName;
  String? userImage;
  String? userEmail;
  String? phone;
  String? phonePrefix;
  String? whatsappNumber;
  String? password;
  bool? offline;
  bool? hide;
  // String? icamaNumber;
  String? companyName;
  String? jobNumber;
  String? country;
  String? cabName;
  String? doorNumber;
  // List<dynamic>? cardImage;
  String? userId;
  String? qrImage;
  String? countryCode;
  String? currencyShort;
  String? shopId;
  int? status;
  DateTime? createdDate;
  List<String>? token;
  List<String>? books;
  List<String>? search;

  UserModel(
      {this.userName,
      this.userImage,
        this.userEmail,
        this.phone,
        this.whatsappNumber,
        this.phonePrefix,
        this.password,
        // this.icamaNumber,
        this.companyName,
        this.country,
        this.cabName,
        this.doorNumber,
        this.jobNumber,
        // this.cardImage,
        this.userId,
        this.qrImage,
        this.status,
        this.createdDate,
        this.countryCode,
        this.currencyShort,
        this.offline,
        this.hide,
        this.shopId,
        this.token,
        this.search,
        this.books});

  UserModel.fromJson(Map<String, dynamic> json) {
    userName = json['userName'];
    userImage = json['userImage'];
    userEmail = json['userEmail'];
    phone = json['phone'];
    phonePrefix = json['phonePrefix'];
    whatsappNumber = json['whatsappNumber'];
    password = json['password'];
    shopId = json['shopId'];
    // icamaNumber = json['icamaNumber'];
    companyName = json['companyName'];
    jobNumber = json['jobNumber'];
    country = json['country'];
    countryCode = json['countryCode'];
    currencyShort = json['currencyShort'];
    cabName = json['cabName'];
    doorNumber = json['doorNumber'];
    // cardImage = json['cardImage']??[];
    userId = json['userId'];
    hide = json['hide'];
    qrImage = json['qrImage'];
    offline = json['offline'];
    status = json['status'];
    // createdDate = json['createdDate'];
    createdDate = json['createdDate'] != null
        ? json['createdDate'].toDate()
        : DateTime.now();
    token = json['token'].cast<String>();
    books = json['books'].cast<String>();
    search = json['search'].cast<String>();
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['userName'] = this.userName;
    data['userImage'] = this.userImage;
    data['userEmail'] = this.userEmail;
    data['jobNumber'] = this.jobNumber;
    data['shopId'] = this.shopId;
    data['phone'] = this.phone;
    data['phonePrefix'] = this.phonePrefix;
    data['whatsappNumber'] = this.whatsappNumber;
    data['password'] = this.password;
    data['hide'] = this.hide;
    // data['icamaNumber'] = this.icamaNumber;
    data['companyName'] = (this.companyName??"NA").toUpperCase();
    data['country'] = this.country;
    data['cabName'] = this.cabName;
    data['doorNumber'] = this.doorNumber;
    // data['cardImage'] = this.cardImage;
    data['userId'] = this.userId;
    data['qrImage'] = this.qrImage;
    data['status'] = this.status;
    data['createdDate'] = this.createdDate;
    data['token'] = this.token;
    data['books'] = this.books;
    data['search'] = this.search;
    data['countryCode'] = this.countryCode;
    data['currencyShort'] = this.currencyShort;
    data['offline'] = this.offline;
    return data;
  }
}



