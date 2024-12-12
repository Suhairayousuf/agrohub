import 'dart:async';

import 'package:agrohub/features/Book/book/controller/book_controller.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:flutter_svg/svg.dart';
import 'package:google_fonts/google_fonts.dart';


import '../../../../Model/bookModel.dart';
import '../../../../core/utils/utils.dart';
import '../../../../main.dart';
import '../../../../themes/color.dart';
import '../../../Home/screen/homePage.dart';
import '../../../Home/screen/selectShop.dart';

import '../../../auth/screen/splash.dart';
import '../../member/screen/AddMembers.dart';

class AddBook extends ConsumerStatefulWidget {
  const AddBook({Key? key}) : super(key: key);

  @override
  ConsumerState<AddBook> createState() => _AddBookState();
}

class _AddBookState extends ConsumerState<AddBook> {
  TextEditingController bookName = TextEditingController();
  TextEditingController creditLimit = TextEditingController();
  List<BookModel> books = [];
  StreamSubscription? a;
  bool loading=true;
  // getBook() {
  //  a= FirebaseFirestore.instance
  //       .collection('shops')
  //       .doc(currentshopId)
  //       .collection('book').where('delete',isEqualTo: false)
  //       .snapshots()
  //       .listen((event) {
  //     books = [];
  //     if (event.docs.isNotEmpty) {
  //       for (var doc in event.docs) {
  //         books.add(BookModel.fromJson(doc.data()));
  //         // books.sort((a, b) => b.bookName!.compareTo(a!.bookName!));
  //         books.sort((a, b) {
  //          return sortBooks(a,b);
  //         });
  //
  //         // customerReward=doc.get('customerReward');
  //       }
  //
  //       // }
  //
  //     }
  //     loading=false;
  //     if (mounted) {
  //       setState(() {});
  //     }
  //   });
  // }
  @override
  void dispose() {
    a?.cancel();
    super.dispose();
  }

