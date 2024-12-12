// import 'package:cloud_firestore/cloud_firestore.dart';
// import 'package:flutter/material.dart';
// import 'package:flutter_svg/svg.dart';
// import 'package:google_fonts/google_fonts.dart';
// import 'package:intl/intl.dart';
// import 'package:shop/Home/selectShop.dart';
// import 'package:shop/model/bookModel.dart';
//
// import '../../auth/splash.dart';
// import '../../themes/color.dart';
// import '../report/BookReport.dart';
//
// class BookListPage extends StatefulWidget {
//   const BookListPage({Key? key}) : super(key: key);
//
//   @override
//   State<BookListPage> createState() => _BookListPageState();
// }
//
// class _BookListPageState extends State<BookListPage> {
//   List<BookModel> books = [];
//
//   getBooks() {
//     FirebaseFirestore.instance
//         .collection('shops')
//         .doc(currentshopId)
//         .collection('book')
//         .get()
//         .then((value) {
//       books = [];
//
//       for (var abc in value.docs) {
//         books.add(BookModel.fromJson(abc.data()!));
//         // books.sort((a, b) => b.bookName!.compareTo(a!.bookName!));
//         books.sort((a, b) {
//           // Extracting the letter part from the names
//           String aLetterPart = a.bookName!.replaceAll(RegExp(r'[0-9]'), '');
//           String bLetterPart = b.bookName!.replaceAll(RegExp(r'[0-9]'), '');
//
//           // Extracting the numeric part from the names
//           int aNumericPart = int.parse(a.bookName!.replaceAll(RegExp(r'[A-Za-z]'), ''));
//           int bNumericPart = int.parse(b.bookName!.replaceAll(RegExp(r'[A-Za-z]'), ''));
//
//           // Comparing the letter parts
//           int letterComparison = aLetterPart.compareTo(bLetterPart);
//           if (letterComparison != 0) {
//             return letterComparison;
//           }
//
//           // Comparing the numeric parts
//           return aNumericPart.compareTo(bNumericPart);
//         });
//       }
//       if (mounted) {
//         setState(() {});
//       }
//     });
//   }
//
//   AppBar(String title) {
//     return Container(
//       width: width,
//       height: width * 0.4,
//       child: Stack(
//         children: [
//           Container(
//             width: width * 1,
//             height: width * 0.4,
//             decoration: BoxDecoration(
//               image: DecorationImage(
//                   image: AssetImage("assets/appBar.png"), fit: BoxFit.cover),
//             ),
//             child: Row(
//               children: [
//                 SizedBox(
//                   width: width * 0.07,
//                 ),
//                 SizedBox(
//                   width: width * 0.65,
//                 ),
//               ],
//             ),
//           ),
//           Positioned(
//             top: width * 0.3,
//             height: width * 0.13,
//             child: Container(
//               decoration: BoxDecoration(
//                 color: bgcolor,
//                 borderRadius: BorderRadius.only(
//                     topLeft: Radius.circular(32.11),
//                     topRight: Radius.circular(32.11)),
//               ),
//               width: width,
//               height: width * 0.05,
//               child: Row(
//                 mainAxisAlignment: MainAxisAlignment.center,
//                 children: [
//                   Text(
//                     title,
//                     style: GoogleFonts.montserrat(
//                         fontSize: 20,
//                         color: primarycolor1,
//                         fontWeight: FontWeight.w600),
//                   ),
//                 ],
//               ),
//             ),
//           ),
//         ],
//       ),
//     );
//   }
//
//   @override
//   void initState() {
//     getBooks();
//     super.initState();
//   }
//
//   @override
//   Widget build(BuildContext context) {
//     return Scaffold(
//       backgroundColor: bgcolor,
//       body: Column(
//         children: [
//           AppBar("BOOK"),
//           bookList.length == 0
//               ? Center(
//                   child: Container(
//                     child: Text(
//                       'No Books Found',
//                       style: GoogleFonts.montserrat(color: primarycolor2),
//                     ),
//                   ),
//                 )
//               : Column(
//                   children: [
//                     SizedBox(
//                       height: width * 0.03,
//                     ),
//                     Container(
//                       height: height * 0.782,
//                       child: ListView.builder(
//                         shrinkWrap: true,
//                         scrollDirection: Axis.vertical,
//                         physics: BouncingScrollPhysics(),
//                         itemCount: books.length,
//                         itemBuilder: (context, index) {
//                           BookModel data = books[index];
//                           return Padding(
//                             padding: const EdgeInsets.only(
//                                 top: 20, left: 10, right: 10),
//                             child: InkWell(
//                               onTap: () {
//                                 Navigator.push(
//                                     context,
//                                     MaterialPageRoute(
//                                         builder: (context) => BookReportPage(
//                                               bookId: data.bookId,
//                                             )));
//                               },
//                               child: Container(
//                                 // padding: EdgeInsets.only(left: 10, right: 10),
//                                 height: height * 0.11,
//                                 width: width * 0.89,
//                                 decoration: BoxDecoration(
//                                   borderRadius: BorderRadius.circular(9),
//                                   color: Colors.white,
//                                   boxShadow: const [
//                                     BoxShadow(
//                                       color: Color.fromRGBO(0, 0, 0, 0.1),
//                                       // shadow color
//                                       blurRadius: 15,
//                                       // shadow radius
//                                       offset: Offset(5, 10),
//                                       // shadow offset
//                                       spreadRadius: 0.4,
//                                       // The amount the box should be inflated prior to applying the blur
//                                       blurStyle:
//                                           BlurStyle.normal, // set blur style
//                                     ),
//                                   ],
//                                 ),
//                                 child: Padding(
//                                   padding: const EdgeInsets.all(8.0),
//                                   child: Row(
//                                     mainAxisAlignment:
//                                         MainAxisAlignment.spaceBetween,
//                                     crossAxisAlignment:
//                                         CrossAxisAlignment.center,
//                                     children: [
//                                       Row(
//                                         children: [
//                                           SizedBox(
//                                             width: width * 0.03,
//                                           ),
//                                           Column(
//                                             crossAxisAlignment:
//                                                 CrossAxisAlignment.start,
//                                             children: [
//                                               SizedBox(
//                                                 height: 15,
//                                               ),
//                                               Text(
//                                                 data.bookName!,
//                                                 style: GoogleFonts.montserrat(
//                                                     fontSize: 13,
//                                                     fontWeight: FontWeight.w500,
//                                                     color: Colors.black),
//                                               ),
//                                               Row(
//                                                 children: [
//                                                   Text(
//                                                     DateFormat('dd MMM yyyy')
//                                                         .format(
//                                                             data.createdDate!),
//                                                     style:
//                                                         GoogleFonts.montserrat(
//                                                             fontSize: 10,
//                                                             fontWeight:
//                                                                 FontWeight.w400,
//                                                             color:
//                                                                 Colors.black),
//                                                   ),
//                                                   SizedBox(
//                                                     width: 10,
//                                                   ),
//                                                   Text(
//                                                     DateFormat('jms').format(
//                                                         data.createdDate!),
//                                                     style:
//                                                         GoogleFonts.montserrat(
//                                                             fontSize: 10,
//                                                             fontWeight:
//                                                                 FontWeight.w400,
//                                                             color:
//                                                                 Colors.black),
//                                                   ),
//                                                 ],
//                                               ),
//                                             ],
//                                           ),
//                                         ],
//                                       ),
//                                       Row(
//                                         crossAxisAlignment:
//                                             CrossAxisAlignment.center,
//                                         children: [
//                                           Text(
//                                             "${currencyCode ?? ''} ${data.credit ?? ''}",
//                                             style: GoogleFonts.montserrat(
//                                                 fontSize: 14,
//                                                 fontWeight: FontWeight.w700,
//                                                 color: primarycolor1),
//                                           ),
//                                           SizedBox(
//                                             width: width * 0.05,
//                                           ),
//                                           InkWell(
//                                             onTap: () {
//                                               showDialog(
//                                                 context: context,
//                                                 builder:
//                                                     (BuildContext context) {
//                                                   return SizedBox(
//                                                     width: width,
//                                                     child: AlertDialog(
//                                                       title: Row(
//                                                         mainAxisAlignment:
//                                                         MainAxisAlignment
//                                                             .center,
//                                                         children: [
//                                                           Text(
//                                                             "Are you sure",
//                                                             style: GoogleFonts.montserrat(
//                                                                 fontSize: 20,
//                                                                 color:
//                                                                 primarycolor1,
//                                                                 fontWeight:
//                                                                 FontWeight
//                                                                     .w500),
//                                                           ),
//                                                         ],
//                                                       ),
//                                                       content: Text(
//                                                           "Do You Want Delete the Book"),
//                                                       actions: [
//                                                         Row(
//                                                           mainAxisAlignment: MainAxisAlignment.end,
//                                                           children: [
//                                                             InkWell(
//                                                               onTap: () {
//                                                                 Navigator.pop(context);
//                                                               },
//                                                               child: Container(
//                                                                 width:
//                                                                 width * 0.15,
//                                                                 height:
//                                                                 width * 0.08,
//                                                                 decoration:
//                                                                 BoxDecoration(
//                                                                   color:
//                                                                   primarycolor1,
//                                                                   borderRadius:
//                                                                   BorderRadius
//                                                                       .circular(
//                                                                       4),
//                                                                 ),
//                                                                 child: Center(
//                                                                   child: Text(
//                                                                     "No",
//                                                                     style: GoogleFonts.montserrat(
//                                                                         color: Colors
//                                                                             .white,
//                                                                         fontSize:
//                                                                         width *
//                                                                             0.04,
//                                                                         fontWeight:
//                                                                         FontWeight
//                                                                             .w500),
//                                                                   ),
//                                                                 ),
//                                                               ),
//                                                             ),
//                                                             SizedBox(width: width*0.05,),
//                                                             InkWell(
//                                                               onTap: () async {
//                                                                 await FirebaseFirestore.instance
//                                                                     .collection("shops")
//                                                                     .doc(currentshopId)
//                                                                     .collection("book")
//                                                                     .doc(data.bookId)
//                                                                     .delete();
//                                                                 Navigator.pop(context);
//                                                               },
//                                                               child: Container(
//                                                                 width: width *
//                                                                     0.15,
//                                                                 height: width *
//                                                                     0.08,
//                                                                 decoration:
//                                                                 BoxDecoration(
//                                                                   color:
//                                                                   primarycolor1,
//                                                                   borderRadius:
//                                                                   BorderRadius
//                                                                       .circular(
//                                                                       4),
//                                                                 ),
//                                                                 child: Center(
//                                                                   child: Text(
//                                                                     "Yes",
//                                                                     style: GoogleFonts.montserrat(
//                                                                         color: Colors
//                                                                             .white,
//                                                                         fontSize:
//                                                                         width *
//                                                                             0.04,
//                                                                         fontWeight:
//                                                                         FontWeight.w500),
//                                                                   ),
//                                                                 ),
//                                                               ),
//                                                             ),
//                                                             SizedBox(width: width*0.03,),
//
//                                                           ],
//                                                         )
//                                                       ],
//                                                     ),
//                                                   );
//                                                 },
//                                               );
//                                             },
//                                             child: SvgPicture.asset(
//                                               "assets/icons/delete.svg",
//                                               height: 17,
//                                               width: 14,
//                                             ),
//                                           ),
//                                           SizedBox(
//                                             width: width * 0.02,
//                                           ),
//                                         ],
//                                       ),
//                                     ],
//                                   ),
//                                 ),
//                               ),
//                             ),
//                           );
//                         },
//                       ),
//                     ),
//                   ],
//                 ),
//         ],
//       ),
//     );
//   }
// }
import 'dart:async';

