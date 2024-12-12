
import 'package:agrohub/Model/OfferModel/offerModel.dart';
import 'package:agrohub/core/constants/firebase_constants.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:fpdart/fpdart.dart';

import '../../../core/failure.dart';
import '../../../core/providers/firebase_providers.dart';
import '../../Home/screen/selectShop.dart';

final offerRepositoryProvider=Provider((ref) => OfferRepository(firestore: ref.read(firestoreProvider)));

class OfferRepository{
   final FirebaseFirestore _firestore;
   OfferRepository({required FirebaseFirestore firestore})
       : _firestore = firestore;
   CollectionReference get _shop=> _firestore.collection(FirebaseConstants.shop);
   addOffer(BuildContext context,OfferModel offerModel){
    try{
       return right(
           _shop.doc(currentshopId).collection(FirebaseConstants.offersCollection)
               .add(offerModel.toJson())
               .then((value) {
              value.update({'id': value.id});
           })
       );
    }on FirebaseException catch (e) {
       throw e.message!;
    } catch (e) {
       return left(Failure(e.toString()));
    }

   }

   List<OfferModel>offersList = [];
   Stream<List<OfferModel>> getOffers() {
     return  _firestore.collection(FirebaseConstants.shop).
     doc(currentshopId).collection(FirebaseConstants.offersCollection)
         .snapshots()
         .map((event) {
       offersList = [];
       for (var doc in event.docs) {
         offersList.add(OfferModel.fromJson(doc.data()));
         print(offersList);
         print('offersList');
       }
       return offersList;

     });
         // event.docs.map((e) => OfferModel.fromJson(e.data() )).toList());



   }

}
