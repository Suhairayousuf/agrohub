// import 'dart:developer';
//
// import 'package:cached_network_image/cached_network_image.dart';
// import 'package:cloud_firestore/cloud_firestore.dart';
// import 'package:flutter/material.dart';
// import 'package:google_fonts/google_fonts.dart';
// import 'package:onscreen_keyboard/onscreen_keyboard.dart';
// import 'package:shop/Home/selectShop.dart';
// import 'package:shop/themes/color.dart';
//
// import 'package:virtual_keyboard_multi_language/virtual_keyboard_multi_language.dart';
//
// import '../../Home/homePage.dart';
// import '../../auth/splash.dart';
// import '../../model/purchase/purchaseModel.dart';
//
// class Purchase extends StatefulWidget {
//   final String iqamaNumber;
//   const Purchase({Key? key, required this .iqamaNumber}) : super(key: key);
//
//   @override
//   State<Purchase> createState() => _PurchaseState();
// }
//
// class _PurchaseState extends State<Purchase> {
//   String? text = '';
//   String customerName='';
//   String customerPhone='';
//   String customerEmail='';
//   String customerImage='';
//   String customerId='';
//   String userBookName='';
//   String  userBookId='';
//   bool noUser=false;
//   bool noBook=false;
//   Timestamp ?today;
//   getUserDetailes(){
//     print( widget.iqamaNumber);
//     print('oooooooooooooooooooooooooooooooooooooooooooooooooooooooooooo');
//     log('oooooooooooooooooooooooooooooooooooooooooooooooooooooooooooo');
//     FirebaseFirestore.instance.collection('users').
//     where('icamaNumber',isEqualTo: widget.iqamaNumber).
//     snapshots().listen((event) {
//       if(event.docs.isNotEmpty) {
//         DocumentSnapshot doc =event.docs[0];
//         Map data =event.docs[0].data();
//
//         print(data);
//           customerName=doc.get('userName');
//           customerPhone=doc.get('phone');
//           customerEmail=doc.get('userEmail');
//           customerImage=doc.get('userImage');
//           customerId=doc.get('userId');
//           // customerReward=doc.get('customerReward');
//
//
//         // }
//
//       }
//       else{
//         noUser=true;
//       }
//       if(mounted){
//         setState(() {
//
//         });
//       }
//
//
//
//     });
//   }
//   getBook(){
//     FirebaseFirestore.instance.collection('shops')
//         .doc(currentshopId)
//         .collection('book').where('members',arrayContains: widget.iqamaNumber).get().then((value) {
//       if(value.docs.isNotEmpty) {
//         for(DocumentSnapshot doc in value.docs){
//           userBookName=doc.get('bookName');
//           userBookId=doc.get('bookId');
//
//           // customerReward=doc.get('customerReward');
//         }
//
//         // }
//
//       }else{
//         noBook=true;
//       }
//       if(mounted){
//         setState(() {
//
//         });
//       }
//
//
//
//     });
//
//   }
//   void initState() {
//     getUserDetailes();
//     getBook();
//     today=Timestamp.now();
//
//
//     // TODO: implement initState
//     super.initState();
//   }
//   @override
//   Widget build(BuildContext context) {
//
//     return Scaffold(
//       appBar: AppBar(
//         leading: IconButton(
//           onPressed: () {
//             Navigator.pop(context);
//           },
//           icon: Icon(Icons.arrow_back_ios),
//         ),
//         elevation: 0,
//         backgroundColor: primarycolor1,
//       ),
//       body: Padding(
//     padding:  EdgeInsets.all(width*0.05),
//     child: noUser==true?Container(
//     height: height,
//     child: Center(
//     child: Text('Unknown Customer',style: GoogleFonts.montserrat(
//     fontSize: 20,
//     color: primarycolor1
//     ),),
//     )
//     ):SingleChildScrollView(
//         child: Column(
//           children: [
//             Card(
//               shadowColor: Colors.black,
//               child: Container(
//                 width: width,
//                 decoration:BoxDecoration(
//                     boxShadow: [
//                       BoxShadow(
//                         color:primarycolor1,
//                         offset: const Offset(
//                           5.0,
//                           5.0,
//                         ),
//                         blurRadius: 5.0,
//                         spreadRadius: 2.0,
//                       ), //BoxShadow
//                       BoxShadow(
//                         color: Colors.white,
//                         offset: const Offset(0.0, 0.0),
//                         blurRadius: 0.0,
//                         spreadRadius: 0.0,
//                       ), //BoxShadow
//                     ],
//                     // border: Border.all(
//                     //     width: 0.5,
//                     // ),
//                     borderRadius: BorderRadius.circular(5)
//                 ),
//                 child: Column(
//                   mainAxisAlignment: MainAxisAlignment.start,
//                   crossAxisAlignment: CrossAxisAlignment.start,
//                   children: [
//                     SizedBox(height: 20,),
//                     Container( width:width,
//                         child: Center(child: Text(
//                           'Customer Profile Info',
//                           style: GoogleFonts.montserrat(
//                               fontSize: 22
//                           ),))),
//                     Padding(
//                       padding: const EdgeInsets.only(left: 18.0,right: 18),
//                       child: Divider(thickness: 1),
//                     ),
//                     SizedBox(height: 20,),
//                     Row(
//                       mainAxisAlignment: MainAxisAlignment.spaceAround,
//                       children: [
//                         Padding(
//                           padding:  EdgeInsets.only(bottom: width*0.08),
//                           child: Container  (
//                             height: width*0.25,
//                             width:width*0.2,
//
//                             child: ClipRRect(
//                                 borderRadius: BorderRadius.circular(8),
//                                 child: customerImage!=""?
//                                 CachedNetworkImage(imageUrl:customerImage ,fit: BoxFit.cover,):Container()
//
//                             ),
//                           ),
//                         ),
//                         Column(
//                           mainAxisAlignment: MainAxisAlignment.start,
//                           crossAxisAlignment: CrossAxisAlignment.start,
//                           children: [
//                             Container(
//                               width: width*0.5,
//                               child: Text(
//                                 'Name : ${customerName.toString()}',
//                                 style:
//                                 GoogleFonts.montserrat(
//                                     fontSize: 14,
//                                     color: primarycolor1
//                                 ),
//
//                               ),
//                             ),
//                             SizedBox(height: 10,),
//                             Text(
//                               'Mobile: ${ customerPhone.toString()}',
//                               style:
//                               GoogleFonts.montserrat(
//                                   fontSize: 14,
//                                   color: primarycolor1
//                               ),
//
//                             ),
//                             SizedBox(height: 10,),
//                             Container(
//                               width: width*0.5,
//
//                               child: Text(
//                                 customerEmail.toString(),
//                                 style:
//                                 GoogleFonts.montserrat(
//                                     fontSize: 14,
//                                     color: primarycolor1
//                                 ),
//
//                               ),
//
//                             ),
//                             SizedBox(height: 10,),
//                             Container(
//                               width: width*0.5,
//                               child: Text(
//                                 'BookName : ${userBookName.toString()}',
//                                 style:
//                                 GoogleFonts.montserrat(
//                                     fontSize: 14,
//                                     color: primarycolor1
//                                 ),
//
//                               ),
//                             ),
//                             SizedBox(height: 10,),
//
//                           ],
//                         )
//                       ],
//                     ),
//
//
//
//
//                   ],
//
//                 ),
//               ),
//             ),
//             SizedBox(
//               height: width * 0.05,
//             ),
//             Center(
//               child: Container(
//                 height: width * 0.17,
//                 width: width * 0.9,
//                 decoration: BoxDecoration(
//                   border: Border.all(color: primarycolor1),
//                   borderRadius: BorderRadius.all(
//                     Radius.circular(20),
//                   ),
//                 ),
//                 child: Center(
//                   child: Text(text.toString(),
//                       style: GoogleFonts.montserrat(fontSize: width * 0.05)),
//                 ),
//               ),
//             ),
//             SizedBox(
//               height: width * 0.05,
//             ),
//             InkWell(
//               onTap: (){
//                 if(text!='' && userBookName!=''&&(today!.compareTo(currentshopPlanEnd!)!=0)){
//                   showDialog(
//                     context: context,
//                     builder: (ctx) => AlertDialog(
//                       title:  Text("Add ",style:GoogleFonts.montserrat(
//                           fontSize: 18,
//                           fontWeight:FontWeight.w600,
//                           color: primarycolor1),),
//                       content:  Text("Are you Sure ?",style:GoogleFonts.montserrat(
//                           fontSize: 16,
//                           fontWeight:FontWeight.w600,
//                           color: primarycolor1),),
//                       actions: <Widget>[
//                         Row(
//                           mainAxisAlignment: MainAxisAlignment.spaceAround,
//                           children: [
//                             InkWell(
//                                 onTap: (){
//                                   Navigator.pop(ctx);
//                                   // Navigator.pop(context);
//                                 },
//                                 child: Container(
//                                   height: 40,
//                                   width:75,
//                                   decoration: BoxDecoration(
//                                     borderRadius: BorderRadius.circular(10),
//                                     border: Border.all(width: 2,color: primarycolor1),
//
//                                   ),
//                                   child: Center(
//                                     child: Text('No',style:GoogleFonts.montserrat(
//                                         fontSize: 14,
//                                         fontWeight:FontWeight.w600,
//                                         color: primarycolor1),),
//                                   ),
//                                 )),
//                             InkWell(
//                                 onTap: () async {
//
//                                   final purchaseData = PurchaseModel(
//                                       amount:double.tryParse(text!.toString()),
//                                       customerId:customerId,
//                                       customerName:customerName,
//                                       customerPhone:customerPhone,
//                                       shopId:currentshopId,
//                                       shopName:currentshopName,
//                                       image:currentShopImage,
//                                       status:0,
//                                       verification:false,
//                                     date:DateTime.now(),
//                                        bookId:userBookId,
//                                        bookName: userBookName,
//                                     currencyShort: currencyCode,
//                                   );
//
//                                   await createPurchase(purchaseData);
//                                   Navigator.pop(ctx);
//                                   Navigator.pop(context);
//
//                                   showUploadMessage(context, 'amount added succesfully', style:  GoogleFonts.montserrat());
//                                   // getShop();
//                                     text='';
//                                   // FirebaseFirestore.instance.collection('users')
//                                   //     .doc(customerId).collection('purchase').add(
//                                   //     {
//                                   //       'amount':double.tryParse(amount!.text.toString()),
//                                   //       'customerId':customerId,
//                                   //       'customerName':customerName,
//                                   //       'customerPhone':customerPhone,
//                                   //       'rewardPoints':0,
//                                   //       'adminRewardPoints':0,
//                                   //       'shopId':currentshopId,
//                                   //       'shopName':currentshopName,
//                                   //       'image':'',
//                                   //       'status':0,
//                                   //       'verification':false,
//                                   //       'purchaseDate':FieldValue.serverTimestamp()
//                                   //
//                                   //     }).then((value) {
//                                   //       value.update({
//                                   //       'purchaseId':value.id,
//                                   //       });
//                                   //
//                                   // });
//
//
//
//
//                                   // await  Navigator.pushAndRemoveUntil(context, MaterialPageRoute(builder: (context)=>
//                                   // const LoginSelectPage()), (route) => false);
//                                 },
//                                 child: Container(
//                                   height: 40,
//                                   width:75,
//                                   decoration: BoxDecoration(
//                                     borderRadius: BorderRadius.circular(10),
//                                     border: Border.all(width: 2,color: primarycolor1),
//
//                                   ),
//                                   child: Center(
//                                     child: Text('Yes',style:GoogleFonts.montserrat(
//                                         fontSize: 14,
//                                         fontWeight:FontWeight.w600,
//                                         color: primarycolor1),),
//                                   ),
//                                 )),
//                           ],
//                         ),
//
//                       ],),
//                   );
//                 }
//                 else{
//                  text==''? showUploadMessage(context, 'Enter  amount',style: GoogleFonts.montserrat()):
//                   showUploadMessage(context, 'Validity of plan is expired',style: GoogleFonts.montserrat());
//                 }
//               },
//               child: Container(
//                 width: width * 0.8,
//                 height: width * 0.15,
//                 decoration: BoxDecoration(
//                     gradient:
//                         LinearGradient(colors: [primarycolor1, primarycolor2]),
//                     borderRadius: BorderRadius.all(Radius.circular(20))),
//                 child: Center(
//                   child: Text(
//                     'Purchase',
//                     style:
//                     GoogleFonts.montserrat(color: Colors.white, fontSize: width * 0.05),
//                   ),
//                 ),
//               ),
//             ),
//             SizedBox(
//               height: width * 0.05,
//             ),
//             Container(
//               // Keyboard is transparent
//               color: primarycolor1,
//               child: VirtualKeyboard(
//                   textColor: Colors.white,
//                   type: VirtualKeyboardType.Numeric,
//                   onKeyPress: _onKeyPress
//                   //     (key) {
//                   //   print(key.text);
//                   //   up(amount.contains('.') && key.text == "."
//                   //       ? ""
//                   //       :key.text==''?'':
//                   //   key.text == "."
//                   //           ? "."
//                   //           : int.tryParse(key.text.toString() ?? '0'));
//                   // }
//                   ),
//             )
//           ],
//         ),
//       ),
//     )
//     );
//   }
//   createPurchase(PurchaseModel purchaseData,) async {
//     print(customerId);
//     print('lllllllllllllllllllllllllllllllllllllllllllllll');
//     String? id;
//     FirebaseFirestore.instance.collection('users')
//         .doc(purchaseData.customerId).collection('purchase').add(purchaseData.toJson())
//         .then((value) {
//
//       // geoLocation(value.id);
//
//       value.update({
//
//         'purchaseId': value.id
//
//
//       }).then((value) {
//         FirebaseFirestore.instance.collection('shops')
//             .doc(currentshopId)
//             .collection('book').doc(userBookId).update({
//           'update':DateTime.now(),
//             'credit':FieldValue.increment(purchaseData.amount!),
//
//         });
//
//       });
//       // id=value.id;
//     });
//     //     .then((value) async {
//     //     FirebaseFirestore.instance.collection('users').doc(customerId).update(
//     //         {
//     //        'rewardPoints':FieldValue.increment(custRewardAmount),
//     //         });
//     //     FirebaseFirestore.instance.collection('shops').doc(currentshopId).update(
//     //         {
//     //           'walletAmount':FieldValue.increment((custRewardAmount+adminRewardAmount)*-1),
//     //
//     //         });
//     // });
//   }
//   _onKeyPress(VirtualKeyboardKey key) {
//     if (!text!.contains('.')) {
//       text = "$text${key.text}";
//     } else if (text!.contains('.') && key.text != '.') {
//       text = "$text${key.text}";
//     }
//     switch (key.action) {
//       case VirtualKeyboardKeyAction.Backspace:
//         if (text!.length == 0) return;
//         text = text!.substring(0, text!.length - 1);
//         break;
//       default:
//     }
//
// // Update the screen
//     setState(() {});
//   }
// }