  @override
  void initState() {
     // update();
    // getBook();

    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: bgcolor,
      body: Column(
        children: [
          // SizedBox(
          //   height: width * 0.02,
          // ),
          // Center(
          //   child: Text(
          //     'Create Book',
          //     style:  GoogleFonts.poppins(
          //         color: primarycolor2,
          //         fontWeight: FontWeight.w600,
          //         fontSize: width * 0.06),
          //   ),
          // ),
          // SizedBox(
          //   height: width * 0.3,
          // ),
          // Container(
          //   height: width * 0.17,
          //   width: width * 0.9,
          //   decoration: BoxDecoration(
          //     border: Border.all(color: primarycolor1),
          //     borderRadius: BorderRadius.all(
          //       Radius.circular(20),
          //     ),
          //   ),
          //   child: Padding(
          //     padding: const EdgeInsets.only(left: 8.0),
          //     child: TextFormField(
          //       controller: bookName,
          //       decoration: InputDecoration(
          //         border: InputBorder.none,
          //         labelText: 'Book Name',
          //         labelStyle:  GoogleFonts.poppins(color: primarycolor2, fontSize: 20),
          //       ),
          //     ),
          //   ),
          // ),
          // SizedBox(
          //   height: width * 0.15,
          // ),
          // InkWell(
          //   onTap: () {
          //     if( bookName.text!=''){
          //       showDialog(context: context,
          //           builder: (buildcontext)
          //           {
          //             return AlertDialog(
          //               title:  Text('Add Book',style:GoogleFonts.outfit() ,),
          //               content:  Text('Do you want to Add?',style:GoogleFonts.outfit()),
          //               actions: [
          //                 TextButton(onPressed: (){
          //                   Navigator.pop(buildcontext);
          //                 },
          //                     child:  Text('Cancel',style:GoogleFonts.outfit())),
          //                 TextButton(onPressed: (){
          //                   FirebaseFirestore.instance.collection('shops')
          //                       .doc(currentshopId).collection('book').add({
          //                     'bookName':bookName.text,
          //                     'createdDate':DateTime.now(),
          //                     'credit':0.00,
          //                     'members':[],
          //                     'shopId':currentshopId,
          //                     'shopName':currentshopName,
          //
          //
          //                   }).then((value){
          //                     value.update({
          //                       'bookId':value.id,
          //                     });
          //                   });
          //                   showUploadMessage(context, 'Book added succesfully',style: GoogleFonts.outfit());
          //                   Navigator.pop(context);
          //                   Navigator.pop(buildcontext);
          //
          //                   bookName.text='';
          //
          //                   setState(() {
          //
          //                   });
          //
          //
          //                   // Navigator.pushAndRemoveUntil(context, CupertinoPageRoute(builder: (context) => ManagePage(),), (route) => false);
          //                 },
          //                     child: const Text('Yes')),
          //               ],
          //             );
          //
          //           });
          //
          //     }else{
          //       showUploadMessage(context, 'Enter book name', style: GoogleFonts.poppins());
          //     }
          //
          //
          //      // MyBook.clear();
          //     setState(() {
          //
          //     });
          //
          //   },
          //   child: Container(
          //     width: width * 0.5,
          //     height: width * 0.1,
          //     decoration: BoxDecoration(
          //         gradient:
          //             LinearGradient(colors: [primarycolor1, primarycolor2]),
          //         borderRadius: BorderRadius.all(Radius.circular(10))),
          //     child: Center(
          //       child: Text(
          //         'Create Book',
          //         style:
          //             GoogleFonts.poppins(color: Colors.white, fontSize: width * 0.04),
          //       ),
          //     ),
          //   ),
          // ),

          Container(
            width: width,
            height: width * 0.4,
            child: Stack(
              // clipBehavior: Clip.none,
              children: [
                Container(
                  width: width * 1,
                  height: width * 0.4,
                  decoration: BoxDecoration(
                    image: DecorationImage(
                        image: AssetImage("assets/appBar.png"),
                        fit: BoxFit.cover),
                  ),
                  child: Row(
                    children: [
                      SizedBox(
                        width: width * 0.07,
                      ),
                      IconButton(
                          onPressed: () => Navigator.pop(context),
                          icon: Icon(
                            Icons.arrow_back_ios,
                            color: Colors.white,
                          )),
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
                      mainAxisAlignment: MainAxisAlignment.spaceAround,
                      children: [
                        Text(
                          'Books',
                          style: GoogleFonts.montserrat(
                              fontSize: 20,
                              color: primarycolor1,
                              fontWeight: FontWeight.w600),
                        ),
                        SizedBox(
                          width: 10,
                        ),
                        SizedBox(
                          child: InkWell(
                            onTap: () {

                              showDialog(
                                context: context,
                                builder: (BuildContext context) {
                                  bookName.text="";
                                  creditLimit.text="";
                                  return Container(
                                    width: width,
                                    child: AlertDialog(
                                      title: Row(
                                        mainAxisAlignment:
                                            MainAxisAlignment.center,
                                        children: [
                                          Text(
                                            "create a book",
                                            style: GoogleFonts.montserrat(
                                                fontSize: 20,
                                                color: primarycolor1,
                                                fontWeight: FontWeight.w500),
                                          ),
                                        ],
                                      ),
                                      content: Container(
                                        width: width,
                                        height: width * 0.4,
                                        decoration: BoxDecoration(
                                          borderRadius:
                                              BorderRadius.circular(15),
                                        ),
                                        child: Column(
                                          mainAxisAlignment:
                                              MainAxisAlignment.spaceEvenly,
                                          children: [
                                            Container(
                                              width: width * 0.9,
                                              height: width * 0.13,
                                              decoration: BoxDecoration(
                                                border: Border.all(
                                                    color: primarycolor1),
                                                borderRadius:
                                                    BorderRadius.circular(10),
                                              ),
                                              child: TextFormField(

                                                controller: bookName,
                                                keyboardType:
                                                    TextInputType.number,
                                                decoration: InputDecoration(
                                                  contentPadding: EdgeInsets.only(left: 10),

                                                  hintText: 'Book name',
                                                  hintStyle: GoogleFonts.poppins(color: primarycolor1,fontSize: 12),
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
                                            SizedBox(height: 7,),
                                            Container(
                                              width: width * 0.9,
                                              height: width * 0.13,
                                              decoration: BoxDecoration(
                                                border: Border.all(
                                                    color: primarycolor1),
                                                borderRadius:
                                                    BorderRadius.circular(10),
                                              ),
                                              child: TextFormField(

                                                controller: creditLimit,
                                                keyboardType:
                                                    TextInputType.number,
                                                decoration: InputDecoration(
                                                  contentPadding: EdgeInsets.only(left: 10),

                                                  hintText: 'Enter Credit Limit',
                                                  hintStyle: GoogleFonts.poppins(color: primarycolor1,fontSize: 12),
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
                                            InkWell(
                                              onTap: () async {
                                                if (bookName.text != '' && creditLimit.text != '') {
                                                  Navigator.pop(context);
                                                 QuerySnapshot items=await FirebaseFirestore.instance.collection('shops').
                                                  doc(currentshopId).collection('book').where('bookName',isEqualTo:bookName.text )
                                                      .where('delete',isEqualTo: false).get();

                                                  if(items.docs.length!=0){
                                                    showUploadMessage1(context,
                                                        'This book name is already exist\nPlease choose another name',
                                                        style: GoogleFonts
                                                            .montserrat());
                                                  }else{
                                                    final bookDetailes = BookModel(
                                                        bookName: bookName.text,
                                                        createdDate: DateTime.now(),
                                                        credit: 0.00,
                                                        members: [],
                                                        shopId: currentshopId,
                                                        shopName: currentshopName,
                                                        update:DateTime.now(),
                                                        block:false,
                                                        creditLimit:double.tryParse(creditLimit.text.toString()),
                                                      delete:false
                                                        );
                                                    await addBook(context, bookDetailes);
                                                    // await createBook(bookDetailes);

                                                    // await FirebaseFirestore
                                                    //     .instance
                                                    //     .collection('shops')
                                                    //     .doc(currentshopId)
                                                    //     .collection('book')
                                                    //     .add({
                                                    //   'bookName': bookName.text,
                                                    //   'createdDate': DateTime.now(),
                                                    //   'credit': 0.00,
                                                    //   'members': [],
                                                    //   'shopId': currentshopId,
                                                    //   'shopName': currentshopName,
                                                    //   'update':DateTime.now(),
                                                    //   'block':false
                                                    // }).then((value) {
                                                    //   value.update({
                                                    //     'bookId': value.id,
                                                    //   });
                                                    // });

                                                    bookName.text="";
                                                    creditLimit.text="";
                                                  }


                                                } else {
                                                  showUploadMessage1(context,
                                                      'Please Enter Book Name',
                                                      style: GoogleFonts
                                                          .montserrat());
                                                }
                                              },
                                              child: Container(
                                                height: width * 0.1,
                                                width: width * 0.3,
                                                decoration: BoxDecoration(
                                                  color: primarycolor1,
                                                  borderRadius:
                                                      BorderRadius.circular(
                                                          6),
                                                ),
                                                child: Center(
                                                  child: Text(
                                                    "create",
                                                    style:
                                                        GoogleFonts.montserrat(
                                                      fontSize: 20,
                                                      color: Colors.white,
                                                      fontWeight:
                                                          FontWeight.w400,
                                                    ),
                                                  ),
                                                ),
                                              ),
                                            ),
                                          ],
                                        ),
                                      ),
                                    ),
                                  );
                                },
                              );
                            },
                            child: Row(
                              children: [
                                Icon(
                                  Icons.add_circle_outline,
                                  color: primarycolor1,
                                ),
                                SizedBox(
                                  width: 5,
                                ),
                                Text(
                                  'add new book',
                                  style: GoogleFonts.montserrat(
                                      fontSize: 20, color: primarycolor1),
                                ),
                              ],
                            ),
                          ),
                        ),
                      ],
                    ),
                  ),
                ),
              ],
            ),
          ),

          SizedBox(
            height: width * 0.02,
          ),
          // loading?Expanded(child: Center(child: SingleChildScrollView())):
          // books.isNotEmpty
          //     ? Expanded(
          //       child: ListView.builder(
          //         physics: BouncingScrollPhysics(),
          //         shrinkWrap: true,
          //         itemCount: books.length,
          //         itemBuilder: (context, index) {
          //           BookModel book = books[index];
          //
          //           return Padding(
          //             padding: const EdgeInsets.all(8.0),
          //             child: InkWell(
          //               onTap: () {
          //                 Navigator.push(
          //                   context,
          //                   MaterialPageRoute(
          //                     builder: (context) => AddMembersPage(
          //                       bookData: book,
          //                     ),
          //                   ),
          //                 );
          //               },
          //               child: Card(
          //                 child: Container(
          //                   width: width * 0.5,
          //                   height: width * 0.15,
          //                   decoration: BoxDecoration(
          //                       color: Colors.white,
          //                       borderRadius:
          //                           BorderRadius.all(Radius.circular(5))),
          //                   child: Row(
          //                     mainAxisAlignment:
          //                         MainAxisAlignment.spaceBetween,
          //                     children: [
          //                       SizedBox(
          //                         child: Row(
          //                           children: [
          //                             SizedBox(
          //                               width: 30,
          //                             ),
          //                             Text(
          //                               book.bookName.toString(),
          //                               style: GoogleFonts.montserrat(
          //                                 fontSize: width * 0.06,
          //                                 color: Colors.black,
          //                                 fontWeight: FontWeight.w700,
          //                               ),
          //                             ),
          //                           ],
          //                         ),
          //                       ),
          //                       SizedBox(
          //                         child: Row(
          //                           children: [
          //                             InkWell(
          //                               // onTap: () async {
          //
          //                               // },
          //                               onTap: () {
          //                                 showDialog(
          //                                   context: context,
          //                                   builder:
          //                                       (BuildContext context) {
          //                                     return SizedBox(
          //                                       width: width,
          //                                       child: AlertDialog(
          //                                         title: Row(
          //                                           mainAxisAlignment:
          //                                               MainAxisAlignment
          //                                                   .center,
          //                                           children: [
          //                                             Text(
          //                                               "Are you sure",
          //                                               style: GoogleFonts.montserrat(
          //                                                   fontSize: 20,
          //                                                   color:
          //                                                       primarycolor1,
          //                                                   fontWeight:
          //                                                       FontWeight
          //                                                           .w500),
          //                                             ),
          //                                           ],
          //                                         ),
          //                                         content: Text(
          //                                             "Do You Want Delete the Book"),
          //                                         actions: [
          //                                           Row(
          //                                             mainAxisAlignment: MainAxisAlignment.end,
          //                                             children: [
          //                                               InkWell(
          //                                               onTap: () {
          //                                                 Navigator.pop(context);
          //                                               },
          //                                               child: Container(
          //                                                 width:
          //                                                 width * 0.15,
          //                                                 height:
          //                                                 width * 0.08,
          //                                                 decoration:
          //                                                 BoxDecoration(
          //                                                   color:
          //                                                   primarycolor1,
          //                                                   borderRadius:
          //                                                   BorderRadius
          //                                                       .circular(
          //                                                       4),
          //                                                 ),
          //                                                 child: Center(
          //                                                   child: Text(
          //                                                     "No",
          //                                                     style: GoogleFonts.montserrat(
          //                                                         color: Colors
          //                                                             .white,
          //                                                         fontSize:
          //                                                         width *
          //                                                             0.04,
          //                                                         fontWeight:
          //                                                         FontWeight
          //                                                             .w500),
          //                                                   ),
          //                                                 ),
          //                                               ),
          //                                             ),
          //                                               SizedBox(width: width*0.05,),
          //                                               InkWell(
          //                                                 onTap: () async {
          //                                                   bool disabled=false;
          //
          //                                                   if(!disabled){
          //                                                     disabled=true;
          //                                                     final bookData = book.copyWith(
          //                                                         delete:true,
          //
          //                                                     );
          //                                                     // updateBook(context,bookData);
          //                                                     deleteBook(context,bookData);
          //
          //
          //
          //
          //                                          // await FirebaseFirestore.instance.collection("shops").doc(currentshopId)
          //                                          //     .collection("book").doc(book.bookId).update({
          //                                          //                    'delete': true
          //                                          //                  });
          //
          //                                                           await FirebaseFirestore
          //                                                               .instance
          //                                                               .collectionGroup(
          //                                                                   'purchase')
          //                                                               .where(
          //                                                                   'bookId',
          //                                                                   isEqualTo: book
          //                                                                       .bookId)
          //                                                               .get()
          //                                                               .then(
          //                                                                   (event) {
          //                                                             for (var doc
          //                                                                 in event
          //                                                                     .docs) {
          //                                                               FirebaseFirestore
          //                                                                   .instance
          //                                                                   .collection(
          //                                                                       'users')
          //                                                                   .doc(doc.get(
          //                                                                       'customerId'))
          //                                                                   .collection(
          //                                                                       'purchase')
          //                                                                   .doc(doc
          //                                                                       .id)
          //                                                                   .update({
          //                                                                 'delete':
          //                                                                     true
          //                                                               });
          //                                                               setState(
          //                                                                   () {});
          //                                                             }
          //                                                           });
          //
          //                                                           await FirebaseFirestore
          //                                                               .instance
          //                                                               .collectionGroup(
          //                                                                   'transactions')
          //                                                               .where(
          //                                                                   'bookId',
          //                                                                   isEqualTo: book
          //                                                                       .bookId)
          //                                                               .get()
          //                                                               .then(
          //                                                                   (event) async {
          //                                                             for (var doc
          //                                                                 in event
          //                                                                     .docs) {
          //                                                               FirebaseFirestore
          //                                                                   .instance
          //                                                                   .collection(
          //                                                                       'users')
          //                                                                   .doc(doc.get(
          //                                                                       'customerId'))
          //                                                                   .collection(
          //                                                                       'transactions')
          //                                                                   .doc(doc
          //                                                                       .id)
          //                                                                   .update({
          //                                                                 'delete':
          //                                                                     true
          //                                                               });
          //                                                             }
          //
          //                                                             setState(
          //                                                                 () {});
          //                                                           });
          //
          //                                                           setState(
          //                                                               () {});
          //                                                           // .delete();
          //                                                           Navigator.pop(
          //                                                               context);
          //                                                           disabled=false;
          //                                                         }
          //                                                       },
          //                                                 child: Container(
          //                                                   width: width *
          //                                                       0.15,
          //                                                   height: width *
          //                                                       0.08,
          //                                                   decoration:
          //                                                       BoxDecoration(
          //                                                     color:
          //                                                         primarycolor1,
          //                                                     borderRadius:
          //                                                         BorderRadius
          //                                                             .circular(
          //                                                                 4),
          //                                                   ),
          //                                                   child: Center(
          //                                                     child: Text(
          //                                                       "Yes",
          //                                                       style: GoogleFonts.montserrat(
          //                                                           color: Colors
          //                                                               .white,
          //                                                           fontSize:
          //                                                               width *
          //                                                                   0.04,
          //                                                           fontWeight:
          //                                                               FontWeight.w500),
          //                                                     ),
          //                                                   ),
          //                                                 ),
          //                                               ),
          //                                               SizedBox(width: width*0.03,),
          //                                             ],
          //                                           )
          //                                         ],
          //                                       ),
          //                                     );
          //                                   },
          //                                 );
          //                               },
          //
          //                               child: SvgPicture.asset(
          //                                   "assets/icons/delete.svg",
          //                                   width: width * 0.05),
          //                             ),
          //                             SizedBox(
          //                               width: 25,
          //                             ),
          //                             InkWell(
          //                               onTap: () {
          //                                 bookName.text=book.bookName!;
          //                                 creditLimit.text=book.creditLimit.toString()!;
          //                                 showDialog(
          //                                   context: context,
          //                                   builder:
          //                                       (BuildContext context) {
          //                                     return SizedBox(
          //                                       width: width,
          //                                       child: AlertDialog(
          //                                         title: Row(
          //                                           mainAxisAlignment:
          //                                               MainAxisAlignment
          //                                                   .center,
          //                                           children: [
          //                                             Text(
          //                                               "Edit book name",
          //                                               style: GoogleFonts.montserrat(
          //                                                   fontSize: 20,
          //                                                   color:
          //                                                       primarycolor1,
          //                                                   fontWeight:
          //                                                       FontWeight
          //                                                           .w500),
          //                                             ),
          //                                           ],
          //                                         ),
          //                                         content: Container(
          //                                           width: width,
          //                                           height: width * 0.4,
          //                                           decoration:
          //                                               BoxDecoration(
          //                                             borderRadius:
          //                                                 BorderRadius
          //                                                     .circular(15),
          //                                           ),
          //                                           child: Column(
          //                                             mainAxisAlignment:
          //                                                 MainAxisAlignment
          //                                                     .spaceEvenly,
          //                                             children: [
          //                                               Container(
          //                                                 width:
          //                                                     width * 0.9,
          //                                                 height:
          //                                                     width * 0.13,
          //                                                 decoration:
          //                                                     BoxDecoration(
          //                                                   border: Border.all(
          //                                                       color:
          //                                                           primarycolor1),
          //                                                   borderRadius:
          //                                                       BorderRadius
          //                                                           .circular(
          //                                                               10),
          //                                                 ),
          //                                                 child:
          //                                                     TextFormField(
          //                                                   controller:
          //                                                       bookName,
          //                                                   keyboardType:
          //                                                       TextInputType
          //                                                           .number,
          //                                                   decoration:
          //                                                       InputDecoration(
          //                                                         contentPadding: EdgeInsets.only(left: 10),
          //                                                         labelText: "Book Name",
          //                                                         disabledBorder:
          //                                                         InputBorder
          //                                                             .none,
          //                                                     enabledBorder:
          //                                                         InputBorder
          //                                                             .none,
          //                                                     errorBorder:
          //                                                         InputBorder
          //                                                             .none,
          //                                                     border:
          //                                                         InputBorder
          //                                                             .none,
          //                                                     focusedBorder:
          //                                                         UnderlineInputBorder(
          //                                                       borderRadius:
          //                                                           BorderRadius.circular(
          //                                                               15),
          //                                                       borderSide:
          //                                                           const BorderSide(
          //                                                         color: Colors
          //                                                             .white,
          //                                                         width: 2,
          //                                                       ),
          //                                                     ),
          //                                                   ),
          //                                                 ),
          //                                               ),
          //                                               SizedBox(height: 7,),
          //                                               Container(
          //                                                 width: width * 0.9,
          //                                                 height: width * 0.13,
          //                                                 decoration: BoxDecoration(
          //                                                   border: Border.all(
          //                                                       color: primarycolor1),
          //                                                   borderRadius:
          //                                                   BorderRadius.circular(10),
          //                                                 ),
          //                                                 child: TextFormField(
          //
          //                                                   controller: creditLimit,
          //                                                   keyboardType:
          //                                                   TextInputType.number,
          //                                                   decoration: InputDecoration(
          //                                                     contentPadding: EdgeInsets.only(left: 10),
          //                                                     hintText: 'Enter Credit Limit',
          //                                                     hintStyle: GoogleFonts.poppins(color: primarycolor1,fontSize: 15),
          //                                                     labelText: "Credit Limit",
          //                                                     disabledBorder:
          //                                                     InputBorder.none,
          //                                                     enabledBorder:
          //                                                     InputBorder.none,
          //                                                     errorBorder:
          //                                                     InputBorder.none,
          //                                                     border: InputBorder.none,
          //                                                     focusedBorder:
          //                                                     UnderlineInputBorder(
          //                                                       borderRadius:
          //                                                       BorderRadius.circular(
          //                                                           15),
          //                                                       borderSide:
          //                                                       const BorderSide(
          //                                                         color: Colors.white,
          //                                                         width: 2,
          //                                                       ),
          //                                                     ),
          //                                                   ),
          //                                                 ),
          //                                               ),
          //                                               InkWell(
          //                                                 onTap: () async {
          //                                                   if (bookName.text != ''&&creditLimit.text != '') {
          //                                                     final bookData = book.copyWith(
          //                                                       bookName: bookName.text,
          //                                                       creditLimit: double.tryParse(creditLimit.text,),
          //                                                       bookId: book.bookId
          //                                                     );
          //                                                     updateBook(context,bookData);
          //                                                     // await FirebaseFirestore
          //                                                     //     .instance
          //                                                     //     .collection(
          //                                                     //         'shops')
          //                                                     //     .doc(
          //                                                     //         currentshopId)
          //                                                     //     .collection(
          //                                                     //         'book')
          //                                                     //     .doc(book
          //                                                     //         .bookId)
          //                                                     //     .update({
          //                                                     //   "bookName": bookName.text,
          //                                                     //   "creditLimit": double.tryParse(creditLimit.text,)
          //                                                     // }).then((value) {
          //                                                     //   bookName
          //                                                     //       .clear();
          //                                                     // });
          //                                                     bookName.clear();
          //                                                     creditLimit.clear();
          //                                                     showUploadMessage1(
          //                                                         context,
          //                                                         'Edited succesfully',
          //                                                         style: GoogleFonts
          //                                                             .montserrat());
          //                                                     // bookName.clear();
          //                                                     Navigator.pop(
          //                                                         context);
          //                                                   } else {
          //                                                     showUploadMessage1(
          //                                                         context,
          //                                                         'Please Enter Book Name',
          //                                                         style: GoogleFonts
          //                                                             .montserrat());
          //                                                   }
          //                                                 },
          //                                                 child: Container(
          //                                                   height:
          //                                                       width * 0.1,
          //                                                   width:
          //                                                       width * 0.3,
          //                                                   decoration:
          //                                                       BoxDecoration(
          //                                                     color:
          //                                                         primarycolor1,
          //                                                     borderRadius:
          //                                                         BorderRadius
          //                                                             .circular(
          //                                                                 6),
          //                                                   ),
          //                                                   child: Center(
          //                                                     child: Text(
          //                                                       "Edit",
          //                                                       style: GoogleFonts
          //                                                           .montserrat(
          //                                                         fontSize:
          //                                                             20,
          //                                                         color: Colors
          //                                                             .white,
          //                                                         fontWeight:
          //                                                             FontWeight
          //                                                                 .w400,
          //                                                       ),
          //                                                     ),
          //                                                   ),
          //                                                 ),
          //                                               ),
          //                                             ],
          //                                           ),
          //                                         ),
          //                                       ),
          //                                     );
          //                                   },
          //                                 );
          //                               },
          //                               child: SvgPicture.asset(
          //                                   "assets/icons/edit.svg",
          //                                   width: width * 0.05),
          //                             ),
          //                             SizedBox(
          //                               width: 30,
          //                             ),
          //                           ],
          //                         ),
          //                       ),
          //                     ],
          //                   ),
          //                 ),
          //               ),
          //             ),
          //           );
          //         },
          //       ),
          //     )
          //     : Container(
          //     height:width,
          //   child: Center(child: Text('No books added',style: GoogleFonts.montserrat(color: primarycolor1),)))
          Consumer(
            builder: (context,ref,child) {
              final bookData=ref.watch(getBooksProvider);
              return bookData.when(data: (data) {
                data.sort((a, b) {
                   return sortBooks(a,b);
                  });
                return  Expanded(
                  child: ListView.builder(
                    physics: BouncingScrollPhysics(),
                    shrinkWrap: true,
                    itemCount: data.length,
                    itemBuilder: (context, index) {
                      BookModel book = data[index];

                      return Padding(
                        padding: const EdgeInsets.all(8.0),
                        child: InkWell(
                          onTap: () {
                            Navigator.push(
                              context,
                              MaterialPageRoute(
                                builder: (context) => AddMembersPage(
                                  bookData: book,
                                ),
                              ),
                            );
                          },
                          child: Card(
                            child: Container(
                              width: width * 0.5,
                              height: width * 0.15,
                              decoration: BoxDecoration(
                                  color: Colors.white,
                                  borderRadius:
                                  BorderRadius.all(Radius.circular(5))),
                              child: Row(
                                mainAxisAlignment:
                                MainAxisAlignment.spaceBetween,
                                children: [
                                  SizedBox(
                                    child: Row(
                                      children: [
                                        SizedBox(
                                          width: 30,
                                        ),
                                        Text(
                                          book.bookName.toString(),
                                          style: GoogleFonts.montserrat(
                                            fontSize: width * 0.06,
                                            color: Colors.black,
                                            fontWeight: FontWeight.w700,
                                          ),
                                        ),
                                      ],
                                    ),
                                  ),
                                  SizedBox(
                                    child: Row(
                                      children: [
                                        InkWell(
                                          // onTap: () async {

                                          // },
                                          onTap: () {
                                            showDialog(
                                              context: context,
                                              builder:
                                                  (BuildContext context) {
                                                return SizedBox(
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
                                                        "Do You Want Delete the Book"),
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
                                                              bool disabled=false;

                                                              if(!disabled){
                                                                disabled=true;
                                                                final bookData = book.copyWith(
                                                                  delete:true,

                                                                );
                                                                // updateBook(context,bookData);
                                                                deleteBook(context,bookData);




                                                                // await FirebaseFirestore.instance.collection("shops").doc(currentshopId)
                                                                //     .collection("book").doc(book.bookId).update({
                                                                //                    'delete': true
                                                                //                  });

                                                                await FirebaseFirestore
                                                                    .instance
                                                                    .collectionGroup(
                                                                    'purchase')
                                                                    .where(
                                                                    'bookId',
                                                                    isEqualTo: book
                                                                        .bookId)
                                                                    .get()
                                                                    .then(
                                                                        (event) {
                                                                      for (var doc
                                                                      in event
                                                                          .docs) {
                                                                        FirebaseFirestore
                                                                            .instance
                                                                            .collection(
                                                                            'users')
                                                                            .doc(doc.get(
                                                                            'customerId'))
                                                                            .collection(
                                                                            'purchase')
                                                                            .doc(doc
                                                                            .id)
                                                                            .update({
                                                                          'delete':
                                                                          true
                                                                        });
                                                                        setState(
                                                                                () {});
                                                                      }
                                                                    });

                                                                await FirebaseFirestore
                                                                    .instance
                                                                    .collectionGroup(
                                                                    'transactions')
                                                                    .where(
                                                                    'bookId',
                                                                    isEqualTo: book
                                                                        .bookId)
                                                                    .get()
                                                                    .then(
                                                                        (event) async {
                                                                      for (var doc
                                                                      in event
                                                                          .docs) {
                                                                        FirebaseFirestore
                                                                            .instance
                                                                            .collection(
                                                                            'users')
                                                                            .doc(doc.get(
                                                                            'customerId'))
                                                                            .collection(
                                                                            'transactions')
                                                                            .doc(doc
                                                                            .id)
                                                                            .update({
                                                                          'delete':
                                                                          true
                                                                        });
                                                                      }

                                                                      setState(
                                                                              () {});
                                                                    });

                                                                setState(
                                                                        () {});
                                                                // .delete();
                                                                Navigator.pop(
                                                                    context);
                                                                disabled=false;
                                                              }
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

                                          child: SvgPicture.asset(
                                              "assets/icons/delete.svg",
                                              width: width * 0.05),
                                        ),
                                        SizedBox(
                                          width: 25,
                                        ),
                                        InkWell(
                                          onTap: () {
                                            bookName.text=book.bookName!;
                                            creditLimit.text=book.creditLimit.toString()!;
                                            showDialog(
                                              context: context,
                                              builder:
                                                  (BuildContext context) {
                                                return SizedBox(
                                                  width: width,
                                                  child: AlertDialog(
                                                    title: Row(
                                                      mainAxisAlignment:
                                                      MainAxisAlignment
                                                          .center,
                                                      children: [
                                                        Text(
                                                          "Edit book name",
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
                                                    content: Container(
                                                      width: width,
                                                      height: width * 0.4,
                                                      decoration:
                                                      BoxDecoration(
                                                        borderRadius:
                                                        BorderRadius
                                                            .circular(15),
                                                      ),
                                                      child: Column(
                                                        mainAxisAlignment:
                                                        MainAxisAlignment
                                                            .spaceEvenly,
                                                        children: [
                                                          Container(
                                                            width:
                                                            width * 0.9,
                                                            height:
                                                            width * 0.13,
                                                            decoration:
                                                            BoxDecoration(
                                                              border: Border.all(
                                                                  color:
                                                                  primarycolor1),
                                                              borderRadius:
                                                              BorderRadius
                                                                  .circular(
                                                                  10),
                                                            ),
                                                            child:
                                                            TextFormField(
                                                              controller:
                                                              bookName,
                                                              keyboardType:
                                                              TextInputType
                                                                  .number,
                                                              decoration:
                                                              InputDecoration(
                                                                contentPadding: EdgeInsets.only(left: 10),
                                                                labelText: "Book Name",
                                                                disabledBorder:
                                                                InputBorder
                                                                    .none,
                                                                enabledBorder:
                                                                InputBorder
                                                                    .none,
                                                                errorBorder:
                                                                InputBorder
                                                                    .none,
                                                                border:
                                                                InputBorder
                                                                    .none,
                                                                focusedBorder:
                                                                UnderlineInputBorder(
                                                                  borderRadius:
                                                                  BorderRadius.circular(
                                                                      15),
                                                                  borderSide:
                                                                  const BorderSide(
                                                                    color: Colors
                                                                        .white,
                                                                    width: 2,
                                                                  ),
                                                                ),
                                                              ),
                                                            ),
                                                          ),
                                                          SizedBox(height: 7,),
                                                          Container(
                                                            width: width * 0.9,
                                                            height: width * 0.13,
                                                            decoration: BoxDecoration(
                                                              border: Border.all(
                                                                  color: primarycolor1),
                                                              borderRadius:
                                                              BorderRadius.circular(10),
                                                            ),
                                                            child: TextFormField(

                                                              controller: creditLimit,
                                                              keyboardType:
                                                              TextInputType.number,
                                                              decoration: InputDecoration(
                                                                contentPadding: EdgeInsets.only(left: 10),
                                                                hintText: 'Enter Credit Limit',
                                                                hintStyle: GoogleFonts.poppins(color: primarycolor1,fontSize: 15),
                                                                labelText: "Credit Limit",
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
                                                          InkWell(
                                                            onTap: () async {
                                                              if (bookName.text != ''&&creditLimit.text != '') {
                                                                final bookData = book.copyWith(
                                                                    bookName: bookName.text,
                                                                    creditLimit: double.tryParse(creditLimit.text,),
                                                                    bookId: book.bookId
                                                                );
                                                                updateBook(context,bookData);
                                                                // await FirebaseFirestore
                                                                //     .instance
                                                                //     .collection(
                                                                //         'shops')
                                                                //     .doc(
                                                                //         currentshopId)
                                                                //     .collection(
                                                                //         'book')
                                                                //     .doc(book
                                                                //         .bookId)
                                                                //     .update({
                                                                //   "bookName": bookName.text,
                                                                //   "creditLimit": double.tryParse(creditLimit.text,)
                                                                // }).then((value) {
                                                                //   bookName
                                                                //       .clear();
                                                                // });
                                                                bookName.clear();
                                                                creditLimit.clear();
                                                                showUploadMessage1(
                                                                    context,
                                                                    'Edited succesfully',
                                                                    style: GoogleFonts
                                                                        .montserrat());
                                                                // bookName.clear();
                                                                Navigator.pop(
                                                                    context);
                                                              } else {
                                                                showUploadMessage1(
                                                                    context,
                                                                    'Please Enter Book Name',
                                                                    style: GoogleFonts
                                                                        .montserrat());
                                                              }
                                                            },
                                                            child: Container(
                                                              height:
                                                              width * 0.1,
                                                              width:
                                                              width * 0.3,
                                                              decoration:
                                                              BoxDecoration(
                                                                color:
                                                                primarycolor1,
                                                                borderRadius:
                                                                BorderRadius
                                                                    .circular(
                                                                    6),
                                                              ),
                                                              child: Center(
                                                                child: Text(
                                                                  "Edit",
                                                                  style: GoogleFonts
                                                                      .montserrat(
                                                                    fontSize:
                                                                    20,
                                                                    color: Colors
                                                                        .white,
                                                                    fontWeight:
                                                                    FontWeight
                                                                        .w400,
                                                                  ),
                                                                ),
                                                              ),
                                                            ),
                                                          ),
                                                        ],
                                                      ),
                                                    ),
                                                  ),
                                                );
                                              },
                                            );
                                          },
                                          child: SvgPicture.asset(
                                              "assets/icons/edit.svg",
                                              width: width * 0.05),
                                        ),
                                        SizedBox(
                                          width: 30,
                                        ),
                                      ],
                                    ),
                                  ),
                                ],
                              ),
                            ),
                          ),
                        ),
                      );
                    },
                  ),
                );
              }, error: (error, stackTrace) => Center(child: Text(error.toString()),),
                  loading: () => CircularProgressIndicator(),);
            }
          )
        ],
      ),
    );
  }
  // createBook( BookModel bookDetailes)  {
  //   try{
  //     String id = "";
  //     FirebaseFirestore.instance
  //         .collection('shops')
  //         .doc(currentshopId)
  //         .collection('book')
  //         .add(bookDetailes.toJson())
  //         .then((value) {
  //       id = value.id;
  //       value.update({
  //         'bookId': value.id,
  //       });
  //       Navigator.pushReplacement(
  //           context,
  //           MaterialPageRoute(
  //               builder: (context) =>
  //                   AddMembersPage(bookData: bookDetailes.copyWith(bookId: value.id))));
  //     });
  //     showUploadMessage(context, 'Book added successfully',
  //         style: GoogleFonts.montserrat());
  //
  //     // Navigator.pop(context);
  //
  //   }catch(e){
  //     showUploadMessage(context, e.toString(),
  //         style: GoogleFonts.montserrat());
  //   }
  // }
  addBook(BuildContext context,BookModel bookData){
    ref.read(bookControllerProvider.notifier).addBook(context: context,bookModel: bookData);

  }
  updateBook(BuildContext context,BookModel bookData){
    ref.read(bookControllerProvider.notifier).updateBook(context: context,bookModel: bookData);

  }
  deleteBook(BuildContext context,BookModel bookData){
    ref.read(bookControllerProvider.notifier).
    deleteBook(context: context,bookModel: bookData);

  }
}
