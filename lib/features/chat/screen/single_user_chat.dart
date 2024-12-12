// import 'package:cloud_firestore/cloud_firestore.dart';
// import 'package:flutter/cupertino.dart';
// import 'package:flutter/material.dart';
// import 'package:google_fonts/google_fonts.dart';
// import 'package:intl/intl.dart';
// import 'package:shop/Home/selectShop.dart';
//
// import '../themes/color.dart';
//
// class ChatPage extends StatefulWidget {
//   final String userId;
//   final String userName;
//   const ChatPage({Key? key,  required this.userId, required this.userName}) : super(key: key);
//
//   @override
//   State<ChatPage> createState() => _ChatPageState();
// }
//
// class _ChatPageState extends State<ChatPage> {
//   FocusNode focusNode = FocusNode();
//   bool show = false;
//   // updateSeen() async {
//   //   QuerySnapshot data = await FirebaseFirestore.instance
//   //       .collection('users')
//   //       .doc(widget.userId).collection('chat').
//   //   where('senderId',isEqualTo: widget.userId).where('isRead',isEqualTo: false)
//   //       .get();
//   //   for(var doc in data.docs){
//   //     FirebaseFirestore.instance.collection('users').doc(widget.userId).collection('chat').doc(doc.id).update(
//   //         {
//   //          'isRead':true,
//   //         });
//   //   }
//   //   if(mounted){
//   //     setState(() {
//   //
//   //     });
//   //   }
//   //
//   //   // msgList = data.get('chat');
//   //   // for (var item in msgList) {
//   //   //   if (item['sender'] == 1 && item['seen'] == false) {
//   //   //     item['seen'] = true;
//   //   //     FirebaseFirestore.instance
//   //   //         .collection('feedback')
//   //   //         .doc(currentuserid)
//   //   //         .update({
//   //   //       'chat': msgList,
//   //   //       // item['seen']:true,
//   //   //       //'adress': deliveryAddress,
//   //   //     });
//   //   //   }
//   //   // }
//   // }
//   TextEditingController messagecontroller = TextEditingController();
//   @override
//   void initState() {
//     super.initState();
//     // updateSeen();
//     focusNode.addListener(() {
//       if (focusNode.hasFocus) {
//         setState(() {
//           show = false;
//         });
//       }
//     });
//   }
//   @override
//   Widget build(BuildContext context) {
//     return SafeArea(
//       child: Scaffold(
//         body: Container(
//           color: primarycolor1,
//           child: StreamBuilder<QuerySnapshot>(
//               stream: FirebaseFirestore
//                   .instance
//                   .collection('users')
//                   .doc(widget.userId)
//                   .collection('chat')
//                   .snapshots(),
//
//               builder: (context, snapshot) {
//                 return Column(
//                   mainAxisAlignment: MainAxisAlignment.center,
//                   crossAxisAlignment: CrossAxisAlignment.center,
//                   children: [
//                     SizedBox(
//                       height: 15,
//                     ),
//                     Row(
//                       children: [
//                         IconButton(
//                           onPressed: () {
//                             Navigator.pop(context);
//                           },
//                           icon: Icon(
//                             Icons.arrow_back,
//                             color: Color(0xffffffff),
//                           ),
//                         ),
//                         // CircleAvatar(
//                         //   radius: 22,
//                         //   backgroundImage: NetworkImage(widget.userimage),
//                         // ),
//                         SizedBox(
//                           width: 10,
//                         ),
//                         Column(
//                           mainAxisAlignment: MainAxisAlignment.start,
//                           crossAxisAlignment: CrossAxisAlignment.start,
//                           children: [
//                             Text(
//                               widget.userName??"",
//                               style: GoogleFonts.montserrat(
//                                   fontSize: 18,
//                                   fontWeight: FontWeight.w500,
//                                   color: Colors.white),
//                             ),
//                             Text(
//                               "online",
//                               style: GoogleFonts.montserrat(
//                                   fontSize: 14, color: Color(0xffe3ecf1)),
//                             )
//                           ],
//                         ),
//                       ],
//                     ),
//                     Expanded(
//                       child: StreamBuilder<QuerySnapshot>(
//                           stream: FirebaseFirestore.instance.collection('users').doc(widget.userId)
//                               .collection('chat')
//                               .orderBy('sendTime', descending: true)
//                               .snapshots(),
//                           builder: (context, snapshot) {
//
//                             if (!snapshot.hasData) {
//                               return Center(child: CircularProgressIndicator());
//                             }
//                             return Container(
//                                 color: Colors.white,
//                                 child: ListView.builder(
//                                     reverse: true,
//                                     itemCount: snapshot.data!.docs.length,
//                                     itemBuilder: (context, index) {
//
//                                       var chats = snapshot.data!.docs;
//                                       Timestamp times =
//                                       chats[index]['sendTime'];
//                                       DateTime dates = times.toDate();
//                                       if ((chats[index]['senderId'] ==
//                                          currentshopId || chats[index]['receiverId'] ==
//                                               currentshopId) &&
//                                           (chats[index]['senderId'] == widget.userId ||
//                                               chats[index]['receiverId'] ==
//                                                   widget.userId)) {
//
//                                         if (chats[index]['senderId'] == widget.userId) {
//                                           FirebaseFirestore.instance.collection('users').doc(widget.userId)
//                                               .collection('chat')
//                                               .doc(chats[index]['msgId']??"".toString())
//                                               .update({"isRead": true});
//                                         }
//                                         return
//                                        Container(
//                                             padding: const EdgeInsets.only(
//                                                 left: 14,
//                                                 right: 14,
//                                                 top: 10,
//                                                 bottom: 10),
//                                             child: Align(
//                                               alignment: chats[index]['senderId'] == widget.userId
//                                                   ? Alignment.topLeft
//                                                   : Alignment.topRight,
//                                               child: ConstrainedBox(
//                                                 constraints: BoxConstraints(
//                                                     maxWidth:
//                                                     MediaQuery.of(context)
//                                                         .size
//                                                         .width -
//                                                         45,
//                                                     minWidth: 110),
//                                                 child: Card(
//                                                   elevation: .7,
//                                                   shadowColor: Colors.grey,
//
//                                                   //       shape: RoundedRectangleBorder(
//                                                   //           borderRadius: (chats[index]['senderId']==widget.rid)?
//                                                   //           BorderRadius.only(
//                                                   //               topRight: Radius.circular(20),
//                                                   //               topLeft: Radius.circular(20),
//                                                   //               bottomRight: Radius.circular(20)
//                                                   //           ):BorderRadius.only(
//                                                   //               topRight: Radius.circular(20),
//                                                   //               topLeft: Radius.circular(20),
//                                                   //               bottomLeft: Radius.circular(20)
//                                                   //           ),
//                                                   // ),
//                                                   shape: RoundedRectangleBorder(
//                                                     borderRadius:
//                                                     BorderRadius.circular(
//
//                                                         15),
//                                                   ),
//                                                   color: (chats[index]['senderId'] ==currentshopId
//                                                       ?  primarycolor1
//                                                       :Colors.grey.withOpacity(0.5)),
//                                                   margin: EdgeInsets.symmetric(
//                                                       horizontal: 10,
//                                                       vertical: 7),
//                                                   child: Stack(children: [
//                                                     Padding(
//                                                       padding:
//                                                       const EdgeInsets.only(
//                                                         left: 10,
//                                                         right: 30,
//                                                         top: 5,
//                                                         bottom: 20,
//                                                       ),
//                                                       child: Text(
//                                                         chats[index]["message"],
//                                                         style: GoogleFonts.montserrat(
//                                                             fontSize: 16,
//                                                             color: Color(
//                                                                 0xffd0dde3)),
//                                                       ),
//                                                     ),
//                                                     Positioned(
//                                                       bottom: 4,
//                                                       right: 10,
//                                                       child: Row(
//                                                         children: [
//                                                           Text(
//                                                             DateFormat('h:mm a')
//                                                                 .format(dates)
//                                                                 .toLowerCase(),
//                                                             style: GoogleFonts.montserrat(
//                                                               fontSize: 13,
//                                                               color: Color(
//                                                                   0xff6a777f),
//                                                             ),
//                                                           ),
//                                                           SizedBox(
//                                                             width: 2,
//                                                           ),
//                                                           chats[index]['senderId']==currentshopId?Icon(
//                                                             Icons.done_all,
//                                                             size: 15,
//                                                             color:chats[index]['isRead']? Color(
//                                                                 0xff6ccae6):Colors.grey,
//                                                           ):SizedBox(),
//                                                         ],
//                                                       ),
//                                                     )
//                                                   ]),
//                                                 ),
//                                               ),
//                                             ));
//                                       }
//                                       return SizedBox();
//                                     }));
//                           }),
//                     ),
//                     Container(
//                       color: Colors.white,
//                       child: Column(
//                         mainAxisAlignment: MainAxisAlignment.end,
//                         children: [
//                           Row(
//                             children: [
//                               Container(
//                                 height: 50,
//                                 width: 300,
//                                 decoration: BoxDecoration(
//                                   borderRadius: BorderRadius.circular(30),
//                                   color:Colors.grey.withOpacity(0.4),
//                                 ),
//                                 child: Container(
//                                   child: Row(
//                                     children: [
//                                       SizedBox(width: 16,),
//                                       // Padding(
//                                       //   padding: const EdgeInsets.all(8.0),
//                                       //
//                                       //   // child: Icon(Icons.emoji_emotions_outlined,color: Color(0xff8795a0),),
//                                       //   child: IconButton(
//                                       //     onPressed: () {
//                                       //       focusNode.unfocus();
//                                       //       focusNode.canRequestFocus = false;
//                                       //
//                                       //       setState(() {
//                                       //         show = !show;
//                                       //         //if show is true the show will become false
//                                       //         // if show is false the show will become false
//                                       //       });
//                                       //     },
//                                       //     icon: Icon(
//                                       //       Icons.emoji_emotions_outlined,
//                                       //       color: Color(0xff8795a0),
//                                       //     ),
//                                       //   ),
//                                       // ),
//                                       Expanded(
//                                         child: TextField(
//                                           focusNode: focusNode,
//                                           controller: messagecontroller,
//                                           decoration: InputDecoration(
//                                               border: InputBorder.none,
//                                               hintText: "Message",
//                                               hintStyle: GoogleFonts.montserrat(
//                                                 fontSize: 18,
//                                                 color: Color(0xff8795a0),
//                                               )),
//                                           onChanged: (value){
//                                             setState((){});
//                                           },
//
//                                         ),
//                                       ),
//                                       // Transform.rotate(
//                                       //   angle: -10,
//                                       //   // child: Icon(Icons.attach_file_outlined,
//                                       //   //   color: Color(0xff8795a0),
//                                       //   // ),
//                                       //   child: IconButton(
//                                       //     onPressed: () {
//                                       //       showModalBottomSheet(
//                                       //           backgroundColor:
//                                       //           Colors.transparent,
//                                       //           context: context,
//                                       //           builder: (builder) =>
//                                       //               bottomsheet());
//                                       //     },
//                                       //     icon: Icon(
//                                       //       Icons.attach_file_outlined,
//                                       //       color: Color(0xff8795a0),
//                                       //     ),
//                                       //   ),
//                                       // ),
//                                       // SizedBox(
//                                       //   width: 8,
//                                       // ),
//                                       // Padding(
//                                       //   padding: const EdgeInsets.all(8.0),
//                                       //   child: Icon(
//                                       //     Icons.camera_alt,
//                                       //     color: Color(0xff8795a0),
//                                       //   ),
//                                       // ),
//                                     ],
//                                   ),
//                                 ),
//                               ),
//                               SizedBox(
//                                 width: 10,
//                               ),
//                               CircleAvatar(
//                                 radius: 25,
//                                 backgroundColor:  Color(0xffFF808B),
//                                 child: IconButton(
//                                   onPressed: () {
//                                     setState((){});
//                                     if (messagecontroller.text.isNotEmpty) {
//                                       FirebaseFirestore.instance.collection('users').doc(widget.userId)
//                                           .collection('chat')
//                                           .add({
//                                         "message": messagecontroller.text,
//                                         "receiverId":widget.userId,
//                                         "senderId": currentshopId,
//                                         "sendTime": DateTime.now(),
//                                         "isRead": false,
//                                       }).then((value) {
//                                         value.update({'msgId': value.id,});
//                                       });
//
//                                       messagecontroller.clear();
//                                     }
//                                   },
//                                   // icon:(messagecontroller.text.isEmpty)? Icon(Icons.keyboard_voice_sharp,
//                                   //   color: Color(0xfffffefe),
//                                   // ):
//                                   icon: Icon(Icons.send,
//                                     color: Color(0xfffffefe),
//                                   ),
//                                 ),
//                               ),
//                             ],
//                           ),
//                           // show ? emojiSelect() : Container(),
//                           SizedBox(
//                             height: 5,
//                           ),
//                         ],
//                       ),
//                     ),
//                   ],
//                 );
//               }),
//         ),
//       ),
//     );
//   }
// }