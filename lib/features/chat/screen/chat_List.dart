import 'dart:async';

import 'package:agrohub/Model/bookModel.dart';
import 'package:agrohub/features/chat/screen/single_user_chat_page.dart';
import 'package:badges/badges.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:badges/badges.dart' as badges;
import '../../../Model/chatmodel/chat_model.dart';
import '../../../core/utils/utils.dart';
import '../../../themes/color.dart';
import '../../Home/screen/selectShop.dart';
import '../controller/chat_controller.dart';

class ChatListPage extends ConsumerStatefulWidget {
  const ChatListPage({Key? key}) : super(key: key);

  @override
  ConsumerState<ChatListPage> createState() => _ChatListPageState();
}

class _ChatListPageState extends ConsumerState<ChatListPage> {
  List<ChatModel> chat = [];
  final membersList = StateProvider((ref) => []);

//  getUnreadChat(String userId) async {
//   int msgCount=0;
//   print(userId);
//    var query=FirebaseFirestore
//        .instance
//        .collection('users')
//        .doc(userId)
//        .collection('chat').where('isRead',isEqualTo: false).
//    where('receiverId',isEqualTo: currentshopId);
//    AggregateQuerySnapshot abc=await query.count().get();
//   msgCount=abc.count;
//   if(mounted){
//     setState(() {
//
//     });
//   }
//   return msgCount;
//   // FirebaseFirestore
//   //     .instance
//   //     .collection('users')
//   //     .doc(userId)
//   //     .collection('chat').where('isRead',isEqualTo: false).
//   //      where('receiverId',isEqualTo: currentshopId)
//   //     .snapshots().listen((event) {
//   //      msgCount=event.docs.length;
//   //
//   //
//   //      if(mounted){
//   //        setState(() {
//   //
//   //        });
//   //      }
//   // });
// }
getUnreadChat(String userId) async {
  int msgCount=await ref.read(chatControllerProvider.notifier).getUnreadChat(userId);
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
  // getChat() {
  //   FirebaseFirestore.instance.collectionGroup('chat').orderBy('sendTime')
  //       .where('receiverId',isEqualTo: currentshopId).snapshots().listen((value) {
  //        chat = [];
  //
  //     for (var abc in value.docs) {
  //       chat.add(ChatModel.fromJson(abc.data()!));
  //       print(chat);
  //       print('chat');
  //     }
  //     if (mounted) {
  //       setState(() {});
  //     }
  //   });
  // }
  // StreamSubscription? a;
  Future<StateProvider<List>>getAllMembers() async {

    ref.read(membersList.notifier).state=await ref.watch(getchatStreamProvider.future);
    print('llllllllllllllllll');
    print(membersList);
    // print(data);
   // await ref.read(getchatStreamProvider.future).then((value) {
     //   membersList=[];
     //       for(var doc in value){
     //         print('yyyyyyyyyyyyy');
     //         membersList.addAll(doc.members!);
     //
     //
     //       }
     // });
    setState(() {

    });

    return membersList;

  // a=  FirebaseFirestore.instance.collection('shops').
  //   doc(currentshopId).collection('book').snapshots().listen((event) {
  //     membersList=[];
  //     for(var doc in event.docs){
  //       print('yyyyyyyyyyyyy');
  //       membersList.addAll(doc['members']);
  //       print(membersList);
  //
  //
  //     }
  //     print(membersList);
  //     if(mounted){
  //       setState(() {
  //
  //       });
  //     }
  //   });
  }

  AppBar(String title) {
    return Container(
      width: width,
      height: width * 0.4,
      child: Stack(
        children: [
          Container(
            width: width * 1,
            height: width * 0.4,
            decoration: BoxDecoration(
              image: DecorationImage(
                  image: AssetImage("assets/appBar.png"), fit: BoxFit.cover),
            ),
            child: Row(
              children: [
                SizedBox(
                  width: width * 0.07,
                ),
                SizedBox(
                  width: width * 0.65,
                ),
              ],
            ),
          ),
          Positioned(
            top: width * 0.3,
            height: width * 0.13,
            child: Container(
              decoration: BoxDecoration(
                color: bgcolor,
                borderRadius: BorderRadius.only(
                    topLeft: Radius.circular(32.11),
                    topRight: Radius.circular(32.11)),
              ),
              width: width,
              height: width * 0.05,
              child: Row(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  Text(
                    title,
                    style: GoogleFonts.montserrat(
                        fontSize: 20,
                        color: primarycolor1,
                        fontWeight: FontWeight.w600),
                  ),
                ],
              ),
            ),
          ),
        ],
      ),
    );
  }

  @override
  void initState() {
     //getAllMembers();
    // getUnreadChat();
    // getChat();
    super.initState();
  }
  @override
  void didChangeDependencies() {
    getAllMembers();
    // TODO: implement didChangeDependencies
    super.didChangeDependencies();
  }

