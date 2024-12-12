class PurchaseModel {
  double? amount;
  double? balance;
  String? customerId;
  String? customerName;
  String? customerPhone;
  String? image;
  String? purchaseId;
  String? shopId;
  bool? verification;
  bool? noBook;
  bool? delete;
  int? status;
  int? type;
  String? shopName;
  String? bookName;
  String? bookId;
  String? currencyShort;
  DateTime? date;

  PurchaseModel(
      {this.amount,
        this.balance,
        this.customerId,
        this.customerName,
        this.customerPhone,
        this.image,
        this.purchaseId,
        this.shopId,
        this.noBook,
        this.verification,
        this.status,
        this.shopName,
        this.delete,
        this.date,
        this.bookName,
        this.bookId,
        this.currencyShort,
        this.type,
      });

  PurchaseModel.fromJson(Map<String, dynamic> json) {
    amount = double.tryParse(json['amount'].toString());
    customerId = json['customerId'];
    balance = json['balance'];
    customerName = json['customerName'];
    customerPhone = json['customerPhone'];
    image = json['image'];
    purchaseId = json['purchaseId'].toString();
    shopId = json['shopId'];
    verification = json['verification'];
    noBook = json['noBook'];
    status = json['status'];
    delete = json['delete'];
    type = json['type'];
    shopName = json['shopName'];
    bookName = json['bookName'];
    bookId = json['bookId'];
    currencyShort = json['currencyShort'];
    // date=json['date'].toDate();
    date = json['date'] != null
        ? json['date'].toDate()
        : DateTime.now();
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['amount'] = this.amount;
    data['balance'] = this.balance;
    data['customerId'] = this.customerId;
    data['customerName'] = this.customerName;
    data['customerPhone'] = this.customerPhone;
    data['image'] = this.image;
    data['noBook'] = this.noBook;
    data['purchaseId'] = this.purchaseId;
    data['shopId'] = this.shopId;
    data['verification'] = this.verification;
    data['status'] = this.status;
    data['delete'] = this.delete;
    data['shopName'] = this.shopName;
    data['bookName'] = this.bookName;
    data['bookId'] = this.bookId;
    data['currencyShort'] = this.currencyShort;
    data['date']=this.date;
    data['type']=this.type;
    return data;
  }
}