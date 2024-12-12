import 'dart:async';
import 'dart:developer';

import 'package:agrohub/features/Book/book/screen/single_book_detailes.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:intl/intl.dart';


import '../../../../Model/TransactionModel/transactionModel.dart';
import '../../../../Model/bookModel.dart';
import '../../../../Model/purchase/purchaseModel.dart';
import '../../../../core/utils/utils.dart';
import '../../../../themes/color.dart';
import '../../../Home/screen/homePage.dart';
import '../../../Home/screen/selectShop.dart';

import '../../../auth/screen/splash.dart';
import 'company_report.dart';


class SearchBookPage extends StatefulWidget {
  const SearchBookPage({Key? key}) : super(key: key);

  @override
  State<SearchBookPage> createState() => _SearchBookPageState();
}

class _SearchBookPageState extends State<SearchBookPage> {
  // List<BookModel> bookList=[];
  String? text = '';

  BookModel? bookMap;

  TextInputType searchInput = TextInputType.number;

  List<TransactionModel> allTransaction=[];
  List<PurchaseModel> allPurchase=[];
  List statement=[];
  List<BookModel> books=[];
  StreamSubscription? a;
  StreamSubscription? b;
  getTransaction(){
    DateTime today = DateTime.now();
    DateTime startOfToday = DateTime(today.year, today.month, today.day,0,0,0,0,0);

    FirebaseFirestore.instance.collectionGroup('transactions')
        .where('shopId',isEqualTo: currentshopId).where('delete',isEqualTo: false)
        .where('date', isGreaterThanOrEqualTo: startOfToday).
         orderBy('date',descending: true)
        .get()
        .then((event) {
      allTransaction =[];
      statement=[];
      for(DocumentSnapshot <Map<String,dynamic>> doc in event.docs){
        allTransaction.add(TransactionModel.fromJson(doc.data()!));
      }

      statement.addAll(allPurchase);
      statement.addAll(allTransaction);

      statement.sort((b, a) => a.date.compareTo(b.date));
      if(mounted){
        setState(() {

        });
      }

    });

   FirebaseFirestore.instance.collectionGroup('purchase')
        .where('shopId',isEqualTo: currentshopId).where('delete',isEqualTo: false)
       .where('date', isGreaterThanOrEqualTo: startOfToday)
       .orderBy('date',descending: true)
        .get()
        .then((event) {
      allPurchase=[];

      for(DocumentSnapshot <Map<String,dynamic>> doc in event.docs){
        allPurchase.add(PurchaseModel.fromJson(doc.data()!));
      }
      statement=[];
      statement.addAll(allPurchase);
      statement.addAll(allTransaction);

      statement.sort((b, a) => a.date.compareTo(b.date));


      if(mounted){
        setState(() {


        });
      }

    });


    // statement.followedBy(allTransaction);


  }
  List searchList=[];

  // getSearchedData(String str){
  //   searchList=[];
  //   for(var searchItem in bookList){
  //     if(searchItem.bookName!.toLowerCase().contains(str.toLowerCase()) )
  //     {
  //       searchList.add(searchItem);
  //     }
  //   }
  //   setState(() {
  //
  //   });
  // }

