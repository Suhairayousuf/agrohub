import 'dart:async';
import 'dart:developer';

import 'package:agrohub/features/Book/report/pdf/pdfDesign.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_svg/svg.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:intl/intl.dart';
import 'package:share_plus/share_plus.dart';


import '../../../../Model/bookModel.dart';
import '../../../../Model/usermodel/user_model.dart';
import '../../../../core/utils/utils.dart';
import '../../../../themes/color.dart';
import '../../../Home/screen/selectShop.dart';
import '../../../auth/screen/splash.dart';
import '../../book/screen/single_book_detailes.dart';



class SearchCompanyBook extends StatefulWidget {
  final String? txt;
  final String appBarText;
  final bool isFromList;
  const SearchCompanyBook({Key? key, this.txt, required this.appBarText, required this.isFromList}) : super(key: key);

  @override
  State<SearchCompanyBook> createState() => _SearchCompanyBookState();
}

class _SearchCompanyBookState extends State<SearchCompanyBook> {


  getLastPurchase(String memberId,int index) {
    FirebaseFirestore.instance.collection('users')
        .where('userEmail',isEqualTo: memberId)
        .get().then((value) =>  value.docs.first.reference.collection('purchase').orderBy('date').limit(1).get().then((value) {
          if(value.docs.isNotEmpty) {
            Map <String,dynamic> data=value.docs[0].data();
            lastPurchases[index] = data['amount'].toStringAsFixed(2)+'\n'+"(${DateFormat('dd MMM yy').format(data['date'].toDate())})";
          }

    },),);
  }
  getLastTransaction(String memberId,int index) {
    print(index);
    print(memberId);
    FirebaseFirestore.instance.collection('users')
        .where('userEmail',isEqualTo: memberId)
        .get().then((value) =>  value.docs.first.reference.collection('transactions').orderBy('date').limit(1).get().then((value) {
          if(value.docs.isNotEmpty) {
            Map <String,dynamic> data=value.docs[0].data();
            lastTransactions[index] = data['amount'].toStringAsFixed(2)+'\n'+"(${DateFormat('dd MMM yy').format(data['date'].toDate())})";
          }

    },),);
  }
  // List<BookModel> bookList=[];
  String? text = '';

  BookModel? bookMap;
  // List<UserModel> userList=[];


  StreamSubscription? a;
  StreamSubscription? b;

  List<BookModel> bookList=[];
  List<String> userList=[];
  List<String> userPhoneList=[];
  List<String> lastPurchases=[];
  List<String> lastTransactions=[];
  double totalCredit=0;


  late TextEditingController search;
  @override
  void initState() {

    search = TextEditingController(text: widget.txt??'');
    // getBooks();
    super.initState();
  }

