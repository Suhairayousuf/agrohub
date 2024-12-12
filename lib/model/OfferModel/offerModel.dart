import 'dart:convert';

OfferModel OfferModelFromJson(String str) => OfferModel.fromJson(json.decode(str));

String OfferModelToJson(OfferModel data) => json.encode(data.toJson());
class OfferModel {
  DateTime? createdDate;
  DateTime? endDate;
  String? id;
  String? image;
  DateTime? startDate;
  String? shopId;
  String? title;
  String? description;
  String? shopImage;

  OfferModel(
      {
        this.createdDate,
        this.endDate,
        this.id,
        this.image,
        this.startDate,
        this.shopImage,
        this.shopId,
        this.description,
        this.title,
      });

  OfferModel.fromJson(Map<String, dynamic> json) {
    createdDate = json['createdDate'].toDate();
    endDate = json['endDate']==null?DateTime.now():json['endDate'].toDate();
    id = json['id'];
    image = json['image'];
    startDate = json['startDate']==null?DateTime.now():json['startDate'].toDate();
    shopId = json['shopId'];
    title = json['title'];
    description = json['description'];
    shopImage = json['shopImage'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['createdDate'] = this.createdDate;
    data['endDate'] = this.endDate;
    data['id'] = this.id;
    data['image'] = this.image;
    data['startDate'] = this.startDate;
    data['shopId'] = this.shopId;
    data['title'] = this.title;
    data['description'] = this.description;
    data['shopImage'] = this.shopImage;
    return data;
  }
}