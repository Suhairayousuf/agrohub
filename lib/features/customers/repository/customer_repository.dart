import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

import '../../../core/constants/firebase_constants.dart';
import '../../../core/providers/firebase_providers.dart';
import '../../manage/Transaction/screen/ManagePage.dart';
final CustomerRepositoryProvider=
 Provider((ref) => CustomerRepository(firestore: ref.read(firestoreProvider)));

class CustomerRepository{
  final FirebaseFirestore _firestore;

  CustomerRepository({required FirebaseFirestore firestore})
      : _firestore = firestore;
  CollectionReference get _users =>FirebaseFirestore.instance.collection(FirebaseConstants.usersCollection);

  List<dynamic> getActiveCustomers() {

  List  customer = [];
  List activeCustomer = [];
  // List inactiveCustomer = [];
    for(var item in allBooks){
      // customer.add(item);
      if(!item.block!){
        activeCustomer.add(item);

      }

      // else{
      //   inactiveCustomer.add(item);
      // }
    }
      return activeCustomer;







    // return _firestore.collection('shops').
    // doc(currentshopId).collection('book').snapshots()
    //     .map((event) {
    //   List<dynamic> list=[];
    //   for(var a in event.docs){
    //     print(a['members']);
    //     print('members');
    //     list.addAll(a['members']);
    //     print(list);
    //   }
    //   return list;
    // });



  }
  List<dynamic> getInActiveCustomers() {

  List  customer = [];
 // List activeCustomer = [];
   List inactiveCustomer = [];
    for(var item in allBooks){
      customer.add(item);
      if(item.block!){
        inactiveCustomer.add(item);

      }

      // else{
      //   inactiveCustomer.add(item);
      // }
    }
      return inactiveCustomer;







    // return _firestore.collection('shops').
    // doc(currentshopId).collection('book').snapshots()
    //     .map((event) {
    //   List<dynamic> list=[];
    //   for(var a in event.docs){
    //     print(a['members']);
    //     print('members');
    //     list.addAll(a['members']);
    //     print(list);
    //   }
    //   return list;
    // });



  }
  List<dynamic> getCustomers() {

  List  customer = [];
 // List activeCustomer = [];
    for(var item in allBooks){
      customer.add(item);



      // else{
      //   inactiveCustomer.add(item);
      // }
    }

      return customer;







    // return _firestore.collection('shops').
    // doc(currentshopId).collection('book').snapshots()
    //     .map((event) {
    //   List<dynamic> list=[];
    //   for(var a in event.docs){
    //     print(a['members']);
    //     print('members');
    //     list.addAll(a['members']);
    //     print(list);
    //   }
    //   return list;
    // });



  }

}