  @override
  void dispose() {
    // a?.cancel();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        automaticallyImplyLeading: true,
        centerTitle: false,
        elevation: 0,
        actions: [
          IconButton(onPressed: ()async {



      final pdfFile = await RunnerFinanceApi.generate(search.text,bookList,userList,userPhoneList,lastTransactions,lastPurchases,totalCredit);
      XFile file =  XFile(pdfFile!.path);
      Share.shareXFiles([file]);
      // await PdfApi.openFile(pdfFile);
      // final pdf =
      // RunnerFinanceApi.generate(settlement);
      // await   PdfApi.openFile(pdf);
    },
              icon: Icon(Icons.download))
        ],
        // leading: IconButton(
        //   onPressed: () {
        //     Navigator.pop(context);
        //   },
        //   icon: Icon(Icons.arrow_back_ios),
        // ),
        title: Text(widget.appBarText,style: GoogleFonts.montserrat(
            color: Colors.white
        ),),
        backgroundColor: primarycolor1,
      ),
      body:  SingleChildScrollView(
        child: StreamBuilder<List<BookModel>>(
          stream:widget.isFromList?

          FirebaseFirestore.instance.collectionGroup('book')
              .where('shopId',isEqualTo: currentshopId )
              .where('company',isEqualTo: widget.txt?.toUpperCase().trim())
          // .where('search',arrayContains: search.text.toUpperCase())
              .where('delete',isEqualTo :false)
          .orderBy('bookName')
              .snapshots().map((event) => event.docs.map ((e) => BookModel.fromJson(e.data())).toList())
              :
          FirebaseFirestore.instance.collectionGroup('book')
              .where('shopId',isEqualTo: currentshopId )
              .where('search',arrayContains: search.text.isEmpty?null:search.text.toUpperCase())
              .where('delete',isEqualTo :false)
              .orderBy('bookName')
              .snapshots().map((event) => event.docs.map ((e) => BookModel.fromJson(e.data())).toList()),
            builder: (context, snapshot) {


              if(!snapshot.hasData || snapshot.hasError){
                return Center(child: CircularProgressIndicator());
              }



               totalCredit =0;
               bookList=snapshot.data!;
               userList=[];
              for(BookModel a in bookList) {
                totalCredit+=a.credit??0;
                userList.add(a.company??'');
                userPhoneList.add(a.company??'');
                lastPurchases.add(a.company??'');
                lastTransactions.add(a.company??'');
              }




            return Column(
                children: [
                  Padding(
                    padding: const EdgeInsets.only(left: 10,top: 20,right: 10),
                    child: Container(
                      width: width * 0.9,
                      height: 60,
                      // decoration: ShapeDecoration(
                      //   color: Color(0xFFFEFEFE),
                      //   shape: RoundedRectangleBorder(
                      //     borderRadius: BorderRadius.circular(25),
                      //   ),
                      // ),

                      decoration: BoxDecoration(
                        color: Color(0xFFFEFEFE),

                        // border: Border.all(
                        //     color: primarycolor1),
                        borderRadius:
                        BorderRadius.circular(25),
                        boxShadow: [
                          BoxShadow(
                            color: Colors.grey.withOpacity(0.5),
                            spreadRadius: .5,
                            blurRadius: .1,
                            offset: Offset(0, 1), // changes position of shadow
                          ),
                        ],
                      ),
                      child: Center(
                        child: TextFormField(
                          autofocus: true,
                          onFieldSubmitted: (text)  {
                            // if(text.substring(text.length-1,text.length)=='-'){

                            // await FirebaseFirestore.instance.collection('users')
                            //     .where('shopId',isEqualTo: currentshopId).
                            // where('companyName',isEqualTo: text.replaceAll('-', '')).get().then((event) {
                            //   if(event.docs.isNotEmpty){
                            //     userList=event.docs.map((e)=>UserModel.fromJson(e.data())).toList();
                            //   }
                            //
                            //   if(mounted){
                            //     setState(() {
                            //
                            //     });
                            //   }
                            //
                            //
                            // });

                            // }

                            setState(() {});
                          },

                          controller: search,
                          keyboardType:
                          TextInputType.text,

                          decoration: InputDecoration(
                            contentPadding:  const EdgeInsets.only(left: 15,bottom: 10),
                            hintText:
                            // widget.bookData.bookName.toString(),
                            'Search Company...',
                            hintStyle:  GoogleFonts.montserrat(
                                color: primarycolor1.withOpacity(0.5),
                                fontSize: width * 0.03),

                            suffixIcon: const Icon(Icons.search,color: Color(0xffB6A0A0),),
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
                  ),
                  Padding(
                    padding: const EdgeInsets.all(20),
                    child: Row(
                      mainAxisAlignment: MainAxisAlignment.end,
                      children: [


                        Padding(
                          padding:  EdgeInsets.only(right: 20.0),
                          child: Text.rich(
                            TextSpan(

                              children: [
                                TextSpan(text: 'TOTAL :  ',
                                  style: GoogleFonts.montserrat(color:Colors.black,fontWeight: FontWeight.w700,fontSize: 25),
                                ),
                                TextSpan(text: '$currencyCode.'),
                                TextSpan(
                                  // Text((data.credit??0).toStringAsFixed(2),
                                  // style:  GoogleFonts.montserrat(color:Colors.black,fontWeight: FontWeight.w900,fontSize: 20),);
                                  text: totalCredit.toStringAsFixed(2),
                                  style: GoogleFonts.montserrat(color:Colors.black,fontWeight: FontWeight.w700,fontSize: 23),
                                ),
                              ],
                            ),
                          ),
                        )
                      ],
                    ),
                  ),



                  search.text.isEmpty?SizedBox(
                    height: width*0.5 ,
                    child: Center(
                      child: Text('No Books found',
                        style:  GoogleFonts.montserrat(color:primarycolor1,fontWeight: FontWeight.w700,fontSize: 14),),
                    ),
                  ):
                  bookList.isEmpty?
                      SizedBox(
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
                          itemCount:bookList.length ,
                          itemBuilder: (context,index){

                            if(bookList[index].members!.isNotEmpty) {
                              getLastTransaction(
                                  bookList[index].members![0], index);
                              getLastPurchase(bookList[index].members![0], index);
                            }

                            return  Padding(
                              padding:  EdgeInsets.only(left:width*0.05,right: width*0.05,top: width*0.05),
                              child: InkWell(
                                onTap: () async {

                                  BookModel? data;

                                  // QuerySnapshot<Map<String,dynamic>> event =  await FirebaseFirestore.instance.collection('shops')
                                  //     .doc(currentshopId).collection('book').where('delete',isEqualTo: false).
                                  // where('bookName',isEqualTo: userList[index].books![0].split('-')[1]).
                                  // get();
                                  // if(event.docs.isNotEmpty){
                                  //   data=BookModel.fromJson(event.docs[0].data());
                                  // }




                                    Navigator.push(
                                        context, MaterialPageRoute(builder: (context) =>
                                        SingleBookDetailesPage(
                                          bookData: bookList[index],
                                        ))).then((value){

                                      if(mounted) {
                                        setState(() {

                                        });
                                      }
                                    });



                                },
                                child:

                                // ListTile(
                                //   leading: SizedBox(),
                                //   title:  Text(userList[index].userName??'',
                                //                    style:  GoogleFonts.montserrat(color:primarycolor1,fontWeight: FontWeight.w800,fontSize: 25),),
                                //   subtitle: Text(userList[index].books![0].split('-')[1],
                                //     style:  GoogleFonts.montserrat(color:Colors.black,fontWeight: FontWeight.w600,fontSize: 15),),
                                //   trailing: SizedBox(
                                //     width: width*0.5,
                                //     child: Row(
                                //       mainAxisAlignment: MainAxisAlignment.end,
                                //       children: [
                                //         StreamBuilder<List<BookModel>>(
                                //           stream: FirebaseFirestore.instance.collectionGroup('book')
                                //             .where('shopId',isEqualTo: userList[index].books![0].split('-')[0])
                                //             .where('bookName',isEqualTo: userList[index].books![0].split('-')[1])
                                //             .snapshots().map((event) => event.docs.map((e) => BookModel.fromJson(e.data())).toList()),
                                //           builder: (context, snapshot) {
                                //
                                //             if(!snapshot.hasData ||snapshot.hasError){
                                //               return Center(child: CircularProgressIndicator());
                                //             }
                                //
                                //             final data = snapshot.data![0];
                                //
                                //             return Text((data.credit??0).toStringAsFixed(2),
                                //               style:  GoogleFonts.montserrat(color:Colors.black,fontWeight: FontWeight.w900,fontSize: 20),);
                                //           }
                                //         ),
                                //       ],
                                //     ),
                                //   ),
                                //
                                // )

                                  ///

                                Container(
                                  // padding: const EdgeInsets.only(right: 10,top: 20),
                                  // height: 100,
                                  width: width *0.7,
                                  height: 150,
                                  decoration: BoxDecoration(
                                    borderRadius: BorderRadius.circular(25),
                                    color: const Color(0xffFBFBFB),

                                    // color: Color(0xFFFEFEFE),

                                    // border: Border.all(
                                    //     color: primarycolor1),
                                    // borderRadius:
                                    // BorderRadius.circular(25),
                                    boxShadow: [
                                      BoxShadow(
                                        color: Colors.grey.withOpacity(0.5),
                                        spreadRadius: 1,
                                        blurRadius: 1,
                                        offset: Offset(0, 2), // changes position of shadow
                                      ),
                                    ],
                                    //  color:Colors.red
                                  ),
                                  child: Padding(
                                    padding: const EdgeInsets.all(30.0),
                                    child: Row(
                                       mainAxisAlignment: MainAxisAlignment.spaceBetween,
                                      crossAxisAlignment: CrossAxisAlignment.center,
                                      children: [
                                        Expanded(
                                          child: Column(
                                            mainAxisAlignment: MainAxisAlignment.spaceAround,
                                            crossAxisAlignment: CrossAxisAlignment.start,
                                            children: [
                                              
                                              Expanded(
                                                child: Row(
                                                  // mainAxisAlignment: MainAxisAlignment.spaceBetween,
                                                  children: [




                                                    SvgPicture.asset("assets/person.svg"),
                                                    SizedBox(width: 10,),
                                                    bookList[index].members!.isEmpty?
                                                        Text('NO USER')
                                                    :
                                                    Expanded(
                                                      child: SizedBox(
                                                        width: width*0.5,
                                                        child: FutureBuilder<UserModel>(
                                                          initialData: null ,
                                                          future: FirebaseFirestore.instance.collection('users')
                                                          .where('userEmail',isEqualTo: bookList[index].members![0])
                                                            .get().then((value) =>  UserModel.fromJson(value.docs[0].data())),
                                                          builder: (context, user) {

                                                            if(snapshot.data==null){
                                                              return CircularProgressIndicator();
                                                            }
                                                            final u = user.data;
                                                            userList[index]=u?.userName??'';
                                                            userPhoneList[index]=u?.phone??'';

                                                            return Text(u?.userName??'',
                                                              // userList[index].company??'',
                                                              style: const TextStyle(
                                                              color: Color(0xff1E1E1E),
                                                              fontSize: 18,
                                                              fontWeight: FontWeight.bold
                                                            ),
                                                            );
                                                          }
                                                        ),
                                                      ),
                                                    ),

                                                    // Row(
                                                    //   children: [
                                                    //     // Container(
                                                    //     //   height: 60,
                                                    //     //   width: 70,
                                                    //     //   // color: Colors.red,
                                                    //     //   decoration: BoxDecoration(
                                                    //     //       image: DecorationImage(image: CachedNetworkImageProvider(statement[index].image??''),fit: BoxFit.fill)
                                                    //     //   ),
                                                    //     // ),
                                                    //     const SizedBox(width: 10,),
                                                    //     Column(
                                                    //       crossAxisAlignment: CrossAxisAlignment.start,
                                                    //       children: [
                                                    //         // Text(statement[index].bookName,
                                                    //         //   style:  GoogleFonts.montserrat(color:primarycolor1,fontWeight: FontWeight.w800,fontSize: 20),),
                                                    //
                                                    //         const SizedBox(height: 10,),
                                                    //         SizedBox(
                                                    //           width: width*0.6,
                                                    //
                                                    //           child: Text(userList[index].books![0].split('-')[1],
                                                    //             style:  GoogleFonts.montserrat(color:primarycolor1,fontWeight: FontWeight.w700,fontSize: 14),),
                                                    //           // Text(userList[index].userName!,
                                                    //           //   style:  GoogleFonts.montserrat(color:primarycolor1,fontWeight: FontWeight.w700,fontSize: 14),),
                                                    //         ),
                                                    //
                                                    //         // Text(statement[index].shopName??"",
                                                    //         //   style: TextStyle(color:Color(0xff5E5F5F),fontWeight: FontWeight.w700,fontSize: 14),),
                                                    //         const SizedBox(height: 5,),
                                                    //
                                                    //         // Text(statement[index].bookName??"",
                                                    //         //   style: TextStyle(color:Color(0xff5E5F5F),fontWeight: FontWeight.w700,fontSize: 14),),
                                                    //         const SizedBox(height: 5,),
                                                    //
                                                    //
                                                    //
                                                    //         // statement[index].noBook==true?
                                                    //         // Text('No Book', style: GoogleFonts.montserrat(color:Colors.red,fontWeight: FontWeight.w800,fontSize: 14),):Container()
                                                    //
                                                    //
                                                    //       ],
                                                    //     )
                                                    //   ],
                                                    // ),
                                                    ///
                                                    // Column(
                                                    //   mainAxisAlignment: MainAxisAlignment.center,
                                                    //   children: [
                                                    //     // statement[index].noBook==false?
                                                    //     Row(
                                                    //       children: [
                                                    //         Text(statement[index].currencyShort.toString(), style: GoogleFonts.montserrat(color:statement[index].toJson().containsKey('purchaseId') ?Colors.black:Colors.green,fontWeight: FontWeight.w600,fontSize: 15),),
                                                    //         const SizedBox(width: 3,),
                                                    //         Text(statement[index].amount.toString(), style: GoogleFonts.montserrat(color:statement[index].toJson().containsKey('purchaseId')?Colors.black:Colors.green,fontWeight: FontWeight.w600,fontSize: 15),),
                                                    //       ],
                                                    //     ),
                                                    //
                                                    //
                                                    //
                                                    //   ],
                                                    // ),

                                                    // SizedBox(width: 5,),


                                                  ],
                                                ),
                                              ),
                                              Expanded(
                                                child: Row(
                                                  // mainAxisAlignment: MainAxisAlignment.spaceBetween,
                                                  children: [

                                                    SvgPicture.asset("assets/book.svg",),
                                                    SizedBox(width: 10,),

                                                    Expanded(
                                                      child: Text(bookList[index].bookName??'',style: TextStyle(
                                                          color: Color(0xff1E1E1E),
                                                          fontSize: 18,
                                                          fontWeight: FontWeight.bold
                                                      )),
                                                    ),

                                                    // Row(
                                                    //   children: [
                                                    //     // Container(
                                                    //     //   height: 60,
                                                    //     //   width: 70,
                                                    //     //   // color: Colors.red,
                                                    //     //   decoration: BoxDecoration(
                                                    //     //       image: DecorationImage(image: CachedNetworkImageProvider(statement[index].image??''),fit: BoxFit.fill)
                                                    //     //   ),
                                                    //     // ),
                                                    //     const SizedBox(width: 10,),
                                                    //     Column(
                                                    //       crossAxisAlignment: CrossAxisAlignment.start,
                                                    //       children: [
                                                    //         // Text(statement[index].bookName,
                                                    //         //   style:  GoogleFonts.montserrat(color:primarycolor1,fontWeight: FontWeight.w800,fontSize: 20),),
                                                    //
                                                    //         const SizedBox(height: 10,),
                                                    //         SizedBox(
                                                    //           width: width*0.6,
                                                    //
                                                    //           child: Text(userList[index].books![0].split('-')[1],
                                                    //             style:  GoogleFonts.montserrat(color:primarycolor1,fontWeight: FontWeight.w700,fontSize: 14),),
                                                    //           // Text(userList[index].userName!,
                                                    //           //   style:  GoogleFonts.montserrat(color:primarycolor1,fontWeight: FontWeight.w700,fontSize: 14),),
                                                    //         ),
                                                    //
                                                    //         // Text(statement[index].shopName??"",
                                                    //         //   style: TextStyle(color:Color(0xff5E5F5F),fontWeight: FontWeight.w700,fontSize: 14),),
                                                    //         const SizedBox(height: 5,),
                                                    //
                                                    //         // Text(statement[index].bookName??"",
                                                    //         //   style: TextStyle(color:Color(0xff5E5F5F),fontWeight: FontWeight.w700,fontSize: 14),),
                                                    //         const SizedBox(height: 5,),
                                                    //
                                                    //
                                                    //
                                                    //         // statement[index].noBook==true?
                                                    //         // Text('No Book', style: GoogleFonts.montserrat(color:Colors.red,fontWeight: FontWeight.w800,fontSize: 14),):Container()
                                                    //
                                                    //
                                                    //       ],
                                                    //     )
                                                    //   ],
                                                    // ),
                                                    ///
                                                    // Column(
                                                    //   mainAxisAlignment: MainAxisAlignment.center,
                                                    //   children: [
                                                    //     // statement[index].noBook==false?
                                                    //     Row(
                                                    //       children: [
                                                    //         Text(statement[index].currencyShort.toString(), style: GoogleFonts.montserrat(color:statement[index].toJson().containsKey('purchaseId') ?Colors.black:Colors.green,fontWeight: FontWeight.w600,fontSize: 15),),
                                                    //         const SizedBox(width: 3,),
                                                    //         Text(statement[index].amount.toString(), style: GoogleFonts.montserrat(color:statement[index].toJson().containsKey('purchaseId')?Colors.black:Colors.green,fontWeight: FontWeight.w600,fontSize: 15),),
                                                    //       ],
                                                    //     ),
                                                    //
                                                    //
                                                    //
                                                    //   ],
                                                    // ),

                                                    // SizedBox(width: 5,),


                                                  ],
                                                ),
                                              ),
                                            ],
                                          ),
                                        ),

                                        Column(
                                          children: [
                                            Expanded(
                                              child: SizedBox(

                                                child: Text.rich(
                                                               TextSpan(
                                                                 children: [
                                                                   TextSpan(text: 'QAR.'),
                                                                   TextSpan(
                                                                     // Text((data.credit??0).toStringAsFixed(2),
                                                                     // style:  GoogleFonts.montserrat(color:Colors.black,fontWeight: FontWeight.w900,fontSize: 20),);
                                                                     text: (bookList[index].credit??0).toStringAsFixed(2),
                                                                     style: GoogleFonts.montserrat(color:Colors.black,fontWeight: FontWeight.w700,fontSize: 23),
                                                                   ),
                                                                 ],
                                                               ),
                                                             ),


                                                 // child: StreamBuilder<List<BookModel>>(
                                                 //          stream: FirebaseFirestore.instance.collectionGroup('book')
                                                 //            .where('shopId',isEqualTo: userList[index].books![0].split('-')[0])
                                                 //            .where('bookName',isEqualTo: userList[index].books![0].split('-')[1])
                                                 //          .where('delete',isEqualTo: false)
                                                 //            .snapshots().map((event) => event.docs.map((e) => BookModel.fromJson(e.data())).toList()),
                                                 //          builder: (context, snapshot) {
                                                 //
                                                 //            if(!snapshot.hasData ||snapshot.hasError){
                                                 //              return Center(child: CircularProgressIndicator());
                                                 //            }
                                                 //
                                                 //            final data = snapshot.data![0];
                                                 //
                                                 //            return Text.rich(
                                                 //              TextSpan(
                                                 //                children: [
                                                 //                  TextSpan(text: 'QR.'),
                                                 //                  TextSpan(
                                                 //                    // Text((data.credit??0).toStringAsFixed(2),
                                                 //                    // style:  GoogleFonts.montserrat(color:Colors.black,fontWeight: FontWeight.w900,fontSize: 20),);
                                                 //                    text: (data.credit??0).toStringAsFixed(2),
                                                 //                    style: GoogleFonts.montserrat(color:Colors.black,fontWeight: FontWeight.w700,fontSize: 23),
                                                 //                  ),
                                                 //                ],
                                                 //              ),
                                                 //            );
                                                 //
                                                 //              // Text((data.credit??0).toStringAsFixed(2),
                                                 //              // style:  GoogleFonts.montserrat(color:Colors.black,fontWeight: FontWeight.w900,fontSize: 20),);
                                                 //          }
                                                 //        ),

                                                ///
                                                // FutureBuilder<AggregateQuerySnapshot>(
                                                //     future: FirebaseFirestore.instance.collectionGroup('book')
                                                //         .where('shopId',isEqualTo: currentshopId)
                                                //         .where('company',isEqualTo: companyNames[index].toString().toUpperCase())
                                                //         .count().get(),
                                                //     initialData: null,
                                                //
                                                //     builder: (context, snapshot) {
                                                //
                                                //       if(snapshot.data==null){
                                                //         return CircularProgressIndicator();
                                                //       }
                                                //       return Text((snapshot.data?.count??0).toString(),
                                                //         style:  GoogleFonts.montserrat(color:primarycolor1,fontWeight: FontWeight.w700,fontSize: 20),);
                                                //     }
                                                // ),
                                                ///
                                                // Text(userList[index].userName!,
                                                //   style:  GoogleFonts.montserrat(color:primarycolor1,fontWeight: FontWeight.w700,fontSize: 14),),
                                              ),
                                            ),

                                          ],
                                        ),
                                      ],
                                    ),
                                  ),

                                ),
                              ),
                            );
                          }),



                ]
            );
          }
        ),
      ),
    );
  }
}
