

import 'package:agrohub/core/constants/firebase_constants.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

import '../../../Model/bookModel.dart';
import '../../../core/providers/firebase_providers.dart';
import '../../Book/book/repository/book_repository.dart';
import '../../Home/screen/selectShop.dart';

final chatRepositoryProvider= Provider((ref) => ChatRepository(firestore: ref.read(firestoreProvider)));

class ChatRepository{
  final FirebaseFirestore _firestore;

  ChatRepository({required FirebaseFirestore firestore})
      : _firestore = firestore;
  CollectionReference get _users =>FirebaseFirestore.instance.collection(FirebaseConstants.usersCollection);

  Future<int>getUnreadChat(String userId) async {
    int msgCount=0;
    print(userId);
    var query=_users
        .doc(userId)
        .collection('chat').where('isRead',isEqualTo: false).
    where('receiverId',isEqualTo: currentshopId);
    AggregateQuerySnapshot abc=await query.count().get();
    msgCount=abc.count;

    return msgCount;
    // FirebaseFirestore
    //     .instance
    //     .collection('users')
    //     .doc(userId)
    //     .collection('chat').where('isRead',isEqualTo: false).
    //      where('receiverId',isEqualTo: currentshopId)
    //     .snapshots().listen((event) {
    //      msgCount=event.docs.length;
    //
    //
    //      if(mounted){
    //        setState(() {
    //
    //        });
    //      }
    // });
  }
// List membersList=[];
//   getAllMembers(){
//     _firestore.collection('shops').
//     doc(currentshopId).collection('book').snapshots().listen((event) {
//       membersList=[];
//       for(var doc in event.docs){
//         print('yyyyyyyyyyyyy');
//         membersList.addAll(doc['members']);
//         print(membersList);
//
//
//       }
//       print(membersList);
//
//     });
//   }

  Stream<List<dynamic>> getAllMembers() {
      return _firestore.collection('shops').
      doc(currentshopId).collection('book').snapshots()
        .map((event) {
          List<dynamic> list=[];
        for(var a in event.docs){
          print(a['members']);
          print('members');
          list.addAll(a['members']);
          print(list);
        }
        return list;
        });



  }

  sendMessage(userId,message,imgUrl) {
    // if (messageController.text!='' || imgUrl != "") {
    _users
        .doc(userId)
          .collection('chat').add({
        "message": message,
        "image": imgUrl,
        // "image": selectedImage != null ? selectedImage!.path : null,
        "receiverId": userId,
        "senderId": currentshopId,
        "sendTime": DateTime.now(),
        "isRead": false,
      })
          .then((value) {
        value.update({'msgId': value.id});
      });


      // setState(() {
      //
      // });
    // }
    // else{
    //   showUploadMessage1(context, 'Enter your mesage', style: GoogleFonts.montserrat());
    // }
  }



}