  TextEditingController search = TextEditingController();
  @override
  void initState() {
    getTransaction();
    // getBooks();
    super.initState();
  }
   @override
  void dispose() {
    // a?.cancel();
    super.dispose();
  }
  FocusNode focusNode = FocusNode();
  @override
  Widget build(BuildContext context) {

    log(searchInput.toString());
    log(searchInput.index.toString());

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
        actions: [IconButton(onPressed: (){
          Navigator.push(context, MaterialPageRoute(builder: (context)=>SearchCompanyBook(appBarText: 'Company Report', isFromList: false,)));
        }, icon: Icon(Icons.apartment_outlined))],
        backgroundColor: primarycolor1,
      ),
      body:  SingleChildScrollView(
        child: Column(
            children: [
              Padding(
                padding: const EdgeInsets.only(left: 18.0,right: 10,top: 8),
                child: Container(
                  width: width * 0.9,

                  decoration: BoxDecoration(
                    border: Border.all(
                        color: primarycolor1),
                    borderRadius:
                    BorderRadius.circular(10),
                  ),
                  child: TextFormField(
                    focusNode: focusNode,
                    autofocus: true,
                      keyboardType: searchInput,
                      // inputFormatters: [FilteringTextInputFormatter.digitsOnly],
                    onFieldSubmitted: (text) async {
                      // if(text.substring(text.length-1,text.length)=='-'){
                        BookModel? data;
                        await FirebaseFirestore.instance.collection('shops')
                            .doc(currentshopId).collection('book').where('delete',isEqualTo: false).
                        where('bookName',isEqualTo: text.replaceAll('-', '')).get().then((event) {
                          if(event.docs.isNotEmpty){
                            data=BookModel.fromJson(event.docs[0].data());
                          }

                          if(mounted){
                            setState(() {

                            });
                          }


                        });
                        if(data!=null) {
                          if (text != '' && data!.block == false) {
                            Navigator.push(
                                context, MaterialPageRoute(builder: (context) =>
                                SingleBookDetailesPage(
                                  bookData: data!,
                                ))).then((value){
                              getTransaction();
                              if(mounted) {
                                setState(() {

                                });
                              }
                            });
                            search.text='';





                          } else {
                            text == '' ?
                            showUploadMessage1(context, 'Enter your book number ',
                                style: GoogleFonts.montserrat()) :
                            showUploadMessage1(context,
                                'This Book is blocked by irregular transaction',
                                style: GoogleFonts.montserrat(
                                    color: primarycolor2
                                ));
                          }
                        }else{
                          showUploadMessage1(context, 'book does not exist', style: GoogleFonts.montserrat());

                        }
                      // }
                    },

                    onChanged: (text) async {
                      if(text[text.length-1]=='-'){
                        await FirebaseFirestore.instance.collection('shops')
                            .doc(currentshopId).collection('book').where('delete',isEqualTo: false).
                        where('search',arrayContains: (text.replaceAll('-', '')).toUpperCase()).get().then((event) {
                          if(event.docs.isNotEmpty){

                            for(DocumentSnapshot<Map<String , dynamic>> doc in event.docs){
                              books.add(BookModel.fromJson(doc.data()!));
                            }
                            // data=BookModel.fromJson(event.docs[0].data());
                          }

                          if(mounted){
                            setState(() {

                             print( '""""""""books.length""""""""');
                             print( books.length);
                            });
                          }


                        });
                      }
                        BookModel? data;

                        // if(data!=null) {
                        //   if (text != '' && data!.block == false) {
                        //     Navigator.push(
                        //         context, MaterialPageRoute(builder: (context) =>
                        //         SingleBookDetailesPage(
                        //           bookData: data!,
                        //         ))).then((value){
                        //       getTransaction();
                        //       if(mounted) {
                        //         setState(() {
                        //
                        //         });
                        //       }
                        //     });
                        //     search.text='';
                        //
                        //
                        //
                        //
                        //
                        //   } else {
                        //     text == '' ?
                        //     showUploadMessage(context, 'Enter your book number ',
                        //         style: GoogleFonts.montserrat()) :
                        //     showUploadMessage(context,
                        //         'This Book is blocked by irregular transaction',
                        //         style: GoogleFonts.montserrat(
                        //             color: primarycolor2
                        //         ));
                        //   }
                        // }else{
                        //   showUploadMessage(context, 'book does not exist', style: GoogleFonts.montserrat());
                        //
                        // }
                      // }
                    },

                    controller: search,
                    // keyboardType:
                    // TextInputType.phone,

                    decoration: InputDecoration(

                      contentPadding: const EdgeInsets.only(left: 15,top: 10),
                      hintText:
                      // widget.bookData.bookName.toString(),
                      'Search Book',
                      hintStyle:  GoogleFonts.montserrat(
                          color: primarycolor1.withOpacity(0.5),
                          fontSize: width * 0.045),

                      suffixIcon: IconButton(icon:  Icon(searchInput.index==2?Icons.abc:Icons.onetwothree_outlined,),
                        onPressed: () async {
                        FocusManager.instance.primaryFocus?.unfocus();
                        if(searchInput.index==2) {
                          searchInput=TextInputType.text;
                        } else {
                          searchInput=TextInputType.number;
                        }
                        // setState(() {});
                        await Future.delayed(Duration(seconds: 1));

                        // setState(() {
                          FocusScope.of(context).requestFocus(focusNode);
                        // });

                        // Navigator.pushReplacement(context, MaterialPageRoute(builder: (context)=>SearchBookPage()));
                      },),
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

              search.text.isNotEmpty?
              books.isEmpty?SizedBox(
                height: width*0.5 ,
                child: Center(
                  child: Text('No Books found',
                    style:  GoogleFonts.montserrat(color:primarycolor1,fontWeight: FontWeight.w700,fontSize: 14),),
                ),
              ):
              ListView.builder(
                  shrinkWrap: true,
                  scrollDirection: Axis.vertical,
                  physics: const BouncingScrollPhysics(),
                  itemCount:books.length ,
                  itemBuilder: (context,index){
                    return  Padding(
                      padding: const EdgeInsets.all(8.0),
                      child: InkWell(
                        onTap: () async {

                          // BookModel? data;
                          // QuerySnapshot<Map<String,dynamic>> event =  await FirebaseFirestore.instance.collection('shops')
                          //     .doc(currentshopId).collection('book').where('delete',isEqualTo: false).
                          // where('bookName',isEqualTo: statement[index].bookName).
                          // get();
                          // if(event.docs.isNotEmpty){
                          //   data=BookModel.fromJson(event.docs[0].data());
                          // }
                          //
                          //
                          //
                          // if(data!=null) {

                            Navigator.push(
                                context, MaterialPageRoute(builder: (context) =>
                                SingleBookDetailesPage(
                                  bookData: books[index]!,
                                ))).then((value){
                              getTransaction();
                              if(mounted) {
                                setState(() {

                                });
                              }
                            });
                          // }


                        },
                        child: Container(
                          padding: const EdgeInsets.only(right: 10,top: 20),
                          // height: 100,
                          width: 200,
                          decoration: BoxDecoration(
                            borderRadius: BorderRadius.circular(10),
                            color: const Color(0xffFBFBFB),
                            //  color:Colors.red
                          ),
                          child: Row(
                            mainAxisAlignment: MainAxisAlignment.spaceBetween,
                            children: [
                              Row(
                                children: [
                                  // Container(
                                  //   height: 60,
                                  //   width: 70,
                                  //   // color: Colors.red,
                                  //   decoration: BoxDecoration(
                                  //       image: DecorationImage(image: CachedNetworkImageProvider(statement[index].image??''),fit: BoxFit.fill)
                                  //   ),
                                  // ),
                                  const SizedBox(width: 10,),
                                  Column(
                                    crossAxisAlignment: CrossAxisAlignment.start,
                                    children: [
                                      Text(books[index].bookName??'',
                                        style:  GoogleFonts.montserrat(color:primarycolor1,fontWeight: FontWeight.w800,fontSize: 20),),

                                      const SizedBox(height: 10,),
                                      StreamBuilder<QuerySnapshot>(
                                        stream: FirebaseFirestore.instance.collection('users')
                                          .where('userEmail',isEqualTo: books[index].members?[0]??'')
                                          .snapshots(),
                                        builder: (context, snapshot) {
                                          if(!snapshot.hasData||snapshot.hasError){
                                            return const Center(child: CircularProgressIndicator());
                                          }
                                          return SizedBox(
                                            width: width*0.6,

                                            child: Text(snapshot.data!.docs[0]['userName'],
                                              style:  GoogleFonts.montserrat(color:primarycolor1,fontWeight: FontWeight.w700,fontSize: 14),),
                                          );
                                        }
                                      ),

                                      // Text(statement[index].shopName??"",
                                      //   style: TextStyle(color:Color(0xff5E5F5F),fontWeight: FontWeight.w700,fontSize: 14),),
                                      const SizedBox(height: 5,),

                                      // Text(statement[index].bookName??"",
                                      //   style: TextStyle(color:Color(0xff5E5F5F),fontWeight: FontWeight.w700,fontSize: 14),),
                                      const SizedBox(height: 5,),
                                      //
                                      // Text(DateFormat('dd MMM yyyy hh:mm aa').format(statement[index].toJson().containsKey('date')?statement[index].date:statement[index].date),
                                      //   style:  GoogleFonts.montserrat(color:Colors.black,fontWeight: FontWeight.w600,fontSize: 11),),
                                      // const SizedBox(height: 5,),
                                      //
                                      // statement[index].noBook==true?
                                      // Text('No Book', style: GoogleFonts.montserrat(color:Colors.red,fontWeight: FontWeight.w800,fontSize: 14),):Container()


                                    ],
                                  )
                                ],
                              ),
                              Column(
                                mainAxisAlignment: MainAxisAlignment.center,
                                children: [
                                  // statement[index].noBook==false?
                                  Row(
                                    children: [
                                      // Text(statement[index].currencyShort.toString(), style: GoogleFonts.montserrat(color:statement[index].toJson().containsKey('purchaseId') ?Colors.black:Colors.green,fontWeight: FontWeight.w600,fontSize: 15),),
                                      // const SizedBox(width: 3,),
                                      Text(books[index].credit.toString(), style: GoogleFonts.montserrat(color:Colors.black,fontWeight: FontWeight.w600,fontSize: 15),),
                                    ],
                                  ),



                                ],
                              ),

                              // SizedBox(width: 5,),


                            ],
                          ),

                        ),
                      ),
                    );
                  }):
              statement.isEmpty?SizedBox(
                height: width*0.5 ,
                child: Center(
                  child: Text('No transaction found',
                    style:  GoogleFonts.montserrat(color:primarycolor1,fontWeight: FontWeight.w700,fontSize: 14),),
                ),
              ):
              ListView.builder(
                     shrinkWrap: true,
                  scrollDirection: Axis.vertical,
                  physics: const BouncingScrollPhysics(),
                  itemCount:statement.length ,
                  itemBuilder: (context,index){
                    return  Padding(
                      padding: const EdgeInsets.all(8.0),
                      child: InkWell(
                        onTap: () async {

                          BookModel? data;
                          QuerySnapshot<Map<String,dynamic>> event =  await FirebaseFirestore.instance.collection('shops')
                              .doc(currentshopId).collection('book').where('delete',isEqualTo: false).
                           where('bookName',isEqualTo: statement[index].bookName).
                          get();
                            if(event.docs.isNotEmpty){
                              data=BookModel.fromJson(event.docs[0].data());
                            }



                          if(data!=null) {

                            Navigator.push(
                                context, MaterialPageRoute(builder: (context) =>
                                SingleBookDetailesPage(
                                  bookData: data!,
                                ))).then((value){
                              getTransaction();
                              if(mounted) {
                                setState(() {

                                });
                              }
                            });
                          }


                        },
                        child: Container(
                          padding: const EdgeInsets.only(right: 10,top: 20),
                          // height: 100,
                          width: 200,
                          decoration: BoxDecoration(
                            borderRadius: BorderRadius.circular(10),
                             color: const Color(0xffFBFBFB),
                          //  color:Colors.red
                          ),
                          child: Row(
                            mainAxisAlignment: MainAxisAlignment.spaceBetween,
                            children: [
                              Row(
                                children: [
                                  // Container(
                                  //   height: 60,
                                  //   width: 70,
                                  //   // color: Colors.red,
                                  //   decoration: BoxDecoration(
                                  //       image: DecorationImage(image: CachedNetworkImageProvider(statement[index].image??''),fit: BoxFit.fill)
                                  //   ),
                                  // ),
                                  const SizedBox(width: 10,),
                                  Column(
                                    crossAxisAlignment: CrossAxisAlignment.start,
                                    children: [
                                      Text(statement[index].bookName,
                                        style:  GoogleFonts.montserrat(color:primarycolor1,fontWeight: FontWeight.w800,fontSize: 20),),

                                      const SizedBox(height: 10,),
                                      SizedBox(
                                        width: width*0.6,

                                        child: Text(statement[index].customerName,
                                          style:  GoogleFonts.montserrat(color:primarycolor1,fontWeight: FontWeight.w700,fontSize: 14),),
                                      ),

                                      // Text(statement[index].shopName??"",
                                      //   style: TextStyle(color:Color(0xff5E5F5F),fontWeight: FontWeight.w700,fontSize: 14),),
                                      const SizedBox(height: 5,),

                                      // Text(statement[index].bookName??"",
                                      //   style: TextStyle(color:Color(0xff5E5F5F),fontWeight: FontWeight.w700,fontSize: 14),),
                                      const SizedBox(height: 5,),

                                      Text(DateFormat('dd MMM yyyy hh:mm aa').format(statement[index].toJson().containsKey('date')?statement[index].date:statement[index].date),
                                        style:  GoogleFonts.montserrat(color:Colors.black,fontWeight: FontWeight.w600,fontSize: 11),),
                                      const SizedBox(height: 5,),

                                      statement[index].noBook==true?
                                      Text('No Book', style: GoogleFonts.montserrat(color:Colors.red,fontWeight: FontWeight.w800,fontSize: 14),):Container()


                                    ],
                                  )
                                ],
                              ),
                              Column(
                                mainAxisAlignment: MainAxisAlignment.center,
                                children: [
                                  // statement[index].noBook==false?
                                  Row(
                                    children: [
                                      Text(statement[index].currencyShort.toString(), style: GoogleFonts.montserrat(color:statement[index].toJson().containsKey('purchaseId') ?Colors.black:Colors.green,fontWeight: FontWeight.w600,fontSize: 15),),
                                      const SizedBox(width: 3,),
                                      Text(statement[index].amount.toString(), style: GoogleFonts.montserrat(color:statement[index].toJson().containsKey('purchaseId')?Colors.black:Colors.green,fontWeight: FontWeight.w600,fontSize: 15),),
                                    ],
                                  ),



                                ],
                              ),

                              // SizedBox(width: 5,),


                            ],
                          ),

                        ),
                      ),
                    );
                  })


            ]
        ),
      ),
    );
  }
}
