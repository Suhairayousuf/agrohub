import 'dart:async';

import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:intl/intl.dart';

import 'package:flutter_svg/svg.dart';

import '../../../Model/bookModel.dart';
import '../../../core/utils/utils.dart';
import '../../../themes/color.dart';
import '../../Book/book/screen/single_book_detailes.dart';
import '../../Home/screen/selectShop.dart';
import '../../manage/Transaction/screen/ManagePage.dart';
import '../../auth/screen/splash.dart';

class InactiveMembersPage extends StatefulWidget {
  const InactiveMembersPage({Key? key}) : super(key: key);

  @override
  State<InactiveMembersPage> createState() => _InactiveMembersPageState();
}

class _InactiveMembersPageState extends State<InactiveMembersPage> {
  List<BookModel> threedaysBooks=[];
  // List <BookModel>bookList=[];
  List <BookModel>sevendaysBooks=[];
  List <BookModel>fifteendaysBooks=[];
  bool block=false;
  StreamSubscription? a;
  getInactive(){

    threedaysBooks=[];
    fifteendaysBooks=[];
    sevendaysBooks=[];
    for(var item in allBooks){

      if(DateTime.now().difference(item.update!).inDays>=3 &&
          DateTime.now().difference(item.update!).inDays<=7){
        threedaysBooks.add(item);
      }
      if(DateTime.now().difference(item.update!).inDays>=8 &&
          DateTime.now().difference(item.update!).inDays<15){

        sevendaysBooks.add(item);

      }
      if(DateTime.now().difference(item.update!).inDays>=15){


        fifteendaysBooks.add(item);
      }
    }
    if(mounted){
      setState(() {});
    }
  }
// getBook(){
//   a=FirebaseFirestore.instance
//       .collection('shops').doc(currentshopId).collection('book').snapshots().listen((event) {
//     threedaysBooks=[];
//     fifteendaysBooks=[];
//     sevendaysBooks=[];
//     for(var data in event.docs){
//       if(DateTime.now().difference(data.get('update').toDate()).inDays>=3 &&
//           DateTime.now().difference(data.get('update').toDate()).inDays<=7){
//          threedaysBooks.add(BookModel.fromJson(data.data()));
//          print(threedaysBooks.length);
//
//
//       }
//       if(DateTime.now().difference(data.get('update').toDate()).inDays>=8 &&
//           DateTime.now().difference(data.get('update').toDate()).inDays<15){
//         fifteendaysBooks.add(BookModel.fromJson(data.data()));
//
//
//       }
//       if(DateTime.now().difference(data.get('update').toDate()).inDays>=15){
//         sevendaysBooks.add(BookModel.fromJson(data.data()));
//
//         print(sevendaysBooks.length);
//         print('sevendaysBooks');
//       }
//
//     }
//     if(mounted){
//       setState(() {
//
//       });
//     }
//   });
//
// }
@override
  void initState() {
      super.initState();
      getInactive();
  }

