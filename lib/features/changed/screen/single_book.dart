// import 'dart:async';
//
// import 'package:cached_network_image/cached_network_image.dart';
// import 'package:cloud_firestore/cloud_firestore.dart';
// import 'package:flutter/material.dart';
// import 'package:flutter_svg/svg.dart';
// import 'package:flutter_tts/flutter_tts.dart';
// import 'package:google_fonts/google_fonts.dart';
// import 'package:intl/intl.dart';
//
// import 'package:url_launcher/url_launcher.dart';
// import 'package:virtual_keyboard_multi_language/virtual_keyboard_multi_language.dart';
//
//
// import '../../../Model/TransactionModel/transactionModel.dart';
// import '../../../Model/bookModel.dart';
// import '../../../Model/purchase/purchaseModel.dart';
// import '../../../core/utils/utils.dart';
// import '../../../themes/color.dart';
// import '../../Book/book/screen/send_bill.dart';
// import '../../Home/screen/NavigationBar.dart';
// import '../../Home/screen/homePage.dart';
// import '../../Home/screen/selectShop.dart';
// import '../../manage/Purchase/screen/sales_transaction_page.dart';
// import '../../auth/screen/splash.dart';
//
// class SingleBook extends StatefulWidget {
//   final BookModel bookData;
//   const SingleBook({Key? key, required this.bookData}) : super(key: key);
//
//   @override
//   State<SingleBook> createState() => _SingleBookState();
// }
//
// class _SingleBookState extends State<SingleBook> {
//   String memberName="";
//   String profImage="";
//   FlutterTts flutterTts = FlutterTts();
//   Future<dynamic> _speakText() async {
//
//     String text = memberName==''?'No Member Found':memberName;
//
//     await flutterTts.setLanguage('en-US');
//     // await flutterTts.setVoice({"name": "Karen", "locale": "en-AU"});
//     await flutterTts.setPitch(0.6);
//     await flutterTts.setSpeechRate(.6);
//     await flutterTts.speak(text);
//
//
//     await flutterTts.awaitSpeakCompletion(true);
//   }
//   List statement=[];
//   double credit=0.00;
//   List<TransactionModel> allTransaction=[];
//   List<PurchaseModel> allPurchase=[];
//   getCredit(){
//     d= FirebaseFirestore.instance.collection('shops').
//     doc(currentshopId).collection('book').doc(widget.bookData.bookId).snapshots().listen((event) {
//       credit=event.get('credit').toDouble();
//       if(mounted){
//         setState(() {
//
//         });
//       }
//
//     });
//   }
//   StreamSubscription? a;
//   StreamSubscription? b;
//   StreamSubscription? c;
//   StreamSubscription? d;
//   StreamSubscription? e;
//   getTransaction(){
//     a= FirebaseFirestore.instance.collectionGroup('transactions')
//         .where('shopId',isEqualTo: currentshopId).where('delete',isEqualTo: false)
//         .where('bookId',isEqualTo: widget.bookData.bookId)
//         .where('date',isGreaterThan: DateTime.now().subtract(Duration(days: 30)))
//         .orderBy('date',descending: true)
//         .snapshots()
//         .listen((event) {
//       allTransaction =[];
//       for(DocumentSnapshot <Map<String,dynamic>> doc in event.docs){
//         allTransaction.add(TransactionModel.fromJson(doc.data()!));
//       }
//       statement=[];
//       statement.addAll(allPurchase);
//       statement.addAll(allTransaction);
//       statement.sort((b, a) => a.date.compareTo(b.date));
//       if(mounted){
//         setState(() {
//
//         });
//       }
//
//     });
//
//     b= FirebaseFirestore.instance.collectionGroup('purchase')
//         .where('shopId',isEqualTo: currentshopId)
//         .where('bookId',isEqualTo: widget.bookData.bookId).where('delete',isEqualTo: false)
//         .where('date',isGreaterThan: DateTime.now().subtract(const Duration(days: 30)))
//         .orderBy('date',descending: true)
//         .snapshots()
//         .listen((event) {
//       allPurchase=[];
//
//       for(DocumentSnapshot <Map<String,dynamic>> doc in event.docs){
//         allPurchase.add(PurchaseModel.fromJson(doc.data()!));
//       }
//
//       statement=[];
//       statement.addAll(allPurchase);
//       statement.addAll(allTransaction);
//
//       statement.sort((b, a) => a.date.compareTo(b.date));
//
//       if(mounted){
//         setState(() {
//
//
//         });
//       }
//
//     });
//
//
//     // statement.followedBy(allTransaction);
//
//
//   }
//
//   // AppBar(String title) {
//   //   return Container(
//   //     width: width,
//   //     height: width * 0.4,
//   //     child: Stack(
//   //       children: [
//   //         Container(
//   //           width: width * 1,
//   //           height: width * 0.4,
//   //           decoration: BoxDecoration(
//   //             image: DecorationImage(
//   //                 image: AssetImage("assets/appBar.png"), fit: BoxFit.cover),
//   //           ),),
//   //         Positioned(
//   //           top: width * 0.2,
//   //           height: width * 0.2,
//   //           child: Container(
//   //             decoration: BoxDecoration(
//   //               color: bgcolor,
//   //               borderRadius: BorderRadius.only(
//   //                   topLeft: Radius.circular(32.11),
//   //                   topRight: Radius.circular(32.11)),
//   //             ),
//   //             width: width,
//   //             height: width * 0.05,
//   //             child: Row(
//   //               mainAxisAlignment: MainAxisAlignment.center,
//   //               children: [
//   //                 Text(
//   //                   "",
//   //                   // title,
//   //                   style: GoogleFonts.montserrat(
//   //                       fontSize: 45,
//   //                       color: primarycolor1,
//   //                       fontWeight: FontWeight.w800),
//   //                 ),
//   //               ],
//   //             ),
//   //           ),
//   //         ),
//   //       ],
//   //     ),
//   //   );
//   // }
//   String customerName='';
//   String customerPhone='';
//   String customerEmail='';
//
//   getUsers(){
//     c=  FirebaseFirestore.instance.collection('users').where('userEmail',whereIn: widget.bookData.members).snapshots().listen((event) async {
//       userList=[];
//       // userEmailList=[];
//       // alluserMap={};
//       for(var doc in event.docs){
//         userList.add(doc.data());
//         // userEmailList.add(doc.get('userEmail'));
//         userMap[doc['userEmail']]=doc.data();
//         // alluserMap[doc['userEmail']]=doc.data();
//         // userIdMap[doc['userId']]=doc.data();
//
//       }
//       if(widget.bookData.members!.length!=0){
//         print('object1123');
//         memberName=userMap[widget.bookData.members![0]]['userName'];
//         profImage=userMap[widget.bookData.members![0]]['userImage'];
//         customerName=userMap[widget.bookData.members![0]]['userName'];
//         customerPhone=userMap[widget.bookData.members![0]]['phone'];
//         customerEmail=userMap[widget.bookData.members![0]]['userEmail'];
//       }
//       await Future.delayed(Duration(milliseconds: 100));
//       _speakText();
//
//       if(mounted){
//         setState(() {
//
//         });
//       }
//
//
//     });
//     // FirebaseFirestore.instance.collection('offlineUsers').snapshots().listen((event) {
//     //   allUserList=[];
//     //   offlineuserEmailList=[];
//     //   for(var doc in event.docs){
//     //     allUserList.add(doc.data());
//     //     offlineuserEmailList.add(doc.get('userEmail'));
//     //     alluserMap[doc['userEmail']]=doc.data();
//     //     // userIdMap[doc['userId']]=doc.data();
//     //   }
//     //   offlineuserEmailList.addAll(userEmailList);
//     //   allUserList.addAll(userList);
//     //
//     //   if(mounted){
//     //     setState(() {
//     //
//     //     });
//     //   }
//     //
//     //
//     // });
//
//   }
//
//
//
//   @override
//   void initState() {
//     if(widget.bookData.members!.isNotEmpty){
//       getUsers();
//     }
//
//     getCredit();
//     getTransaction();
//     super.initState();
//   }
//   set(){
//     setState(() {
//
//     });
//   }
//
//   @override
//   void dispose() {
//     a?.cancel();
//     b?.cancel();
//     c?.cancel();
//     d?.cancel();
//     super.dispose();
//   }
//
//   @override
//   Widget build(BuildContext context) {
//     var w=MediaQuery.of(context).size.width;
//     return Scaffold(
//       backgroundColor: primarycolor1,
//       appBar: AppBar(
//         leading: IconButton(
//           onPressed: () {
//             Navigator.pop(context);
//           },
//           icon: Icon(Icons.arrow_back_ios),
//         ),
//         elevation: 0,
//         backgroundColor: primarycolor1,
//         title:  Text(
//           '${widget.bookData.bookName}',
//           style:
//           GoogleFonts.montserrat(
//               // fontSize: w*0.1,
//               fontWeight: FontWeight.bold,
//               color: Colors.white
//           ),
//
//         ),
//         actions: [
//           Center(child: InkWell(
//             onTap: (){
//               Navigator.push(context, MaterialPageRoute(builder: (context)=>SendBill(phone: customerPhone.toString(), name: customerName,id: customerEmail,bookId: widget.bookData.bookId??'', bookName: widget.bookData.bookName??'', creditLimit: widget.bookData.creditLimit??0,bookCredit: widget.bookData.credit??0,)));
//             },
//             child: Container(
//                 decoration: BoxDecoration(
//                     color: Colors.white,
//                     borderRadius: BorderRadius.circular(10)
//                 ),
//                 child: Padding(
//                   padding: const EdgeInsets.fromLTRB(15,5,15,5),
//                   child: Text('Send Bill',style: TextStyle(fontSize: 14,fontWeight: FontWeight.w600,color: primarycolor1),),
//                 )),
//           )),
//           SizedBox(width: 10,),
//         ],
//       ),
//
//
//       // backgroundColor: bgcolor,
//       body:  Column(
//         children: [
//
//           Padding(
//             padding:  EdgeInsets.fromLTRB(w*0.05,0,w*0.05,w*0.05),
//             child: Container(
//
//               decoration: BoxDecoration(
//                 color: Colors.white.withOpacity(0.2),
//                 borderRadius: BorderRadius.circular(w*0.25)
//               ),
//               child: Row(
//                 children: [
//                   Expanded(
//                     flex: 1,
//                     child: Container(
//                       height: w*0.25,
//                       decoration: BoxDecoration(
//                           shape: BoxShape.circle,
//                         border: Border.all(color: Colors.white),
//                         image: DecorationImage(
//                           image: (profImage!=""&&!profImage.startsWith('/'))?
//                           CachedNetworkImageProvider(profImage):Image.asset('assets/appBar.png').image,fit: BoxFit.cover,
//                         )
//                       ),
//                     ),
//                   ),
//                   SizedBox(width: w*0.05,),
//                   Expanded(
//                     flex: 3,
//                     child: Column(
//                       mainAxisAlignment: MainAxisAlignment.start,
//                       crossAxisAlignment: CrossAxisAlignment.stretch,
//                       children: [
//                         Text(
//                           '${customerName.toString()}',
//                           style:
//                           GoogleFonts.montserrat(
//                               fontSize: w*0.035,
//                               fontWeight: FontWeight.bold,
//                               color: Colors.white
//                           ),
//
//                         ),
//                         SizedBox(height: w*0.015,),
//                         Text(
//                           'ID : ${ customerEmail.toString()}',
//                           style:
//                           GoogleFonts.montserrat(
//                               fontSize: 14,
//
//                               color: Colors.white
//                           ),
//
//                         ),
//                         SizedBox(height: w*0.015,),
//                         Text(
//                           'PHONE : ${ customerPhone.toString()}',
//                           style:
//                           GoogleFonts.montserrat(
//                               fontSize: 14,
//
//                               color: Colors.white
//                           ),
//
//                         ),
//                       ],
//                     )
//                   )
//                 ],
//               ),
//             ),
//           ),
//           // Padding(
//           //   padding:  EdgeInsets.fromLTRB(w*0.05,0,w*0.05,w*0.025),
//           //   child: Row(
//           //     children: [
//           //       // Expanded(
//           //       //   child: Container(
//           //       //     decoration: BoxDecoration(
//           //       //         color: Colors.black.withOpacity(0.3),
//           //       //         borderRadius: BorderRadius.circular(20)
//           //       //     ),
//           //       //     child: Padding(
//           //       //       padding:  EdgeInsets.only(
//           //       //         top: w*0.025,
//           //       //         bottom: w*0.025,
//           //       //         left: w*0.025,
//           //       //         right: w*0.025,
//           //       //       ),
//           //       //       child: Column(
//           //       //         // crossAxisAlignment: CrossAxisAlignment.stretch,
//           //       //         children: [
//           //       //           Text(
//           //       //             'SEND',
//           //       //             style:
//           //       //             GoogleFonts.montserrat(
//           //       //                 fontSize: w*0.1,
//           //       //                 fontWeight: FontWeight.bold,
//           //       //                 color: Colors.white
//           //       //             ),
//           //       //
//           //       //           ),
//           //       //         ],
//           //       //       ),
//           //       //     ),
//           //       //   ),
//           //       // ),
//           //       // SizedBox(width: w*0.05,),
//           //       Expanded(
//           //         child: Container(
//           //           decoration: BoxDecoration(
//           //               color: Colors.black.withOpacity(0.3),
//           //               borderRadius: BorderRadius.circular(20)
//           //           ),
//           //           child: Padding(
//           //             padding:  EdgeInsets.only(
//           //               top: w*0.025,
//           //               bottom: w*0.025,
//           //               left: w*0.025,
//           //               right: w*0.025,
//           //             ),
//           //             child: Column(
//           //               // crossAxisAlignment: CrossAxisAlignment.stretch,
//           //               children: [
//           //                 Text(
//           //                   '${widget.bookData.bookName}',
//           //                   style:
//           //                   GoogleFonts.montserrat(
//           //                       fontSize: w*0.1,
//           //                       fontWeight: FontWeight.bold,
//           //                       color: Colors.white
//           //                   ),
//           //
//           //                 ),
//           //               ],
//           //             ),
//           //           ),
//           //         ),
//           //       ),
//           //     ],
//           //   ),
//           // ),
//           Padding(
//             padding:  EdgeInsets.fromLTRB(w*0.05,0,w*0.05,w*0.05),
//             child: Row(
//               children: [
//                 Expanded(
//                   child: Container(
//                     decoration: BoxDecoration(
//                         color: Colors.black.withOpacity(0.3),
//                         borderRadius: BorderRadius.circular(20)
//                     ),
//                     child: Padding(
//                       padding:  EdgeInsets.only(
//                         top: w*0.025,
//                         bottom: w*0.025,
//                         left: w*0.025,
//                         right: w*0.025,
//                       ),
//                       child: Column(
//                         crossAxisAlignment: CrossAxisAlignment.stretch,
//                         children: [
//                           Text(
//                             '${widget.bookData.creditLimit?.toStringAsFixed(1)}',
//                             style:
//                             GoogleFonts.montserrat(
//                                 fontSize: w*0.06,
//                                 fontWeight: FontWeight.bold,
//                                 color: Colors.white
//                             ),
//
//                           ),
//                           SizedBox(height: w*0.015,),
//                           Text(
//                             'CREDIT LIMIT',
//                             style:
//                             GoogleFonts.montserrat(
//                                 fontSize: 12,
//
//                                 color: Colors.white
//                             ),
//
//                           ),
//                         ],
//                       ),
//                     ),
//                   ),
//                 ),
//                 SizedBox(width: w*0.05,),
//                 Expanded(
//                   child: Container(
//                     decoration: BoxDecoration(
//                         color: Colors.black.withOpacity(0.3),
//                         borderRadius: BorderRadius.circular(20)
//                     ),
//                     child: Padding(
//                       padding:  EdgeInsets.only(
//                         top: w*0.025,
//                         bottom: w*0.025,
//                         left: w*0.025,
//                         right: w*0.025,
//                       ),
//                       child: Column(
//                         crossAxisAlignment: CrossAxisAlignment.stretch,
//                         children: [
//                           Text(
//                             '${widget.bookData.credit?.toStringAsFixed(2)}',
//                             style:
//                             GoogleFonts.montserrat(
//                                 fontSize: w*0.06,
//                                 fontWeight: FontWeight.bold,
//                                 color: Colors.white
//                             ),
//
//                           ),
//                           SizedBox(height: w*0.015,),
//                           Text(
//                             'CREDIT',
//                             style:
//                             GoogleFonts.montserrat(
//                                 fontSize: 12,
//
//                                 color: Colors.white
//                             ),
//
//                           ),
//                         ],
//                       ),
//                     ),
//                   ),
//                 ),
//               ],
//             ),
//           ),
//
//           widget.bookData.members!.isEmpty
//               ? Center(
//             child: Container(
//               child: Text('No members Found',style: GoogleFonts.poppins(color: primarycolor2),),
//             ),
//           )
//               : ListView.builder(
//             shrinkWrap: true,
//             scrollDirection: Axis.vertical,
//             physics: BouncingScrollPhysics(),
//             itemCount: widget.bookData.members!.length,
//
//             itemBuilder: (context, index) {
//               var member=widget.bookData.members![index];
//               return Padding(
//                 padding: const EdgeInsets.only(left: 10, right: 10,top: 5),
//                 child: InkWell(
//                   onTap: (){
//
//                     Navigator.push(context, MaterialPageRoute(builder: (context)=>SalesTransactionPage(
//                         email:member
//                     ))).then((value){
//
//                       setState(() {
//
//                       });
//                     });
//                   },
//                   child: Container(
//                     // padding: EdgeInsets.only(left: 10, right: 10),
//
//                     width: width * 0.89,
//                     decoration: BoxDecoration(
//                       borderRadius: BorderRadius.circular(9),
//                       color: Colors.white,
//                       boxShadow: const [
//                         BoxShadow(
//                           color: Color.fromRGBO(0, 0, 0, 0.1), // shadow color
//                           blurRadius: 15, // shadow radius
//                           offset: Offset(5, 10), // shadow offset
//                           spreadRadius: 0.4, // The amount the box should be inflated prior to applying the blur
//                           blurStyle: BlurStyle.normal, // set blur style
//                         ),
//                       ],
//                     ),
//                     child: Padding(
//                       padding: const EdgeInsets.all(5.0),
//                       child: Row(
//                         mainAxisAlignment: MainAxisAlignment.spaceBetween,
//                         // crossAxisAlignment: CrossAxisAlignment.center,
//                         children: [
//                           SizedBox(width: width*0.02,),
//
//                           // Container(
//                           //     height:40,
//                           //     width:40,
//                           //     child: userMap[member.toString()]==null?Container():
//                           //     CachedNetworkImage(imageUrl:userMap[member.toString()]['userImage'])),
//                           Column(
//                             crossAxisAlignment: CrossAxisAlignment.center,
//                             children: [
//                               SizedBox(
//                                 height: 10,
//                               ),
//                               Row(
//                                 mainAxisAlignment: MainAxisAlignment.spaceEvenly,
//                                 crossAxisAlignment: CrossAxisAlignment.center,
//                                 children: [
//                                   Container(
//                                     width: width*0.8,
//                                     child:Text(
//                                       userMap[member.toString()]==null
//                                           ?member.toString():userMap[member.toString()]['userName'],textAlign: TextAlign.center,
//                                       style: GoogleFonts.montserrat(
//                                           fontSize: 21,
//                                           fontWeight: FontWeight.w800,
//                                           color: Colors.black
//                                       ),
//                                     ),
//
//
//                                   )
//                                 ],
//                               ),
//                               SizedBox(
//                                 height: 5,
//                               )
//
//                             ],
//                           ),
//                           SizedBox(height: 10,)
//
//                         ],
//                       ),
//                     ),
//                   ),
//                 ),
//               );
//             },
//           ),
//           SizedBox(height: w*0.05,),
//           statement.length ==0?Container(
//
//             child: Center(
//               child: Text('No transaction found',
//                 style:  GoogleFonts.montserrat(color:primarycolor1,fontWeight: FontWeight.w700,fontSize: 14),),
//             ),
//           ): Expanded(
//
//             child: Container(
//               decoration: BoxDecoration(
//                   color: Colors.white,
//                 borderRadius: BorderRadius.only(
//                   topLeft: Radius.circular(35),
//                   topRight: Radius.circular(35),
//                 )
//               ),
//               child: ListView.builder(
//                 padding: EdgeInsets.all(w*0.05),
//                   scrollDirection: Axis.vertical,
//                   physics: BouncingScrollPhysics(),
//                   itemCount:statement.length ,
//                   itemBuilder: (context,index){
//                     return  Padding(
//                       padding:  EdgeInsets.only(bottom: w*0.03),
//                       child: Container(
//                         decoration: BoxDecoration(
//                           borderRadius: BorderRadius.circular(10),
//                           // color: Color(0xffFBFBFB),
//                         ),
//                         child: Row(
//
//                           children: [
//                             Container(
//                               height: w*0.1,
//                               width: w*0.1,
//                               decoration: BoxDecoration(
//                                   color:statement[index].toJson().containsKey('purchaseId')?Colors.redAccent.withOpacity(0.15):Colors.greenAccent.withOpacity(0.15),
//
//                                 shape: BoxShape.circle
//                               ),
//                               child: Center(
//                                 child:statement[index].toJson().containsKey('purchaseId')? Icon(
//                                   Icons.arrow_drop_down,
//                                   size: w*0.075,
//                                   color: Colors.redAccent,
//                                 ):Icon(
//                                     Icons.arrow_drop_up,
//                                   size: w*0.075,
//                                   color: Colors.greenAccent,
//                                 ),
//                               ),
//                             ),
//                             SizedBox(width: w*0.025,),
//                             Expanded(
//                               child: Column(
//                                 crossAxisAlignment: CrossAxisAlignment.stretch,
//                                 children: [
//                                   SizedBox(height: 10,),
//                                   Container(
//                                     width: width*0.55,
//                                     child: Text(statement[index].customerName,
//                                       style:  GoogleFonts.montserrat(color:primarycolor1,fontWeight: FontWeight.w700,fontSize: 14),) ,
//
//                                   ),
//
//
//                                   // Text(statement[index].shopName??"",
//                                   //   style: TextStyle(color:Color(0xff5E5F5F),fontWeight: FontWeight.w700,fontSize: 14),),
//                                   SizedBox(height: 5,),
//
//                                   // Text(statement[index].bookName??"",
//                                   //   style: TextStyle(color:Color(0xff5E5F5F),fontWeight: FontWeight.w700,fontSize: 14),),
//                                   SizedBox(height: 5,),
//
//                                   Text(DateFormat('dd MMM yyyy hh:mm aa').format(statement[index].toJson().containsKey('date')?statement[index].date:statement[index].date),
//                                     style:  GoogleFonts.montserrat(color:Colors.black,fontWeight: FontWeight.w600,fontSize: 11),),
//                                   SizedBox(height: 5,),
//                                   statement[index].toJson().containsKey('balance')? Text("Balance : ${statement[index].balance.toStringAsFixed(2)} ",
//                                     style:  GoogleFonts.montserrat(color:Colors.orange.shade700,fontWeight: FontWeight.w800,fontSize: 14),):Container(),
//                                   SizedBox(height: 5,),
//
//                                   statement[index].noBook==true?
//                                   Text('No Book', style: GoogleFonts.montserrat(color:Colors.red,fontWeight: FontWeight.w800,fontSize: 14),):Container()
//
//
//                                 ],
//                               ),
//                             ),
//                             SizedBox(width: w*0.025,),
//                             Column(
//                               mainAxisAlignment: MainAxisAlignment.center,
//                               children: [
//                                 // statement[index].noBook==false?
//                                 Row(
//                                   children: [
//                                     Text("${statement[index].currencyShort.toString()}", style: GoogleFonts.montserrat(color:statement[index].toJson().containsKey('purchaseId') ?Colors.black:Colors.green,fontWeight: FontWeight.w600,fontSize: 15),),
//                                     SizedBox(width: 3,),
//                                     Text("${statement[index].amount.toString()}", style: GoogleFonts.montserrat(color:statement[index].toJson().containsKey('purchaseId')?Colors.black:Colors.green,fontWeight: FontWeight.w600,fontSize: 15),),
//                                   ],
//                                 ),
//                                 //     :Row(
//                                 //   children: [
//                                 //     Text("${statement[index].currencyShort.toString()}", style: GoogleFonts.montserrat(color:statement[index].toJson().containsKey('purchaseId') ?Colors.red:Colors.red,fontWeight: FontWeight.w600,fontSize: 15),),
//                                 //     SizedBox(width: 3,),
//                                 //     Text("${statement[index].amount.toString()}", style: GoogleFonts.montserrat(color:statement[index].toJson().containsKey('purchaseId')?Colors.red:Colors.red,fontWeight: FontWeight.w600,fontSize: 15),),
//                                 //   ],
//                                 // ),
//                                 SizedBox(height: 5),
//                                 InkWell(
//                                     onTap: () {
//                                       showDialog(
//                                           context: context,
//                                           builder:
//                                               (BuildContext context) {
//                                             return EditAmountPage(
//                                               id:statement[index].type==0? statement[index].purchaseId.toString():statement[index].transactionId,
//                                               type: statement[index].type,
//                                               data: statement[index],
//                                               nobook:statement[index].noBook,
//                                               userId:statement[index].customerId,
//                                               bookId:statement[index].bookId,
//                                               amount:statement[index].amount,
//                                               set: set,
//                                             );
//                                           }).then((value) {
//
//                                         getTransaction();
//                                         setState(() {
//
//                                         });
//
//                                       }  );
//                                     },
//                                     child: Icon(
//                                       Icons.edit,
//                                       color: Colors.grey,
//                                     ))
//
//                               ],
//                             ),
//
//                             // SizedBox(width: 5,),
//
//
//                           ],
//                         ),
//
//                       ),
//                     );
//                   }),
//             ),
//           )
//         ],
//       ),
//     );
//   }
//
// }
// class EditAmountPage extends StatefulWidget {
//   final String id;
//   final String userId;
//   final String bookId;
//   final int type;
//   final double amount;
//   final bool nobook;
//   final Function set;
//   var data;
//   EditAmountPage({Key? key, required this.id, required this.type, required this.data, required this.nobook, required this.userId, required this.bookId, required this.amount, required this.set, }) : super(key: key);
//
//   @override
//   State<EditAmountPage> createState() => _EditAmountPageState();
// }
//
// class _EditAmountPageState extends State<EditAmountPage> {
//
//   TextEditingController editAmount = TextEditingController();
//   TextEditingController editDescription = TextEditingController();
//   bool _value = false;
//
//   @override
//   void initState() {
//     print(widget.amount);
//     print('widget.amount');
//
//     editAmount = TextEditingController(text:widget.data.amount.toString()??'');    // TODO: implement initState
//     _value = widget.nobook;    // TODO: implement initState
//     super.initState();
//   }
//   @override
//   Widget build(BuildContext context) {
//     return Container(
//       height: 200,
//       child: AlertDialog(
//         // title: Text(
//         //   'Edit amount ',
//         //   style: GoogleFonts.outfit(
//         //     fontSize: 15,
//         //   ),
//         // ),
//         // insetPadding: EdgeInsets.only(bottom: scrWidth*0.6,top:  scrWidth*0.6,right:  scrWidth*0.09,left:  scrWidth*0.09),
//         // shape: RoundedRectangleBorder(
//         //     borderRadius: BorderRadius.all(Radius.circular(45.0))),
//         content: Container(
//           width: width * 1,
//           height: width * 0.7,
//           decoration: BoxDecoration(
//               borderRadius:
//               BorderRadius.circular(15)),
//           child: Column(
//             mainAxisAlignment:
//             MainAxisAlignment.spaceEvenly,
//             children: [
//               Text(
//                 'Edit amount ',
//                 style: GoogleFonts.outfit(
//                   fontSize: 15,
//                 ),
//               ),
//               Container(
//                 width: width * 1,
//                 // height: width * 0.12,
//                 decoration: BoxDecoration(
//                     borderRadius:
//                     BorderRadius.circular(
//                         15),
//                     border: Border.all(
//                         color: primarycolor1)),
//                 child: TextFormField(
//                   controller: editAmount,
//                   cursorColor: Colors.black,
//                   style: GoogleFonts.outfit(
//                     color: primarycolor1,
//                     fontWeight: FontWeight.w600,
//                     fontSize: 15,
//                   ),
//                   keyboardType:
//                   TextInputType.text,
//                   decoration: InputDecoration(
//                     hintText:
//                     'Enter amount',
//                     hintStyle:
//                     GoogleFonts.outfit(
//                       color:
//                       Colors.grey.shade100,
//
//                       fontWeight:
//                       FontWeight.w500,
//                       fontSize: 15,
//                     ),
//                     fillColor:
//                     Colors.grey.shade100,
//                     filled: true,
//                     disabledBorder:
//                     InputBorder.none,
//                     enabledBorder:
//                     OutlineInputBorder(
//                         borderSide:
//                         BorderSide(
//                             color:
//                             primarycolor1,
//                             width: 1.0),
//                         borderRadius:
//                         BorderRadius
//                             .circular(
//                             15)),
//                     errorBorder:
//                     InputBorder.none,
//                     border: InputBorder.none,
//
//                     focusedBorder:
//                     UnderlineInputBorder(
//                       borderRadius:
//                       BorderRadius.circular(
//                           15),
//                       borderSide: BorderSide(
//                         color: primarycolor1,
//                         width: 2,
//                       ),
//                     ),
//
//                     //
//                     // border: OutlineInputBorder(),
//                     // focusedBorder: OutlineInputBorder(
//                     //     borderSide: BorderSide(color: Color(0xff034a82),width: 2)
//                     // ),
//                   ),
//                 ),
//               ),
//               SizedBox(height: 5,),
//               Text(
//                 'No book ',
//                 style: GoogleFonts.outfit(
//                   fontSize: 15,
//                 ),
//               ),
//               Center(
//                 child: Switch(
//                   value: _value,
//                   onChanged: (bool newValue) {
//                     setState(() {
//                       _value = newValue;
//                     });
//                     print(_value);
//                     print(_value);
//                   },
//                 ),
//               ),
//               // Text(
//               //   'Edit Description ',
//               //   style: GoogleFonts.outfit(
//               //     fontSize: 15,
//               //   ),
//               // ),
//               // TextFormField(
//               //   maxLines: 2,
//               //   controller: editDescription,
//               //   cursorColor: Colors.black,
//               //   style: GoogleFonts.outfit(
//               //     color: primarycolor1,
//               //     fontWeight: FontWeight.w600,
//               //     fontSize: 15,
//               //   ),
//               //   keyboardType:
//               //   TextInputType.text,
//               //   decoration: InputDecoration(
//               //     hintText:
//               //     'Enter description',
//               //     hintStyle:
//               //     GoogleFonts.outfit(
//               //       color:
//               //       Colors.grey.shade100,
//               //       fontWeight:
//               //       FontWeight.w500,
//               //       fontSize: 15,
//               //     ),
//               //     fillColor:
//               //     Colors.grey.shade100,
//               //     filled: true,
//               //     disabledBorder:
//               //     InputBorder.none,
//               //     enabledBorder:
//               //     OutlineInputBorder(
//               //         borderSide:
//               //         BorderSide(
//               //             color:
//               //             primarycolor1,
//               //             width: 1.0),
//               //         borderRadius:
//               //         BorderRadius
//               //             .circular(
//               //             15)),
//               //     errorBorder:
//               //     InputBorder.none,
//               //     border: InputBorder.none,
//               //
//               //     focusedBorder:
//               //     UnderlineInputBorder(
//               //       borderRadius:
//               //       BorderRadius.circular(
//               //           15),
//               //       borderSide: BorderSide(
//               //         color: primarycolor1,
//               //         width: 2,
//               //       ),
//               //     ),
//               //
//               //     //
//               //     // border: OutlineInputBorder(),
//               //     // focusedBorder: OutlineInputBorder(
//               //     //     borderSide: BorderSide(color: Color(0xff034a82),width: 2)
//               //     // ),
//               //   ),
//               // ),
//               InkWell(
//                 onTap: () async {
//
//                   if(editAmount.text!='' &&_value!=null){
//
//                     if(widget.type==0){
//
//                       FirebaseFirestore.instance.collection('users').doc(widget.userId)
//                           .collection('purchase').doc(widget.id).update({
//                         'amount': double.tryParse(editAmount.text.toString())??0,
//                         'noBook':_value,
//
//                       }).then((value) {
//                         FirebaseFirestore.instance.collection('shops')
//                             .doc(currentshopId)
//                             .collection('book').doc(widget.bookId).update({
//
//                           'credit':FieldValue.increment((double.parse((editAmount.text.toString()))-widget.amount)),
//                         });
//                       }).then((value) {
//                         FirebaseFirestore.instance.collection('shops').doc(currentshopId).update(
//                             {
//                               'totalCredit':FieldValue.increment((double.parse((editAmount.text.toString()))-widget.amount)),
//
//
//
//                             });
//                       });
//
//                       setState(() {});
//
//
//                     }else{
//                       print((double.parse((editAmount.text.toString()))-widget.amount));
//                       print('(double.parse((editAmount.text.toString()))-widget.amount)');
//
//                       FirebaseFirestore.instance.collection('users').doc(widget.userId)
//                           .collection('transactions').doc(widget.id).update({
//                         'amount': double.tryParse(editAmount.text.toString())??0,
//                         'noBook':_value,
//
//                       }).then((value) {
//                         FirebaseFirestore.instance.collection('shops')
//                             .doc(currentshopId)
//                             .collection('book').doc(widget.bookId).update({
//
//                           'credit':FieldValue.increment(widget.amount-(double.parse((editAmount.text.toString())))),
//                         });
//                       }).then((value) {
//                         FirebaseFirestore.instance.collection('shops').doc(currentshopId).update(
//                             {
//                               'totalCredit':FieldValue.increment(widget.amount-(double.parse((editAmount.text.toString())))),
//                             });
//                       });
//                       setState(() {});
//
//                     }
//                     // amount  = double.tryParse(editAmount.text.toString())??0;
//
//                     setState(() {});
//                     Navigator.pop(context);
//                     widget.set();
//
//                   }else{
//                     showUploadMessage1(context, 'Please enter amount', style: GoogleFonts.montserrat());
//                   }
//
//
//                 },
//                 child: Container(
//                   width: width * 0.3,
//                   height: width * 0.12,
//                   decoration: BoxDecoration(
//                     borderRadius:
//                     BorderRadius.circular(
//                         15),
//                     color: primarycolor1,
//                   ),
//                   child: Center(
//                     child: Text(
//                       " Ok",
//                       style: GoogleFonts.outfit(
//                           fontSize:
//                           width * 0.05,
//                           color: Colors.white,
//                           fontWeight:
//                           FontWeight.w600),
//                     ),
//                   ),
//                 ),
//               ),
//
//             ],
//           ),
//         ),
//         // actions: [
//         //   TextButton(onPressed: (){
//         //     Navigator.pop(context);
//         //     merchantName=merchant!.text;
//         //     setState(() {
//         //
//         //     });
//         //   },
//         //       child: const Text('Ok')),
//         // ],
//       ),
//     );
//   }
//
// // Widget customWidget({ String? name}){
// //   return ElevatedButton(onPressed: (){
// //
// //   }, child: Text(name??''));
// // }
//
// }
