
class TransactionModel {
  double? amount;
  double? balance;
  String? customerId;
  String? customerName;
  String? customerPhone;
  String? image;
  String? transactionId;
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

  TransactionModel(
      {this.amount,
        this.customerId,
        this.customerName,
        this.customerPhone,
        this.image,
        this.transactionId,
        this.shopId,
        this.verification,
        this.status,
        this.shopName,
        this.noBook,
        this.delete,
        this.type,
        this.date,
        this.bookName,
        this.bookId,
        this.balance,
        this.currencyShort,
      });

  TransactionModel.fromJson(Map<String, dynamic> json) {
    amount = double.tryParse(json['amount'].toString())??0;
    balance = double.tryParse(json['balance'].toString())??0;
    customerId = json['customerId'];
    customerName = json['customerName'];
    customerPhone = json['customerPhone'];
    image = json['image'];
    transactionId = json['transactionId'].toString();
    shopId = json['shopId'];
    verification = json['verification'];
    delete = json['delete'];
    status = json['status'];
    shopName = json['shopName'];
    noBook = json['noBook'];
    bookName = json['bookName'];
    bookId = json['bookId'];
    type = json['type'];
    currencyShort = json['currencyShort'];
    date = json['date'] != null
        ? json['date'].toDate(): DateTime.now();
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['amount'] = this.amount;
    data['balance'] = this.balance;
    data['customerId'] = this.customerId;
    data['customerName'] = this.customerName;
    data['customerPhone'] = this.customerPhone;
    data['image'] = this.image;
    data['transactionId'] = this.transactionId;
    data['shopId'] = this.shopId;
    data['verification'] = this.verification;
    data['status'] = this.status;
    data['shopName'] = this.shopName;
    data['noBook'] = this.noBook;
    data['delete'] = this.delete;
    data['bookName'] = this.bookName;
    data['type'] = this.type;
    data['bookId'] = this.bookId;
    data['currencyShort'] = this.currencyShort;
    data['date']=this.date;
    return data;
  }
}