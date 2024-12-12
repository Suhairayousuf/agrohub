import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:onscreen_keyboard/data/loading.dart';

import '../../../Model/OfferModel/offerModel.dart';
import '../../../Model/bookModel.dart';
import '../../../core/constants/firebase_constants.dart';
import '../../../core/providers/firebase_providers.dart';
import '../../../model/shop_model/shop_model.dart';
import '../../Book/book/repository/book_repository.dart';
import '../../auth/screen/splash.dart';
import '../screen/NavigationBar.dart';
import '../screen/selectShop.dart';


final homeRepositoryProvider = Provider((ref) => HomeRepository(firestore: ref.read(firestoreProvider)));

class HomeRepository{
  CollectionReference get _shop => _firestore.collection(FirebaseConstants.shop);

  final FirebaseFirestore _firestore;

  HomeRepository({required FirebaseFirestore firestore})
      : _firestore = firestore;

  Stream<List<StoreDetailsModel>> getShop(String email) {

    return  _firestore.collection(FirebaseConstants.shop).where('shopAdmins',arrayContains: email)
        .snapshots()
        .map((event) =>
        event.docs.map((e) => StoreDetailsModel.fromJson(e.data() as Map<String,dynamic>)).toList());




  }
  Stream<List<OfferModel>> getShopOffers(String shopId) {
    return  _firestore.collection(FirebaseConstants.shop).doc(shopId).collection(FirebaseConstants.offersCollection)
        .snapshots()
        .map((event) =>
        event.docs.map((e) => OfferModel.fromJson(e.data() )).toList());
  }
  Stream<List<BookModel>> getShopBooks(String shopId) {

    return  _firestore.collection(FirebaseConstants.shop).doc(shopId).collection(FirebaseConstants.books)
        .snapshots()
        .map((event) =>
        event.docs.map((e) => BookModel.fromJson(e.data() )).toList());
  }


  Future<bool> getsettings()async{
  final setting=  await  _firestore.collection(FirebaseConstants.settings).doc('settings').get();
   bool? transaction;
    // final trans=setting.docs.forEach((element) {
       transaction=setting["editTran"];
    // });
    //
    return transaction!;
  }

}