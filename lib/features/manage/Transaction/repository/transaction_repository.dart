import 'package:agrohub/Model/TransactionModel/transactionModel.dart';
import 'package:agrohub/core/providers/firebase_providers.dart';
import 'package:agrohub/features/Home/screen/selectShop.dart';
import 'package:agrohub/model/purchase/purchaseModel.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

import '../../../../Model/bookModel.dart';
import '../../../../core/constants/firebase_constants.dart';

 final transactionRepositoryProvider=Provider((ref) => TransactionRepository(firestore: ref.read(firestoreProvider)));




class TransactionRepository{

  final FirebaseFirestore _firestore;

  TransactionRepository({required FirebaseFirestore firestore})
      : _firestore = firestore;

  Stream<List<TransactionModel>> getTransaction({required DateTime fromdate, required DateTime todate}) {

    return  _firestore.collectionGroup(FirebaseConstants.transactions).
        where('shopId',isEqualTo:currentshopId)
        .where('date',isGreaterThanOrEqualTo: fromdate)
        .where('date',isLessThanOrEqualTo: todate)
          .where('delete',isEqualTo: false).orderBy('date').snapshots().map((event) =>
        event.docs.map((e) => TransactionModel.fromJson(e.data() )).toList());


    // doc(shopId).collection(FirebaseConstants.books).where('delete',isEqualTo: false)
    //     .snapshots()
    //     .map((event) =>
    //     event.docs.map((e) => BookModel.fromJson(e.data() )).toList());

  }

  Stream<List<PurchaseModel>> getPurchases({required DateTime fromdate, required DateTime todate}) {

    return  _firestore.collectionGroup(FirebaseConstants.purchase).
    where('shopId',isEqualTo:currentshopId)
        .where('date',isGreaterThanOrEqualTo: fromdate)
        .where('date',isLessThanOrEqualTo: todate)
        .where('delete',isEqualTo: false).orderBy('date').snapshots().map((event) =>
        event.docs.map((e) => PurchaseModel.fromJson(e.data() )).toList());


    // doc(shopId).collection(FirebaseConstants.books).where('delete',isEqualTo: false)
    //     .snapshots()
    //     .map((event) =>
    //     event.docs.map((e) => BookModel.fromJson(e.data() )).toList());

  }
  Stream<List<BookModel>> getTotalCredit() {

    return  _firestore.collection(FirebaseConstants.shop)
        .doc(currentshopId).collection('book').where('delete',isEqualTo: false).snapshots().map((event) =>
        event.docs.map((e) => BookModel.fromJson(e.data() )).toList());


    // doc(shopId).collection(FirebaseConstants.books).where('delete',isEqualTo: false)
    //     .snapshots()
    //     .map((event) =>
    //     event.docs.map((e) => BookModel.fromJson(e.data() )).toList());

  }

  Stream<List<BookModel>>getCustomers(){
    return _firestore.collection(FirebaseConstants.shop)
        .doc(currentshopId)
        .collection('book').where('delete',isEqualTo: false).snapshots().map((event) =>
        event.docs.map((e) => BookModel.fromJson(e.data() )).toList());
  }



}