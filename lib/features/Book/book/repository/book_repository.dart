
import 'dart:async';

import 'package:agrohub/Model/bookModel.dart';
import 'package:agrohub/Model/purchase/purchaseModel.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:fpdart/fpdart.dart';
import 'package:google_fonts/google_fonts.dart';

import '../../../../Model/TransactionModel/transactionModel.dart';
import '../../../../core/constants/firebase_constants.dart';
import '../../../../core/failure.dart';
import '../../../../core/providers/firebase_providers.dart';
import '../../../../core/utils/utils.dart';
import '../../../Home/screen/NavigationBar.dart';
import '../../../Home/screen/selectShop.dart';
import '../../member/screen/AddMembers.dart';

final bookRepositoryProvider = Provider((ref) => BookRepository(firestore: ref.read(firestoreProvider)));
class BookRepository {


  final FirebaseFirestore _firestore;

  BookRepository({required FirebaseFirestore firestore})
      : _firestore = firestore;

  CollectionReference get _books =>
      _firestore.collection(FirebaseConstants.shop);

  addBook({required BuildContext context,required BookModel bookModel}) {
    try {
      return right(
          _books.doc(currentshopId).collection(FirebaseConstants.books).add
            (bookModel.toJson())
              .then((value) {

            value.update({
              'bookId': value.id,
            });
            Navigator.pushReplacement(
                context,
                MaterialPageRoute(
                    builder: (context) =>
                        AddMembersPage(bookData: bookModel.copyWith(bookId: value.id))));
          }));

    } on FirebaseException catch (e) {
      throw e.message!;
    } catch (e) {
      return left(Failure(e.toString()));
    }
  }
  updateBook({required BuildContext context,required BookModel bookModel}) {
    try {
      return right(
          _books.doc(currentshopId).collection(FirebaseConstants.books).doc(bookModel.bookId).update
            (bookModel.toJson()));


    } on FirebaseException catch (e) {
      throw e.message!;
    } catch (e) {
      return left(Failure(e.toString()));
    }
  }
  deleteBook({required BuildContext context,required BookModel bookModel}) {
    try {
      return right(
          _books.doc(currentshopId).
          collection(FirebaseConstants.books).doc(bookModel.bookId).update
            (bookModel.toJson()));


    } on FirebaseException catch (e) {
      throw e.message!;
    } catch (e) {
      return left(Failure(e.toString()));
    }
  }
  Stream<List<BookModel>> getBooks(String shopId) {
    return  _firestore.collection(FirebaseConstants.shop).
    doc(shopId).collection(FirebaseConstants.books).where('delete',isEqualTo: false)
        .snapshots()
        .map((event) =>
        event.docs.map((e) => BookModel.fromJson(e.data() )).toList());



  }
  List<TransactionModel> allTransaction=[];
  List<PurchaseModel>allPurchase=[];
  List statement=[];
  Stream<List> getAllTransactionPurchase({ required DateTime startOfToday}) {

    // return  _firestore.collectionGroup(FirebaseConstants.transactions)
    //     .where('shopId',isEqualTo: currentshopId).where('delete',isEqualTo: false)
    //     .where('date', isGreaterThanOrEqualTo: startOfToday).
    //      orderBy('date',descending: true)
    //     .snapshots().map((event) =>
    //     event.docs.map((e) => TransactionModel.fromJson(e.data() )).toList());
    return  _firestore.collectionGroup(FirebaseConstants.transactions)
        .where('shopId',isEqualTo: currentshopId).where('delete',isEqualTo: false)
        .where('date', isGreaterThanOrEqualTo: startOfToday).
    orderBy('date',descending: true)
        .snapshots().map((event) {
      allTransaction=[];
      for(DocumentSnapshot <Map<String,dynamic>> doc in event.docs){
        allTransaction.add(TransactionModel.fromJson(doc.data()!));
      }
      statement.addAll(allPurchase);
      statement.addAll(allTransaction);

      FirebaseFirestore.instance.collectionGroup('purchase')
          .where('shopId',isEqualTo: currentshopId).where('delete',isEqualTo: false)
          .where('date', isGreaterThanOrEqualTo: startOfToday)
          .orderBy('date',descending: true)
          .get().then((value) {

        allPurchase=[];

        for(DocumentSnapshot <Map<String,dynamic>> doc in event.docs){
          allPurchase.add(PurchaseModel.fromJson(doc.data()!));
        }
        statement=[];
        statement.addAll(allPurchase);
        statement.addAll(allTransaction);
        statement.sort((b, a) => a.date.compareTo(b.date));
      });

      print('list1');
      print(statement.length);
      print('list2');
      print(allTransaction.length);
      print('list3');
      print(allPurchase.length);

      return statement;

    }

    );

    // doc(shopId).collection(FirebaseConstants.books).where('delete',isEqualTo: false)
    //     .snapshots()
    //     .map((event) =>
    //     event.docs.map((e) => BookModel.fromJson(e.data() )).toList());

  }

  // Future<double> getCredit(String bookId, )async{
  //   // var credit=0.00;
  //     await  _firestore.collection(FirebaseConstants.shop).
  //   doc(currentshopId).collection('book').doc(bookId).get().then((event) {
  //    final credit=event.get('credit');
  //     print('credit1');
  //     print(credit);
  //       return credit;
  //   });
  // }
  Future<double> getCredit(String bookId) async {
    final document = await _firestore
        .collection(FirebaseConstants.shop)
        .doc(currentshopId)
        .collection('book')
        .doc(bookId)
        .get();

    final credit = document.get('credit');
    print('credit1');
    print(credit);

    return credit;
  }