import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:intl/intl.dart';


import '../../../../Model/bookModel.dart';
import '../../../../core/utils/utils.dart';
import '../../../../themes/color.dart';
import '../../../Home/screen/selectShop.dart';
import 'package:flutter_svg/svg.dart';

import '../../../auth/screen/splash.dart';
import 'BookReport.dart';


class BookListPage extends StatefulWidget {
  const BookListPage({Key? key}) : super(key: key);

  @override
  State<BookListPage> createState() => _BookListPageState();
}

class _BookListPageState extends State<BookListPage> {
  List<BookModel> bookList=[];
  BookModel? bookMap;
  StreamSubscription? a;
  getBooks(){
   a= FirebaseFirestore.instance
        .collection('shops').doc(currentshopId).collection('book').
    where('delete',isEqualTo: false).snapshots().listen((value) {

      bookList=[];

      for(var abc in value.docs){
        bookList.add(BookModel.fromJson(abc.data()));

        bookList.sort((a, b) {
          // Extracting the letter part from the names
          String aLetterPart = a.bookName!.replaceAll(RegExp(r'[0-9]'), '');
          String bLetterPart = b.bookName!.replaceAll(RegExp(r'[0-9]'), '');

          // Extracting the numeric part from the names
          int aNumericPart = int.parse(a.bookName!.replaceAll(RegExp(r'[A-Za-z]'), ''));
          int bNumericPart = int.parse(b.bookName!.replaceAll(RegExp(r'[A-Za-z]'), ''));

          // Comparing the letter parts
          int letterComparison = bLetterPart.compareTo(aLetterPart);
          if (letterComparison != 0) {
            return letterComparison;
          }

          // Comparing the numeric parts
          return bNumericPart.compareTo(aNumericPart);
        });
      }
      if(mounted){
        setState(() {

        });
      }
    });
  }
  List searchList=[];
  getSearchedData(String str){
    searchList=[];
    for(var searchItem in bookList){
      if(searchItem.bookName!.toLowerCase().contains(str.toLowerCase()) )
      {
        searchList.add(searchItem);
      }
    }
    setState(() {

    });
  }