  @override
  void dispose() {
    // a?.cancel();
    super.dispose();
  }
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: bgcolor,
      body: SingleChildScrollView(
        child: Column(
          children: [
            AppBar("Users"),
            ref.read(membersList.notifier).state.length == 0
                ? Center(
              child: Container(
                child: Text(
                  'No users Found',
                  style: GoogleFonts.poppins(color: primarycolor2),
                ),
              ),
            )
                : Column(
              children: [
                SizedBox(
                  height: width * 0.03,
                ),
                Container(
                  height: height * 0.782,
                  child: ListView.builder(
                    shrinkWrap: true,
                    scrollDirection: Axis.vertical,
                    physics: BouncingScrollPhysics(),
                    itemCount: ref.read(membersList.notifier).state.length,
                    itemBuilder: (context, index) {


                      // int msgCount=0;
                      // msgCount= getUnreadChat(userMap[membersList[index]]['userId'].toString());
                      // ChatModel data = chat[index];
                      return StreamBuilder<QuerySnapshot>(
                        stream: FirebaseFirestore.instance.collection('users').where('userEmail',isEqualTo:ref.read(membersList.notifier).state[index]).snapshots(),
                        builder: (context, snapshot) {
                          if(!snapshot.hasData){
                            return Center(child: CircularProgressIndicator(),);
                          }
                          var user=snapshot.data!.docs[0];
                          return Padding(
                            padding: const EdgeInsets.only(
                                top: 20, left: 10, right: 10),
                            child: InkWell(
                              onTap: () {
                                Navigator.push(
                                    context,
                                    MaterialPageRoute(
                                        builder: (context) => ChatPage(
                                          userId: user['userId'].toString(),
                                          userName: user['userName'].toString(),
                                        )));
                              },
                              child: Container(
                                // padding: EdgeInsets.only(left: 10, right: 10),
                                height: height * 0.11,
                                width: width * 0.89,
                                decoration: BoxDecoration(
                                  borderRadius: BorderRadius.circular(9),
                                  color: Colors.white,
                                  boxShadow: const [
                                    BoxShadow(
                                      color: Color.fromRGBO(0, 0, 0, 0.1),
                                      // shadow color
                                      blurRadius: 15,
                                      // shadow radius
                                      offset: Offset(5, 10),
                                      // shadow offset
                                      spreadRadius: 0.4,
                                      // The amount the box should be inflated prior to applying the blur
                                      blurStyle:
                                      BlurStyle.normal, // set blur style
                                    ),
                                  ],
                                ),
                                child: Row(
                                  mainAxisAlignment: MainAxisAlignment.spaceAround,
                                  children: [
                                    Container(
                                      width: 200,
                                      child: Text(
                                        //membersList[index],
                                        user['userName'].toString(),
                                        style: GoogleFonts.montserrat(
                                            fontSize: 13,
                                            fontWeight: FontWeight.w500,
                                            color: Colors.black),
                                      ),
                                    ),
                                    StreamBuilder<QuerySnapshot>(
                                        stream:FirebaseFirestore
                                            .instance
                                            .collection('users')
                                            .doc(user['userId'].toString())
                                            .collection('chat').where('isRead',isEqualTo: false).
                                        where('receiverId',isEqualTo: currentshopId) .snapshots(),
                                        builder: (context, snapshot) {
                                          if(!snapshot.hasData){
                                            return const CircularProgressIndicator();
                                          }
                                          int od = snapshot.data!.docs.length;
                                          return od==0?Icon(Icons.notifications,color: Colors.blue.shade900,size: 30,) :
                                          badges.Badge(

                                              //elevation: 0,
                                              position: BadgePosition.topEnd(top: 1,end: 1),
                                              //padding: EdgeInsetsDirectional.only(end: 0),
                                              // badgeColor: Colors.red,
                                              badgeContent:od==0?Container(): Padding(
                                                padding: const EdgeInsets.all(1.0),
                                                child: Text(od.toString(),style: TextStyle(fontSize: 5,color: Colors.white
                                                ),),
                                              ),
                                              child:Icon(Icons.notifications,color: Colors.blue.shade900,size: 30,)

                                          );
                                        }
                                    ),
                                    // Padding(
                                    //   padding: const EdgeInsets.only(top: 35.0),
                                    //   child: Container(
                                    //     width: 30,
                                    //     child: Stack(
                                    //
                                    //       children: [
                                    //         Icon(Icons.notifications,size: 25,color: Colors.black,),
                                    //         msgCount==0?Container():Align(
                                    //           alignment: Alignment.topRight,
                                    //           child:Container(
                                    //               decoration: BoxDecoration(
                                    //                   color: Colors.red,
                                    //                   shape: BoxShape.circle
                                    //               ),
                                    //               child: Padding(
                                    //                 padding: const EdgeInsets.all(3.0),
                                    //                 child: Text( msgCount.toString(),style: TextStyle(
                                    //                     color: Colors.white,fontSize: 8
                                    //                 ),),
                                    //               )) ,
                                    //         )
                                    //       ],
                                    //     ),
                                    //   ),
                                    // ),
                                  ],
                                ),
                              ),
                            ),
                          );
                        }
                      );
                    },
                  ),
                ),
              ],
            ),
          ],
        ),
      ),
    );
  }
}