  List<TransactionModel> allTransactionin30=[];

  List<PurchaseModel>allPurchasein30=[];
  List statementin30=[];

  Stream<List> getAllTransactionPurchaseIn30Days({ required DateTime startOfToday}) {

    return  _firestore.collectionGroup(FirebaseConstants.transactions)
        .where('shopId',isEqualTo: currentshopId).where('delete',isEqualTo: false)
        .where('date', isGreaterThanOrEqualTo: startOfToday.subtract(Duration(days: 30))).
      orderBy('date',descending: true)
        .snapshots().map((event) {
      allTransactionin30=[];
      for(DocumentSnapshot <Map<String,dynamic>> doc in event.docs){
        allTransactionin30.add(TransactionModel.fromJson(doc.data()!));
      }
      statementin30.addAll(allPurchasein30);
      statementin30.addAll(allTransactionin30);

      FirebaseFirestore.instance.collectionGroup('purchase')
          .where('shopId',isEqualTo: currentshopId).where('delete',isEqualTo: false)
          .where('date', isGreaterThanOrEqualTo: startOfToday.subtract(Duration(days: 30)))
          .orderBy('date',descending: true)
          .get().then((value) {

        allPurchasein30=[];

        for(DocumentSnapshot <Map<String,dynamic>> doc in event.docs){
          allPurchasein30.add(PurchaseModel.fromJson(doc.data()!));
        }
        statementin30=[];
        statementin30.addAll(allPurchasein30);
        statementin30.addAll(allTransactionin30);
        statementin30.sort((b, a) => a.date.compareTo(b.date));
      });



      return statementin30;

    }

    );

    // doc(shopId).collection(FirebaseConstants.books).where('delete',isEqualTo: false)
    //     .snapshots()
    //     .map((event) =>
    //     event.docs.map((e) => BookModel.fromJson(e.data() )).toList());

  }

 Future getUsers(List members) async {
   await  _firestore.collection(FirebaseConstants.usersCollection)
        .where('shopId',isEqualTo: currentshopId)
        .where('userEmail',whereIn: members).get().then((event) async {
      userList=[];
      for(var doc in event.docs){
        userList.add(doc.data());
        userMap[doc['userEmail']]=doc.data();

      }
      return  userMap;
      // if(members!.isNotEmpty){
      //   memberName=userMap[members![0]]['userName'];
      //   userID=userMap[members![0]]['userId'];
      //   profImage=userMap[members![0]]['userImage'];
      //   customerName=userMap[members![0]]['userName'];
      //   customerPhone=userMap[members![0]]['phone'];
      //   customerEmail=userMap[members![0]]['userEmail'];
      //   companyName=userMap[members![0]]['companyName'];
      //   phoneCode=userMap[members![0]]['phonePrefix'];
      //   whatsappNumber=userMap[members![0]]['whatsappNumber'];
      //   whatsAppNumberController=TextEditingController(text: whatsappNumber.isEmpty?customerPhone:whatsappNumber);
      //
      //   phoneCode=phoneCode.isEmpty?'974':phoneCode;
      // }
      // await Future.delayed(const Duration(milliseconds: 100));
      // _speakText();
      //
      // if(mounted){
      //   setState(() {
      //     showWhatsapp=true;
      //   });
      // }


    });

  }

   createPurchase(PurchaseModel purchaseData,BuildContext context)  {
    bool error = false;
    try{
      FirebaseFirestore.instance.runTransaction((transaction) async {
        DocumentReference a=_firestore
            .collection(FirebaseConstants.usersCollection)
            .doc(purchaseData.customerId)
            .collection('purchase').doc();
        purchaseData.purchaseId=a.id;
        transaction.set (a, purchaseData.toJson());
        transaction.update(FirebaseFirestore.instance
            .collection('shops')
            .doc(currentshopId)
            .collection('book')
            .doc(purchaseData.bookId), {
          'credit': FieldValue.increment(purchaseData.amount ?? 0.00),
          'update': DateTime.now(),
        });
        transaction.update(FirebaseFirestore.instance.collection('shops').doc(currentshopId), {
          'totalCredit': FieldValue.increment(purchaseData.amount ?? 0.00),
        });

      })
          .catchError((err){
        error=true;
        showErrorMessage(context, err.toString(), style:  GoogleFonts.montserrat());
      });
      // if(mounted && !error){
        showUploadMessage1(context,
            'amount added successfully',
            style: GoogleFonts
                .montserrat());
      // }
      // FirebaseFirestore.instance
      //     .collection('users')
      //     .doc(purchaseData.customerId)
      //     .collection('purchase')
      //     .add(purchaseData.toJson())
      //     .then((value) {
      //   value.update({'purchaseId': value.id});
      // });
      // FirebaseFirestore.instance
      //     .collection('shops')
      //     .doc(currentshopId)
      //     .collection('book')
      //     .doc(widget.bookId)
      //     .update({
      //   'credit': FieldValue.increment(purchaseData.amount ?? 0.00),
      //   'update': DateTime.now(),
      // });
      //
      // FirebaseFirestore.instance.collection('shops').doc(currentshopId).update({
      //   'totalCredit': FieldValue.increment(purchaseData.amount ?? 0.00),
      // });
    }catch(e){
      showErrorMessage(context, e.toString(), style:  GoogleFonts.montserrat());
    }
  }





}