  @override
  void dispose() {
    // a?.cancel();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return DefaultTabController(
        length: 3,
        child: Scaffold(
          appBar: AppBar(
            backgroundColor: primarycolor1,
            elevation: 0,
            bottom:  TabBar(
                labelColor: primarycolor1,
                unselectedLabelColor: Colors.white,
                indicatorSize: TabBarIndicatorSize.label,
                indicator: BoxDecoration(
                     borderRadius: BorderRadius.only(
                        topLeft: Radius.circular(10),
                        topRight: Radius.circular(10)),
                    color: Colors.white),
                tabs: [
                  Tab(
                    child: Align(
                      alignment: Alignment.center,
                      child: Text("3-7 days"),
                    ),
                  ),
                  Tab(
                    child: Align(
                      alignment: Alignment.center,
                      child: Text("7-15 days"),
                    ),
                  ),
                  Tab(
                    child: Align(
                      alignment: Alignment.center,
                      child: Text("15 days more"),
                    ),
                  ),
                ]
            ),
          ),
          body: TabBarView(children: [
            Column(
              children: [
                // AppBar("BOOK"),
                threedaysBooks.length == 0
                    ? Container(
                    height: width,
                      child: Center(
                        child: Text(
                          'No Books Found',
                          style: GoogleFonts.montserrat(color: primarycolor2),
                        ),
                      ),
                    )
                    : Expanded(

                      child: ListView.builder(
                        shrinkWrap: true,
                        scrollDirection: Axis.vertical,
                        // physics: BouncingScrollPhysics(),
                        itemCount: threedaysBooks.length,
                        itemBuilder: (context, index) {
                          BookModel data = threedaysBooks[index];
                          return Padding(
                            padding: const EdgeInsets.only(
                                top: 20, left: 10, right: 10),
                            child: InkWell(
                              onLongPress: (){
                                showDialog(
                                  context: context,
                                  builder:
                                      (BuildContext context) {
                                    return data.block==false? SizedBox(
                                      width: width,
                                      child: AlertDialog(
                                        title: Row(
                                          mainAxisAlignment:
                                          MainAxisAlignment
                                              .center,
                                          children: [
                                            Text(
                                              "Are you sure",
                                              style: GoogleFonts.montserrat(
                                                  fontSize: 20,
                                                  color:
                                                  primarycolor1,
                                                  fontWeight:
                                                  FontWeight
                                                      .w500),
                                            ),
                                          ],
                                        ),
                                        content: Text(
                                            "Do You Want to block this book"),
                                        actions: [
                                          Row(
                                            mainAxisAlignment: MainAxisAlignment.end,
                                            children: [
                                              InkWell(
                                                onTap: () {
                                                  Navigator.pop(context);
                                                },
                                                child: Container(
                                                  width:
                                                  width * 0.15,
                                                  height:
                                                  width * 0.08,
                                                  decoration:
                                                  BoxDecoration(
                                                    color:
                                                    primarycolor1,
                                                    borderRadius:
                                                    BorderRadius
                                                        .circular(
                                                        4),
                                                  ),
                                                  child: Center(
                                                    child: Text(
                                                      "No",
                                                      style: GoogleFonts.montserrat(
                                                          color: Colors
                                                              .white,
                                                          fontSize:
                                                          width *
                                                              0.04,
                                                          fontWeight:
                                                          FontWeight
                                                              .w500),
                                                    ),
                                                  ),
                                                ),
                                              ),
                                              SizedBox(width: width*0.05,),
                                              InkWell(
                                                onTap: () async {
                                                  block=true;
                                                  await FirebaseFirestore.instance
                                                      .collection("shops")
                                                      .doc(currentshopId)
                                                      .collection("book")
                                                      .doc(data.bookId).update(
                                                      {
                                                        'block':true
                                                      });
                                                  // .delete();
                                                  Navigator.pop(context);
                                                },
                                                child: Container(
                                                  width: width *
                                                      0.15,
                                                  height: width *
                                                      0.08,
                                                  decoration:
                                                  BoxDecoration(
                                                    color:
                                                    primarycolor1,
                                                    borderRadius:
                                                    BorderRadius
                                                        .circular(
                                                        4),
                                                  ),
                                                  child: Center(
                                                    child: Text(
                                                      "Yes",
                                                      style: GoogleFonts.montserrat(
                                                          color: Colors
                                                              .white,
                                                          fontSize:
                                                          width *
                                                              0.04,
                                                          fontWeight:
                                                          FontWeight.w500),
                                                    ),
                                                  ),
                                                ),
                                              ),
                                              SizedBox(width: width*0.03,),

                                            ],
                                          )
                                        ],
                                      ),
                                    ):
                                    SizedBox(
                                      width: width,
                                      child: AlertDialog(
                                        title: Row(
                                          mainAxisAlignment:
                                          MainAxisAlignment
                                              .center,
                                          children: [
                                            Text(
                                              "Are you sure",
                                              style: GoogleFonts.montserrat(
                                                  fontSize: 20,
                                                  color:
                                                  primarycolor1,
                                                  fontWeight:
                                                  FontWeight
                                                      .w500),
                                            ),
                                          ],
                                        ),
                                        content: Text(
                                            "Do You Want to Unblock this book"),
                                        actions: [
                                          Row(
                                            mainAxisAlignment: MainAxisAlignment.end,
                                            children: [
                                              InkWell(
                                                onTap: () {
                                                  Navigator.pop(context);
                                                },
                                                child: Container(
                                                  width:
                                                  width * 0.15,
                                                  height:
                                                  width * 0.08,
                                                  decoration:
                                                  BoxDecoration(
                                                    color:
                                                    primarycolor1,
                                                    borderRadius:
                                                    BorderRadius
                                                        .circular(
                                                        4),
                                                  ),
                                                  child: Center(
                                                    child: Text(
                                                      "No",
                                                      style: GoogleFonts.montserrat(
                                                          color: Colors
                                                              .white,
                                                          fontSize:
                                                          width *
                                                              0.04,
                                                          fontWeight:
                                                          FontWeight
                                                              .w500),
                                                    ),
                                                  ),
                                                ),
                                              ),
                                              SizedBox(width: width*0.05,),
                                              InkWell(
                                                onTap: () async {
                                                  await FirebaseFirestore.instance
                                                      .collection("shops")
                                                      .doc(currentshopId)
                                                      .collection("book")
                                                      .doc(data.bookId).update(
                                                      {
                                                        'block':false
                                                      });
                                                  // .delete();
                                                  Navigator.pop(context);
                                                },
                                                child: Container(
                                                  width: width *
                                                      0.15,
                                                  height: width *
                                                      0.08,
                                                  decoration:
                                                  BoxDecoration(
                                                    color:
                                                    primarycolor1,
                                                    borderRadius:
                                                    BorderRadius
                                                        .circular(
                                                        4),
                                                  ),
                                                  child: Center(
                                                    child: Text(
                                                      "Yes",
                                                      style: GoogleFonts.montserrat(
                                                          color: Colors
                                                              .white,
                                                          fontSize:
                                                          width *
                                                              0.04,
                                                          fontWeight:
                                                          FontWeight.w500),
                                                    ),
                                                  ),
                                                ),
                                              ),
                                              SizedBox(width: width*0.03,),

                                            ],
                                          )
                                        ],
                                      ),
                                    );
                                  },
                                );
                              },
                              onTap: () {
                                Navigator.push(
                                    context,
                                    MaterialPageRoute(
                                        builder: (context) => SingleBookDetailesPage(
                                           bookData: data,
                                        )));
                              },
                              child: Container(
                                // padding: EdgeInsets.only(left: 10, right: 10),

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
                                child: Padding(
                                  padding: const EdgeInsets.all(8.0),
                                  child: Row(
                                    mainAxisAlignment:
                                    MainAxisAlignment.spaceBetween,
                                    crossAxisAlignment:
                                    CrossAxisAlignment.center,
                                    children: [
                                      Expanded(
                                        child: Column(
                                          crossAxisAlignment:
                                          CrossAxisAlignment.start,
                                          children: [
                                            SizedBox(
                                              height: 15,
                                            ),
                                            Text(
                                              data.bookName!,
                                              style: GoogleFonts.montserrat(
                                                  fontSize: 25,
                                                  fontWeight: FontWeight.bold,
                                                  color: Colors.black),
                                            ),
                                            Text(
                                              DateFormat('dd MMM yyyy / hh:mm aa')
                                                  .format(
                                                  data.update!),
                                              style:
                                              GoogleFonts.montserrat(
                                                  fontSize: 15,
                                                  fontWeight:
                                                  FontWeight.w400,
                                                  color:
                                                  Colors.black),
                                            ),
                                            SizedBox(height: 10,),
                                            threedaysBooks[index].members!.isEmpty?Container():  StreamBuilder<QuerySnapshot>(
                                                stream: FirebaseFirestore.instance.collection('users').where('userEmail',isEqualTo: threedaysBooks[index].members![0]).snapshots(),
                                                builder: (context, snapshot) {
                                                  if(!snapshot.hasData){
                                                    return Center(child: CircularProgressIndicator());
                                                  }
                                                  if(snapshot.data!.docs.isEmpty){
                                                    return Container();
                                                  }
                                                  return Text(
                                                    "${snapshot.data!.docs[0].get('userName')}",
                                                    style: GoogleFonts.montserrat(
                                                        fontSize: width * 0.03,
                                                        color: primarycolor1,
                                                        fontWeight: FontWeight.w600),
                                                  );
                                                }
                                            ),
                                          ],
                                        ),
                                      ),
                                      Row(
                                        crossAxisAlignment:
                                        CrossAxisAlignment.center,
                                        children: [
                                          Text(
                                            "${currencyCode ?? ''} ${data.credit ?? ''}",
                                            style: GoogleFonts.montserrat(
                                                fontSize: 14,
                                                fontWeight: FontWeight.w700,
                                                color: primarycolor1),
                                          ),
                                          SizedBox(
                                            width: width * 0.05,
                                          ),
                                          InkWell(
                                            onTap: () {
                                              // showDialog(
                                              //   context: context,
                                              //   builder:
                                              //       (BuildContext context) {
                                              //     return SizedBox(
                                              //       width: width,
                                              //       child: AlertDialog(
                                              //         title: Row(
                                              //           mainAxisAlignment:
                                              //           MainAxisAlignment
                                              //               .center,
                                              //           children: [
                                              //             Text(
                                              //               "Are you sure",
                                              //               style: GoogleFonts.montserrat(
                                              //                   fontSize: 20,
                                              //                   color:
                                              //                   primarycolor1,
                                              //                   fontWeight:
                                              //                   FontWeight
                                              //                       .w500),
                                              //             ),
                                              //           ],
                                              //         ),
                                              //         content: Text(
                                              //             "Do You Want to block this book"),
                                              //         actions: [
                                              //           Row(
                                              //             mainAxisAlignment: MainAxisAlignment.end,
                                              //             children: [
                                              //               InkWell(
                                              //                 onTap: () {
                                              //                   Navigator.pop(context);
                                              //                 },
                                              //                 child: Container(
                                              //                   width:
                                              //                   width * 0.15,
                                              //                   height:
                                              //                   width * 0.08,
                                              //                   decoration:
                                              //                   BoxDecoration(
                                              //                     color:
                                              //                     primarycolor1,
                                              //                     borderRadius:
                                              //                     BorderRadius
                                              //                         .circular(
                                              //                         4),
                                              //                   ),
                                              //                   child: Center(
                                              //                     child: Text(
                                              //                       "No",
                                              //                       style: GoogleFonts.montserrat(
                                              //                           color: Colors
                                              //                               .white,
                                              //                           fontSize:
                                              //                           width *
                                              //                               0.04,
                                              //                           fontWeight:
                                              //                           FontWeight
                                              //                               .w500),
                                              //                     ),
                                              //                   ),
                                              //                 ),
                                              //               ),
                                              //               SizedBox(width: width*0.05,),
                                              //               InkWell(
                                              //                 onTap: () async {
                                              //                   block=true;
                                              //                   await FirebaseFirestore.instance
                                              //                       .collection("shops")
                                              //                       .doc(currentshopId)
                                              //                       .collection("book")
                                              //                       .doc(data.bookId).update(
                                              //                       {
                                              //                         'block':true
                                              //                       });
                                              //                       // .delete();
                                              //                   Navigator.pop(context);
                                              //                 },
                                              //                 child: Container(
                                              //                   width: width *
                                              //                       0.15,
                                              //                   height: width *
                                              //                       0.08,
                                              //                   decoration:
                                              //                   BoxDecoration(
                                              //                     color:
                                              //                     primarycolor1,
                                              //                     borderRadius:
                                              //                     BorderRadius
                                              //                         .circular(
                                              //                         4),
                                              //                   ),
                                              //                   child: Center(
                                              //                     child: Text(
                                              //                       "Yes",
                                              //                       style: GoogleFonts.montserrat(
                                              //                           color: Colors
                                              //                               .white,
                                              //                           fontSize:
                                              //                           width *
                                              //                               0.04,
                                              //                           fontWeight:
                                              //                           FontWeight.w500),
                                              //                     ),
                                              //                   ),
                                              //                 ),
                                              //               ),
                                              //               SizedBox(width: width*0.03,),
                                              //
                                              //             ],
                                              //           )
                                              //         ],
                                              //       ),
                                              //     );
                                              //   },
                                              // );
                                            },
                                            child:
                                            data.block==true? Icon(Icons.block,color: Colors.red,):Container()
                                            // SvgPicture.asset(
                                            //   "assets/icons/delete.svg",
                                            //   height: 17,
                                            //   width: 14,
                                            // ),
                                          ),
                                          SizedBox(
                                            width: width * 0.02,
                                          ),
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
            Column(
              children: [
                // AppBar("BOOK"),
                sevendaysBooks.length == 0
                    ? Container(
                    height: width,
                      child: Center(
                        child: Text(
                          'No Books Found',
                          style: GoogleFonts.montserrat(color: primarycolor2),
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
                        itemCount: sevendaysBooks.length,
                        itemBuilder: (context, index) {
                          BookModel data = sevendaysBooks[index];
                          return Padding(
                            padding: const EdgeInsets.only(
                                top: 20, left: 10, right: 10),
                            child: InkWell(
                              onLongPress: (){
                                showDialog(
                                  context: context,
                                  builder:
                                      (BuildContext context) {
                                    return data.block==false? SizedBox(
                                      width: width,
                                      child: AlertDialog(
                                        title: Row(
                                          mainAxisAlignment:
                                          MainAxisAlignment
                                              .center,
                                          children: [
                                            Text(
                                              "Are you sure",
                                              style: GoogleFonts.montserrat(
                                                  fontSize: 20,
                                                  color:
                                                  primarycolor1,
                                                  fontWeight:
                                                  FontWeight
                                                      .w500),
                                            ),
                                          ],
                                        ),
                                        content: Text(
                                            "Do You Want to block this book"),
                                        actions: [
                                          Row(
                                            mainAxisAlignment: MainAxisAlignment.end,
                                            children: [
                                              InkWell(
                                                onTap: () {
                                                  Navigator.pop(context);
                                                },
                                                child: Container(
                                                  width:
                                                  width * 0.15,
                                                  height:
                                                  width * 0.08,
                                                  decoration:
                                                  BoxDecoration(
                                                    color:
                                                    primarycolor1,
                                                    borderRadius:
                                                    BorderRadius
                                                        .circular(
                                                        4),
                                                  ),
                                                  child: Center(
                                                    child: Text(
                                                      "No",
                                                      style: GoogleFonts.montserrat(
                                                          color: Colors
                                                              .white,
                                                          fontSize:
                                                          width *
                                                              0.04,
                                                          fontWeight:
                                                          FontWeight
                                                              .w500),
                                                    ),
                                                  ),
                                                ),
                                              ),
                                              SizedBox(width: width*0.05,),
                                              InkWell(
                                                onTap: () async {
                                                  block=true;
                                                  await FirebaseFirestore.instance
                                                      .collection("shops")
                                                      .doc(currentshopId)
                                                      .collection("book")
                                                      .doc(data.bookId).update(
                                                      {
                                                        'block':true
                                                      });
                                                  // .delete();
                                                  Navigator.pop(context);
                                                },
                                                child: Container(
                                                  width: width *
                                                      0.15,
                                                  height: width *
                                                      0.08,
                                                  decoration:
                                                  BoxDecoration(
                                                    color:
                                                    primarycolor1,
                                                    borderRadius:
                                                    BorderRadius
                                                        .circular(
                                                        4),
                                                  ),
                                                  child: Center(
                                                    child: Text(
                                                      "Yes",
                                                      style: GoogleFonts.montserrat(
                                                          color: Colors
                                                              .white,
                                                          fontSize:
                                                          width *
                                                              0.04,
                                                          fontWeight:
                                                          FontWeight.w500),
                                                    ),
                                                  ),
                                                ),
                                              ),
                                              SizedBox(width: width*0.03,),

                                            ],
                                          )
                                        ],
                                      ),
                                    ):
                                    SizedBox(
                                      width: width,
                                      child: AlertDialog(
                                        title: Row(
                                          mainAxisAlignment:
                                          MainAxisAlignment
                                              .center,
                                          children: [
                                            Text(
                                              "Are you sure",
                                              style: GoogleFonts.montserrat(
                                                  fontSize: 20,
                                                  color:
                                                  primarycolor1,
                                                  fontWeight:
                                                  FontWeight
                                                      .w500),
                                            ),
                                          ],
                                        ),
                                        content: Text(
                                            "Do You Want to Unblock this book"),
                                        actions: [
                                          Row(
                                            mainAxisAlignment: MainAxisAlignment.end,
                                            children: [
                                              InkWell(
                                                onTap: () {
                                                  Navigator.pop(context);
                                                },
                                                child: Container(
                                                  width:
                                                  width * 0.15,
                                                  height:
                                                  width * 0.08,
                                                  decoration:
                                                  BoxDecoration(
                                                    color:
                                                    primarycolor1,
                                                    borderRadius:
                                                    BorderRadius
                                                        .circular(
                                                        4),
                                                  ),
                                                  child: Center(
                                                    child: Text(
                                                      "No",
                                                      style: GoogleFonts.montserrat(
                                                          color: Colors
                                                              .white,
                                                          fontSize:
                                                          width *
                                                              0.04,
                                                          fontWeight:
                                                          FontWeight
                                                              .w500),
                                                    ),
                                                  ),
                                                ),
                                              ),
                                              SizedBox(width: width*0.05,),
                                              InkWell(
                                                onTap: () async {
                                                  await FirebaseFirestore.instance
                                                      .collection("shops")
                                                      .doc(currentshopId)
                                                      .collection("book")
                                                      .doc(data.bookId).update(
                                                      {
                                                        'block':false
                                                      });
                                                  // .delete();
                                                  Navigator.pop(context);
                                                },
                                                child: Container(
                                                  width: width *
                                                      0.15,
                                                  height: width *
                                                      0.08,
                                                  decoration:
                                                  BoxDecoration(
                                                    color:
                                                    primarycolor1,
                                                    borderRadius:
                                                    BorderRadius
                                                        .circular(
                                                        4),
                                                  ),
                                                  child: Center(
                                                    child: Text(
                                                      "Yes",
                                                      style: GoogleFonts.montserrat(
                                                          color: Colors
                                                              .white,
                                                          fontSize:
                                                          width *
                                                              0.04,
                                                          fontWeight:
                                                          FontWeight.w500),
                                                    ),
                                                  ),
                                                ),
                                              ),
                                              SizedBox(width: width*0.03,),

                                            ],
                                          )
                                        ],
                                      ),
                                    );
                                  },
                                );
                              },
                              onTap: () {
                                Navigator.push(
                                    context,
                                    MaterialPageRoute(
                                        builder: (context) => SingleBookDetailesPage(
                                          bookData: data,
                                        )));
                                // Navigator.push(
                                //     context,
                                //     MaterialPageRoute(
                                //         builder: (context) => BookReportPage(
                                //           bookId: data.bookId,
                                //         )));
                              },
                              child: Container(
                                // padding: EdgeInsets.only(left: 10, right: 10),

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
                                child: Padding(
                                  padding: const EdgeInsets.all(8.0),
                                  child: Row(
                                    mainAxisAlignment:
                                    MainAxisAlignment.spaceBetween,
                                    crossAxisAlignment:
                                    CrossAxisAlignment.center,
                                    children: [
                                      Expanded(
                                        child: Column(
                                          crossAxisAlignment:
                                          CrossAxisAlignment.start,
                                          children: [
                                            SizedBox(
                                              height: 15,
                                            ),
                                            Text(
                                              data.bookName!,
                                              style: GoogleFonts.montserrat(
                                                  fontSize: 25,
                                                  fontWeight: FontWeight.bold,
                                                  color: Colors.black),
                                            ),
                                            Text(
                                              DateFormat('dd MMM yyyy / hh:mm aa')
                                                  .format(
                                                  data.update!),
                                              style:
                                              GoogleFonts.montserrat(
                                                  fontSize: 15,
                                                  fontWeight:
                                                  FontWeight.w400,
                                                  color:
                                                  Colors.black),
                                            ),
                                            SizedBox(height: 10,),
                                            sevendaysBooks[index].members!.isEmpty?Container():  StreamBuilder<QuerySnapshot>(
                                                stream: FirebaseFirestore.instance.collection('users').where('userEmail',isEqualTo: sevendaysBooks[index].members![0]).snapshots(),
                                                builder: (context, snapshot) {
                                                  if(!snapshot.hasData){
                                                    return Center(child: CircularProgressIndicator());
                                                  }
                                                  if(snapshot.data!.docs.isEmpty){
                                                    return Container();
                                                  }
                                                  return Text(
                                                    "${snapshot.data!.docs[0].get('userName')}",
                                                    style: GoogleFonts.montserrat(
                                                        fontSize: width * 0.03,
                                                        color: primarycolor1,
                                                        fontWeight: FontWeight.w600),
                                                  );
                                                }
                                            ),
                                          ],
                                        ),
                                      ),
                                      Row(
                                        crossAxisAlignment:
                                        CrossAxisAlignment.center,
                                        children: [
                                          Text(
                                            "${currencyCode ?? ''} ${data.credit ?? ''}",
                                            style: GoogleFonts.montserrat(
                                                fontSize: 14,
                                                fontWeight: FontWeight.w700,
                                                color: primarycolor1),
                                          ),
                                          SizedBox(
                                            width: width * 0.05,
                                          ),
                                          InkWell(
                                              onTap: () {
                                                // showDialog(
                                                //   context: context,
                                                //   builder:
                                                //       (BuildContext context) {
                                                //     return SizedBox(
                                                //       width: width,
                                                //       child: AlertDialog(
                                                //         title: Row(
                                                //           mainAxisAlignment:
                                                //           MainAxisAlignment
                                                //               .center,
                                                //           children: [
                                                //             Text(
                                                //               "Are you sure",
                                                //               style: GoogleFonts.montserrat(
                                                //                   fontSize: 20,
                                                //                   color:
                                                //                   primarycolor1,
                                                //                   fontWeight:
                                                //                   FontWeight
                                                //                       .w500),
                                                //             ),
                                                //           ],
                                                //         ),
                                                //         content: Text(
                                                //             "Do You Want to block this book"),
                                                //         actions: [
                                                //           Row(
                                                //             mainAxisAlignment: MainAxisAlignment.end,
                                                //             children: [
                                                //               InkWell(
                                                //                 onTap: () {
                                                //                   Navigator.pop(context);
                                                //                 },
                                                //                 child: Container(
                                                //                   width:
                                                //                   width * 0.15,
                                                //                   height:
                                                //                   width * 0.08,
                                                //                   decoration:
                                                //                   BoxDecoration(
                                                //                     color:
                                                //                     primarycolor1,
                                                //                     borderRadius:
                                                //                     BorderRadius
                                                //                         .circular(
                                                //                         4),
                                                //                   ),
                                                //                   child: Center(
                                                //                     child: Text(
                                                //                       "No",
                                                //                       style: GoogleFonts.montserrat(
                                                //                           color: Colors
                                                //                               .white,
                                                //                           fontSize:
                                                //                           width *
                                                //                               0.04,
                                                //                           fontWeight:
                                                //                           FontWeight
                                                //                               .w500),
                                                //                     ),
                                                //                   ),
                                                //                 ),
                                                //               ),
                                                //               SizedBox(width: width*0.05,),
                                                //               InkWell(
                                                //                 onTap: () async {
                                                //                   block=true;
                                                //                   await FirebaseFirestore.instance
                                                //                       .collection("shops")
                                                //                       .doc(currentshopId)
                                                //                       .collection("book")
                                                //                       .doc(data.bookId).update(
                                                //                       {
                                                //                         'block':true
                                                //                       });
                                                //                       // .delete();
                                                //                   Navigator.pop(context);
                                                //                 },
                                                //                 child: Container(
                                                //                   width: width *
                                                //                       0.15,
                                                //                   height: width *
                                                //                       0.08,
                                                //                   decoration:
                                                //                   BoxDecoration(
                                                //                     color:
                                                //                     primarycolor1,
                                                //                     borderRadius:
                                                //                     BorderRadius
                                                //                         .circular(
                                                //                         4),
                                                //                   ),
                                                //                   child: Center(
                                                //                     child: Text(
                                                //                       "Yes",
                                                //                       style: GoogleFonts.montserrat(
                                                //                           color: Colors
                                                //                               .white,
                                                //                           fontSize:
                                                //                           width *
                                                //                               0.04,
                                                //                           fontWeight:
                                                //                           FontWeight.w500),
                                                //                     ),
                                                //                   ),
                                                //                 ),
                                                //               ),
                                                //               SizedBox(width: width*0.03,),
                                                //
                                                //             ],
                                                //           )
                                                //         ],
                                                //       ),
                                                //     );
                                                //   },
                                                // );
                                              },
                                              child:
                                              data.block==true? Icon(Icons.block,color: Colors.red,):Container()
                                            // SvgPicture.asset(
                                            //   "assets/icons/delete.svg",
                                            //   height: 17,
                                            //   width: 14,
                                            // ),
                                          ),
                                          SizedBox(
                                            width: width * 0.02,
                                          ),
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
              ],
            ),
            Column(
              children: [
                // AppBar("BOOK"),
                fifteendaysBooks.length == 0
                    ? Container(
                    height: width,
                      child: Center(
                        child: Text(
                          'No Books Found',
                          style: GoogleFonts.montserrat(color: primarycolor2),
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
                        itemCount: fifteendaysBooks.length,
                        itemBuilder: (context, index) {
                          BookModel data = fifteendaysBooks[index];
                          return Padding(
                            padding: const EdgeInsets.only(
                                top: 20, left: 10, right: 10),
                            child: InkWell(
                              onLongPress: (){
                                showDialog(
                                  context: context,
                                  builder:
                                      (BuildContext context) {
                                    return data.block==false? SizedBox(
                                      width: width,
                                      child: AlertDialog(
                                        title: Row(
                                          mainAxisAlignment:
                                          MainAxisAlignment
                                              .center,
                                          children: [
                                            Text(
                                              "Are you sure",
                                              style: GoogleFonts.montserrat(
                                                  fontSize: 20,
                                                  color:
                                                  primarycolor1,
                                                  fontWeight:
                                                  FontWeight
                                                      .w500),
                                            ),
                                          ],
                                        ),
                                        content: Text(
                                            "Do You Want to block this book"),
                                        actions: [
                                          Row(
                                            mainAxisAlignment: MainAxisAlignment.end,
                                            children: [
                                              InkWell(
                                                onTap: () {
                                                  Navigator.pop(context);
                                                },
                                                child: Container(
                                                  width:
                                                  width * 0.15,
                                                  height:
                                                  width * 0.08,
                                                  decoration:
                                                  BoxDecoration(
                                                    color:
                                                    primarycolor1,
                                                    borderRadius:
                                                    BorderRadius
                                                        .circular(
                                                        4),
                                                  ),
                                                  child: Center(
                                                    child: Text(
                                                      "No",
                                                      style: GoogleFonts.montserrat(
                                                          color: Colors
                                                              .white,
                                                          fontSize:
                                                          width *
                                                              0.04,
                                                          fontWeight:
                                                          FontWeight
                                                              .w500),
                                                    ),
                                                  ),
                                                ),
                                              ),
                                              SizedBox(width: width*0.05,),
                                              InkWell(
                                                onTap: () async {
                                                  block=true;
                                                  await FirebaseFirestore.instance
                                                      .collection("shops")
                                                      .doc(currentshopId)
                                                      .collection("book")
                                                      .doc(data.bookId).update(
                                                      {
                                                        'block':true
                                                      });
                                                  // .delete();
                                                  Navigator.pop(context);
                                                },
                                                child: Container(
                                                  width: width *
                                                      0.15,
                                                  height: width *
                                                      0.08,
                                                  decoration:
                                                  BoxDecoration(
                                                    color:
                                                    primarycolor1,
                                                    borderRadius:
                                                    BorderRadius
                                                        .circular(
                                                        4),
                                                  ),
                                                  child: Center(
                                                    child: Text(
                                                      "Yes",
                                                      style: GoogleFonts.montserrat(
                                                          color: Colors
                                                              .white,
                                                          fontSize:
                                                          width *
                                                              0.04,
                                                          fontWeight:
                                                          FontWeight.w500),
                                                    ),
                                                  ),
                                                ),
                                              ),
                                              SizedBox(width: width*0.03,),

                                            ],
                                          )
                                        ],
                                      ),
                                    ):
                                    SizedBox(
                                      width: width,
                                      child: AlertDialog(
                                        title: Row(
                                          mainAxisAlignment:
                                          MainAxisAlignment
                                              .center,
                                          children: [
                                            Text(
                                              "Are you sure",
                                              style: GoogleFonts.montserrat(
                                                  fontSize: 20,
                                                  color:
                                                  primarycolor1,
                                                  fontWeight:
                                                  FontWeight
                                                      .w500),
                                            ),
                                          ],
                                        ),
                                        content: Text(
                                            "Do You Want to Unblock this book"),
                                        actions: [
                                          Row(
                                            mainAxisAlignment: MainAxisAlignment.end,
                                            children: [
                                              InkWell(
                                                onTap: () {
                                                  Navigator.pop(context);
                                                },
                                                child: Container(
                                                  width:
                                                  width * 0.15,
                                                  height:
                                                  width * 0.08,
                                                  decoration:
                                                  BoxDecoration(
                                                    color:
                                                    primarycolor1,
                                                    borderRadius:
                                                    BorderRadius
                                                        .circular(
                                                        4),
                                                  ),
                                                  child: Center(
                                                    child: Text(
                                                      "No",
                                                      style: GoogleFonts.montserrat(
                                                          color: Colors
                                                              .white,
                                                          fontSize:
                                                          width *
                                                              0.04,
                                                          fontWeight:
                                                          FontWeight
                                                              .w500),
                                                    ),
                                                  ),
                                                ),
                                              ),
                                              SizedBox(width: width*0.05,),
                                              InkWell(
                                                onTap: () async {
                                                  await FirebaseFirestore.instance
                                                      .collection("shops")
                                                      .doc(currentshopId)
                                                      .collection("book")
                                                      .doc(data.bookId).update(
                                                      {
                                                        'block':false
                                                      });
                                                  // .delete();
                                                  Navigator.pop(context);
                                                },
                                                child: Container(
                                                  width: width *
                                                      0.15,
                                                  height: width *
                                                      0.08,
                                                  decoration:
                                                  BoxDecoration(
                                                    color:
                                                    primarycolor1,
                                                    borderRadius:
                                                    BorderRadius
                                                        .circular(
                                                        4),
                                                  ),
                                                  child: Center(
                                                    child: Text(
                                                      "Yes",
                                                      style: GoogleFonts.montserrat(
                                                          color: Colors
                                                              .white,
                                                          fontSize:
                                                          width *
                                                              0.04,
                                                          fontWeight:
                                                          FontWeight.w500),
                                                    ),
                                                  ),
                                                ),
                                              ),
                                              SizedBox(width: width*0.03,),

                                            ],
                                          )
                                        ],
                                      ),
                                    );
                                  },
                                );
                              },
                              onTap: () {
                                Navigator.push(
                                    context,
                                    MaterialPageRoute(
                                        builder: (context) => SingleBookDetailesPage(
                                          bookData: data,
                                        )));
                                // Navigator.push(
                                //     context,
                                //     MaterialPageRoute(
                                //         builder: (context) => BookReportPage(
                                //           bookId: data.bookId,
                                //         )));
                              },
                              child: Container(
                                // padding: EdgeInsets.only(left: 10, right: 10),

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
                                child: Padding(
                                  padding: const EdgeInsets.all(8.0),
                                  child: Row(
                                    mainAxisAlignment:
                                    MainAxisAlignment.spaceBetween,
                                    crossAxisAlignment:
                                    CrossAxisAlignment.center,
                                    children: [
                                      Expanded(
                                        child: Column(
                                          crossAxisAlignment:
                                          CrossAxisAlignment.start,
                                          children: [
                                            SizedBox(
                                              height: 15,
                                            ),
                                            Text(
                                              data.bookName!,
                                              style: GoogleFonts.montserrat(
                                                  fontSize: 25,
                                                  fontWeight: FontWeight.bold,
                                                  color: Colors.black),
                                            ),
                                            Text(
                                              DateFormat('dd MMM yyyy / hh:mm aa')
                                                  .format(
                                                  data.update!),
                                              style:
                                              GoogleFonts.montserrat(
                                                  fontSize: 15,
                                                  fontWeight:
                                                  FontWeight.w400,
                                                  color:
                                                  Colors.black),
                                            ),
                                            SizedBox(height: 10,),
                                            fifteendaysBooks[index].members!.isEmpty?Container():  StreamBuilder<QuerySnapshot>(
                                                stream: FirebaseFirestore.instance.collection('users').where('userEmail',isEqualTo: fifteendaysBooks[index].members![0]).snapshots(),
                                                builder: (context, snapshot) {
                                                  if(!snapshot.hasData){
                                                    return Center(child: CircularProgressIndicator());
                                                  }
                                                  if(snapshot.data!.docs.isEmpty){
                                                    return Container();
                                                  }
                                                  return Text(
                                                    "${snapshot.data!.docs[0].get('userName')}",
                                                    style: GoogleFonts.montserrat(
                                                        fontSize: width * 0.03,
                                                        color: primarycolor1,
                                                        fontWeight: FontWeight.w600),
                                                  );
                                                }
                                            ),
                                          ],
                                        ),
                                      ),
                                      Row(
                                        crossAxisAlignment:
                                        CrossAxisAlignment.center,
                                        children: [
                                          Text(
                                            "${currencyCode ?? ''} ${data.credit ?? ''}",
                                            style: GoogleFonts.montserrat(
                                                fontSize: 14,
                                                fontWeight: FontWeight.w700,
                                                color: primarycolor1),
                                          ),
                                          SizedBox(
                                            width: width * 0.05,
                                          ),
                                          InkWell(
                                              onTap: () {
                                                // showDialog(
                                                //   context: context,
                                                //   builder:
                                                //       (BuildContext context) {
                                                //     return SizedBox(
                                                //       width: width,
                                                //       child: AlertDialog(
                                                //         title: Row(
                                                //           mainAxisAlignment:
                                                //           MainAxisAlignment
                                                //               .center,
                                                //           children: [
                                                //             Text(
                                                //               "Are you sure",
                                                //               style: GoogleFonts.montserrat(
                                                //                   fontSize: 20,
                                                //                   color:
                                                //                   primarycolor1,
                                                //                   fontWeight:
                                                //                   FontWeight
                                                //                       .w500),
                                                //             ),
                                                //           ],
                                                //         ),
                                                //         content: Text(
                                                //             "Do You Want to block this book"),
                                                //         actions: [
                                                //           Row(
                                                //             mainAxisAlignment: MainAxisAlignment.end,
                                                //             children: [
                                                //               InkWell(
                                                //                 onTap: () {
                                                //                   Navigator.pop(context);
                                                //                 },
                                                //                 child: Container(
                                                //                   width:
                                                //                   width * 0.15,
                                                //                   height:
                                                //                   width * 0.08,
                                                //                   decoration:
                                                //                   BoxDecoration(
                                                //                     color:
                                                //                     primarycolor1,
                                                //                     borderRadius:
                                                //                     BorderRadius
                                                //                         .circular(
                                                //                         4),
                                                //                   ),
                                                //                   child: Center(
                                                //                     child: Text(
                                                //                       "No",
                                                //                       style: GoogleFonts.montserrat(
                                                //                           color: Colors
                                                //                               .white,
                                                //                           fontSize:
                                                //                           width *
                                                //                               0.04,
                                                //                           fontWeight:
                                                //                           FontWeight
                                                //                               .w500),
                                                //                     ),
                                                //                   ),
                                                //                 ),
                                                //               ),
                                                //               SizedBox(width: width*0.05,),
                                                //               InkWell(
                                                //                 onTap: () async {
                                                //                   block=true;
                                                //                   await FirebaseFirestore.instance
                                                //                       .collection("shops")
                                                //                       .doc(currentshopId)
                                                //                       .collection("book")
                                                //                       .doc(data.bookId).update(
                                                //                       {
                                                //                         'block':true
                                                //                       });
                                                //                       // .delete();
                                                //                   Navigator.pop(context);
                                                //                 },
                                                //                 child: Container(
                                                //                   width: width *
                                                //                       0.15,
                                                //                   height: width *
                                                //                       0.08,
                                                //                   decoration:
                                                //                   BoxDecoration(
                                                //                     color:
                                                //                     primarycolor1,
                                                //                     borderRadius:
                                                //                     BorderRadius
                                                //                         .circular(
                                                //                         4),
                                                //                   ),
                                                //                   child: Center(
                                                //                     child: Text(
                                                //                       "Yes",
                                                //                       style: GoogleFonts.montserrat(
                                                //                           color: Colors
                                                //                               .white,
                                                //                           fontSize:
                                                //                           width *
                                                //                               0.04,
                                                //                           fontWeight:
                                                //                           FontWeight.w500),
                                                //                     ),
                                                //                   ),
                                                //                 ),
                                                //               ),
                                                //               SizedBox(width: width*0.03,),
                                                //
                                                //             ],
                                                //           )
                                                //         ],
                                                //       ),
                                                //     );
                                                //   },
                                                // );
                                              },
                                              child:
                                              data.block==true? Icon(Icons.block,color: Colors.red,):Container()
                                            // SvgPicture.asset(
                                            //   "assets/icons/delete.svg",
                                            //   height: 17,
                                            //   width: 14,
                                            // ),
                                          ),
                                          SizedBox(
                                            width: width * 0.02,
                                          ),
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
              ],
            ),

          ]),
        )
    );
  }
}