  TextEditingController search = TextEditingController();
  @override
  void initState() {
    getBooks();
    super.initState();
  }
@override
  void dispose() {
   a?.cancel();
    super.dispose();
  }
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        automaticallyImplyLeading: false,
        centerTitle: true,
        elevation: 0,
        // leading: IconButton(
        //   onPressed: () {
        //     Navigator.pop(context);
        //   },
        //   icon: Icon(Icons.arrow_back_ios),
        // ),
        title: Text('Books',style: GoogleFonts.montserrat(
            color: Colors.white
        ),),
        backgroundColor: primarycolor1,
      ),
      body:  SingleChildScrollView(
        child: Column(
            children: [
              Padding(
                padding: const EdgeInsets.only(left: 18.0,right: 10,top: 8),
                child: Container(
                  width: width * 0.9,
                  height: width * 0.1,
                  decoration: BoxDecoration(
                    border: Border.all(
                        color: primarycolor1),
                    borderRadius:
                    BorderRadius.circular(10),
                  ),
                  child: TextFormField(
                    // onFieldSubmitted: (text) async {
                    //   // if(text.substring(text.length-1,text.length)=='-'){
                    //   BookModel? data;
                    //   await FirebaseFirestore.instance.collection('shops')
                    //       .doc(currentshopId).collection('book').
                    //   where('bookName',isEqualTo: text.replaceAll('-', '')).get().then((event) {
                    //     for(var doc in event.docs){
                    //       data=BookModel.fromJson(doc.data());
                    //     }
                    //     if(mounted){
                    //       setState(() {
                    //
                    //       });
                    //     }
                    //
                    //
                    //   });
                    //   if(data!=null) {
                    //     if (text != '' && data!.block == false) {
                    //       Navigator.push(
                    //           context, MaterialPageRoute(builder: (context) =>
                    //           SingleBookDetailesPage(
                    //             bookData: data!,
                    //           )));
                    //
                    //
                    //       // showDialog(context: context,
                    //       //     builder: (buildcontext) {
                    //       //       return AlertDialog(
                    //       //         // contentPadding: EdgeInsets.all(20),
                    //       //         title: Text(
                    //       //           'Select Type', style: GoogleFonts.outfit(),),
                    //       //         content: Container(
                    //       //           width: width * 1,
                    //       //           height: width * 0.5,
                    //       //           child: Row(
                    //       //             mainAxisAlignment: MainAxisAlignment.spaceAround,
                    //       //             crossAxisAlignment: CrossAxisAlignment.center,
                    //       //             children: [
                    //       //               InkWell(
                    //       //                 onTap: (){
                    //       //                   Navigator.pop(buildcontext);
                    //       //                   // Navigator.push(context, MaterialPageRoute(builder: (context)=>Purchase(
                    //       //                   //   // iqamaNumber: emailId!.text,
                    //       //                   //    iqamaNumber: emailId!.text,
                    //       //                   // )));
                    //       //
                    //       //                 },
                    //       //                 child: Container(
                    //       //
                    //       //                   width: width*0.28,
                    //       //                   height:  width*0.15 ,
                    //       //                   decoration: BoxDecoration(
                    //       //                       color: primarycolor2,
                    //       //                     borderRadius: BorderRadius.circular(10)
                    //       //                   ),
                    //       //                   child: Center(
                    //       //                     child: Text('Purchase',style: GoogleFonts.poppins(
                    //       //                       fontSize: 15,
                    //       //                       color: Colors.white
                    //       //                     ),),
                    //       //                   ),
                    //       //                 ),
                    //       //               ),
                    //       //               SizedBox(width: 10,),
                    //       //               InkWell(
                    //       //                 onTap: (){
                    //       //                   Navigator.pop(buildcontext);
                    //       //                   Navigator.push(context, MaterialPageRoute(builder: (context)=>AddTransactionPage(
                    //       //                     iqamaNumber: emailId!.text,)));
                    //       //
                    //       //                 },
                    //       //                 child: Container(
                    //       //                   height:  width*0.15 ,
                    //       //                   width: width*0.28,
                    //       //                   decoration: BoxDecoration(
                    //       //                       borderRadius: BorderRadius.circular(10),
                    //       //                       color: primarycolor2
                    //       //                   ),
                    //       //                   child: Center(
                    //       //                     child: Text('Transaction',style: GoogleFonts.poppins(
                    //       //                       fontSize: 15,
                    //       //                       color: Colors.white
                    //       //                     ),),
                    //       //                   ),
                    //       //                 ),
                    //       //               )
                    //       //             ],
                    //       //           ),
                    //       //         ),
                    //       //         actions: [
                    //       //           TextButton(onPressed: () {
                    //       //             Navigator.pop(buildcontext);
                    //       //           },
                    //       //               child: Text(
                    //       //                   'Cancel', style: GoogleFonts.outfit())),
                    //       //
                    //       //         ],
                    //       //       );
                    //       //     });
                    //
                    //
                    //     } else {
                    //       text == '' ?
                    //       showUploadMessage(context, 'Enter your book number ',
                    //           style: GoogleFonts.montserrat()) :
                    //       showUploadMessage(context,
                    //           'This Book is blocked by irregular transaction',
                    //           style: GoogleFonts.montserrat(
                    //               color: primarycolor2
                    //           ));
                    //     }
                    //   }else{
                    //     showUploadMessage(context, 'book does not exist', style: GoogleFonts.montserrat());
                    //
                    //   }
                    //   // }
                    // },
                    onChanged: (text) async {
                      setState((){
                        searchList.clear();
                        if(search.text==''){
                          searchList.addAll(bookList);
                        }else{
                          getSearchedData(text);
                        }
                      });

                      // if(text.substring(text.length-1,text.length)=='-'){
                      //   BookModel? data;
                      //   await FirebaseFirestore.instance.collection('shops')
                      //       .doc(currentshopId).collection('book').
                      //   where('bookName',isEqualTo: text.replaceAll('-', '')).get().then((event) {
                      //     for(var doc in event.docs){
                      //       data=BookModel.fromJson(doc.data());
                      //     }
                      //     if(mounted){
                      //       setState(() {
                      //
                      //       });
                      //     }
                      //
                      //
                      //   });
                      //   if(data!=null) {
                      //     if (text != '' && data!.block == false) {
                      //       Navigator.push(
                      //           context, MaterialPageRoute(builder: (context) =>
                      //           SingleBookDetailesPage(
                      //             bookData: data!,
                      //           )));
                      //
                      //
                      //       // showDialog(context: context,
                      //       //     builder: (buildcontext) {
                      //       //       return AlertDialog(
                      //       //         // contentPadding: EdgeInsets.all(20),
                      //       //         title: Text(
                      //       //           'Select Type', style: GoogleFonts.outfit(),),
                      //       //         content: Container(
                      //       //           width: width * 1,
                      //       //           height: width * 0.5,
                      //       //           child: Row(
                      //       //             mainAxisAlignment: MainAxisAlignment.spaceAround,
                      //       //             crossAxisAlignment: CrossAxisAlignment.center,
                      //       //             children: [
                      //       //               InkWell(
                      //       //                 onTap: (){
                      //       //                   Navigator.pop(buildcontext);
                      //       //                   // Navigator.push(context, MaterialPageRoute(builder: (context)=>Purchase(
                      //       //                   //   // iqamaNumber: emailId!.text,
                      //       //                   //    iqamaNumber: emailId!.text,
                      //       //                   // )));
                      //       //
                      //       //                 },
                      //       //                 child: Container(
                      //       //
                      //       //                   width: width*0.28,
                      //       //                   height:  width*0.15 ,
                      //       //                   decoration: BoxDecoration(
                      //       //                       color: primarycolor2,
                      //       //                     borderRadius: BorderRadius.circular(10)
                      //       //                   ),
                      //       //                   child: Center(
                      //       //                     child: Text('Purchase',style: GoogleFonts.poppins(
                      //       //                       fontSize: 15,
                      //       //                       color: Colors.white
                      //       //                     ),),
                      //       //                   ),
                      //       //                 ),
                      //       //               ),
                      //       //               SizedBox(width: 10,),
                      //       //               InkWell(
                      //       //                 onTap: (){
                      //       //                   Navigator.pop(buildcontext);
                      //       //                   Navigator.push(context, MaterialPageRoute(builder: (context)=>AddTransactionPage(
                      //       //                     iqamaNumber: emailId!.text,)));
                      //       //
                      //       //                 },
                      //       //                 child: Container(
                      //       //                   height:  width*0.15 ,
                      //       //                   width: width*0.28,
                      //       //                   decoration: BoxDecoration(
                      //       //                       borderRadius: BorderRadius.circular(10),
                      //       //                       color: primarycolor2
                      //       //                   ),
                      //       //                   child: Center(
                      //       //                     child: Text('Transaction',style: GoogleFonts.poppins(
                      //       //                       fontSize: 15,
                      //       //                       color: Colors.white
                      //       //                     ),),
                      //       //                   ),
                      //       //                 ),
                      //       //               )
                      //       //             ],
                      //       //           ),
                      //       //         ),
                      //       //         actions: [
                      //       //           TextButton(onPressed: () {
                      //       //             Navigator.pop(buildcontext);
                      //       //           },
                      //       //               child: Text(
                      //       //                   'Cancel', style: GoogleFonts.outfit())),
                      //       //
                      //       //         ],
                      //       //       );
                      //       //     });
                      //
                      //
                      //     } else {
                      //       text == '' ?
                      //       showUploadMessage(context, 'Enter your book number ',
                      //           style: GoogleFonts.montserrat()) :
                      //       showUploadMessage(context,
                      //           'This Book is blocked by irregular transaction',
                      //           style: GoogleFonts.montserrat(
                      //               color: primarycolor2
                      //           ));
                      //     }
                      //   }else{
                      //     showUploadMessage(context, 'book does not exist', style: GoogleFonts.montserrat());
                      //
                      //   }
                      // }
                    },
                    controller: search,
                    keyboardType:
                    TextInputType.number,

                    decoration: InputDecoration(
                      contentPadding: EdgeInsets.only(left: 15,top: 10),
                      hintText:
                      // widget.bookData.bookName.toString(),
                      'Search Book',
                      hintStyle:  GoogleFonts.montserrat(
                          color: primarycolor1.withOpacity(0.5),
                          fontSize: width * 0.045),

                      suffixIcon: Icon(Icons.search,),
                      disabledBorder:
                      InputBorder.none,
                      enabledBorder:
                      InputBorder.none,
                      errorBorder:
                      InputBorder.none,
                      border: InputBorder.none,
                      focusedBorder:
                      UnderlineInputBorder(
                        borderRadius:
                        BorderRadius.circular(
                            15),
                        borderSide:
                        const BorderSide(
                          color: Colors.white,
                          width: 2,
                        ),
                      ),
                    ),
                  ),
                ),
              ),
              bookList.length==0
                  ? Center(
                child: Text('No Books Found',style: GoogleFonts.montserrat(color: primarycolor2),),
              )
                  : Column(
                children: [
                  SizedBox(
                    height: width * 0.03,
                  ),
                  Container(
                    height: height*0.782,
                    child: ListView.builder(
                      shrinkWrap: true,
                      scrollDirection: Axis.vertical,
                      physics: BouncingScrollPhysics(),
                      itemCount: search.text==''?bookList.length:searchList.length,
                      itemBuilder: (context, index) {
                        BookModel data = search.text==''?bookList[index]:searchList[index];
                        return Padding(
                          padding: const EdgeInsets.only(top: 20,left: 10, right: 10),
                          child: InkWell(
                            onTap: (){
                              Navigator.push(
                                  context,
                                  MaterialPageRoute(
                                      builder: (context) => BookReportPage(
                                        bookId: data.bookId,
                                      )));
                              // if(data.block==false){
                              //   Navigator.push(context, MaterialPageRoute(builder: (context)=>SingleBookDetailesPage(
                              //     bookData:data,
                              //   )));
                              // }else{
                              //   showUploadMessage(context, 'This Book is blocked by irregular transaction', style: GoogleFonts.montserrat(
                              //     color: primarycolor2
                              //   ));
                              // }

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
                                    color: Color.fromRGBO(0, 0, 0, 0.1), // shadow color
                                    blurRadius: 15, // shadow radius
                                    offset: Offset(5, 10), // shadow offset
                                    spreadRadius: 0.4, // The amount the box should be inflated prior to applying the blur
                                    blurStyle: BlurStyle.normal, // set blur style
                                  ),
                                ],
                              ),
                              child: Padding(
                                padding: const EdgeInsets.all(8.0),
                                child: Row(
                                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                                  crossAxisAlignment: CrossAxisAlignment.center,
                                  children: [
                                    Row(
                                      children: [
                                        SizedBox(width: width*0.03,),
                                        Column(
                                          crossAxisAlignment: CrossAxisAlignment.start,
                                          children: [
                                            SizedBox(
                                              height: 15,
                                            ),
                                            Text(
                                              data.bookName!,
                                              style: GoogleFonts.montserrat(
                                                  fontSize: 17,
                                                  fontWeight: FontWeight.w700,
                                                  color: Colors.black
                                              ),
                                            ),
                                            Row(
                                              children: [
                                                Text(
                                                  DateFormat('dd MMM yyyy').format(data.createdDate!),
                                                  style: GoogleFonts.montserrat(
                                                      fontSize: 10,
                                                      fontWeight: FontWeight.w400,
                                                      color: Colors.black
                                                  ),
                                                ),
                                                SizedBox(
                                                  width: 10,
                                                ),
                                                Text(
                                                  DateFormat('jms').format(data.createdDate!),
                                                  style: GoogleFonts.montserrat(
                                                      fontSize: 10,
                                                      fontWeight: FontWeight.w400,
                                                      color: Colors.black
                                                  ),
                                                ),
                                              ],
                                            ),
                                          ],
                                        ),
                                      ],
                                    ),
                                    Row(
                                      crossAxisAlignment: CrossAxisAlignment.center,
                                      children: [
                                        Text(
                                          "${currencyCode ?? ''} ${data.credit?.toStringAsFixed(2) ?? ''}",
                                          style: GoogleFonts.montserrat(
                                              fontSize: 14,
                                              fontWeight: FontWeight.w700,
                                              color: primarycolor1
                                          ),
                                        ),
                                        SizedBox(width: width*0.05,),
                                        // SvgPicture.asset("assets/icons/delete.svg",height: 17,width: 14,),
                                        SizedBox(width: width*0.02,),
                                      ],
                                    ),
                                  ],
                                ),
                              ),
                            ),
                          ),
                        );
                      },
                    ),
                  ),
                ],
              ),
            ]
        ),
      ),
    );
  }
}
