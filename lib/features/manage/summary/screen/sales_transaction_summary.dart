import 'dart:async';

import 'package:cached_network_image/cached_network_image.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:flutter_month_picker/flutter_month_picker.dart';
import 'package:flutter_svg/svg.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:intl/intl.dart';


import '../../../../Model/TransactionModel/transactionModel.dart';
import '../../../../Model/purchase/purchaseModel.dart';
import '../../../../core/utils/utils.dart';
import '../../../../themes/color.dart';
import '../../../Home/screen/NavigationBar.dart';
import '../../../Home/screen/homePage.dart';
import '../../../Home/screen/selectShop.dart';
import '../../../auth/screen/splash.dart';


class SummaryPage extends StatefulWidget {

  const SummaryPage({Key? key,

  }) : super(key: key);

  @override
  State<SummaryPage> createState() => _SummaryPageState();
}

class _SummaryPageState extends State<SummaryPage> {
  int index=0;

  double totalSalesmount=0.0;
  double totalRecievedmount=0.0;
  double totalCredit=0.0;
  List statement=[];

  List<TransactionModel> allTransaction=[];
  List<PurchaseModel> allPurchase=[];
  StreamSubscription? a;
  StreamSubscription? b;
  getTransaction(DateTime from,DateTime to){
    a=FirebaseFirestore.instance.collectionGroup('transactions')
        .where('date',isGreaterThanOrEqualTo: from)
        .where('date',isLessThanOrEqualTo: to)
        .where('shopId',isEqualTo: currentshopId).
       orderBy('date',descending: true).where('delete',isEqualTo: false)
        .snapshots()
        .listen((event) {
      allTransaction =[];
      totalRecievedmount=0;
      for(DocumentSnapshot <Map<String,dynamic>> doc in event.docs){
        allTransaction.add(TransactionModel.fromJson(doc.data()!));
        totalRecievedmount+=doc.get('amount');
      }
      if(mounted){
        setState(() {

        });
      }

    });

   b= FirebaseFirestore.instance.collectionGroup('purchase')
        .where('shopId',isEqualTo: currentshopId)
        .where('date',isGreaterThanOrEqualTo: from)
        .where('date',isLessThanOrEqualTo: to).where('delete',isEqualTo: false).
        // .where('bookId',isEqualTo: widget.bookData.bookId).
    orderBy('date',descending: true).
    // limit(3)
        snapshots()
        .listen((event) {
      allPurchase=[];
      statement=[];
      totalSalesmount=0;
      for(DocumentSnapshot <Map<String,dynamic>> doc in event.docs){
        allPurchase.add(PurchaseModel.fromJson(doc.data()!));
        totalSalesmount+=doc.get('amount');
      }
      totalCredit=totalSalesmount-totalRecievedmount;
      statement.addAll(allPurchase);
      statement.addAll(allTransaction);

      statement.sort((b, a) => a.date.compareTo(b.date));


      print(statement);
      for(var a in statement){
        print(a.customerId);
      }
      if(mounted){
        setState(() {


        });
      }

    });


    // statement.followedBy(allTransaction);


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
                IconButton(
                    onPressed: () => Navigator.pop(context),
                    icon: Icon(
                      Icons.arrow_back_ios,
                      color: Colors.white,
                    )),
                SizedBox(
                  width: width * 0.65,
                ),
              ],
            ),

          ),
          Positioned(
            top: width * 0.3,
            height: width * 0.1,
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
  DateTime? now ;
  // DateTime? today;
  // DateTime? selectedDate;
  @override
  void initState() {
    now=DateTime.now();
    // today = DateTime(now!.year,now!.month,now!.day,0,0,0);
    getTransaction(DateTime(now!.year,now!.month,now!.day,0,0,0), DateTime(now!.year,now!.month,now!.day,23,59,59));
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
      backgroundColor: bgcolor,
      body:  Column(
        children: [
          AppBar('Summary'),
          Padding(
            padding: const EdgeInsets.only(left: 18.0,right: 18,bottom: 18),
            child: Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                InkWell(
                  onTap: (){
                    setState(() {
                      index=0;
                      getTransaction(DateTime(now!.year,now!.month,now!.day,0,0,0), DateTime(now!.year,now!.month,now!.day,23,59,59));

                    });


                  },
                  child: Container(
                    height: width*0.15,
                    width: width*0.45,
                    decoration:BoxDecoration(
                      // color: Color(0xffFF808B),
                      color:index==0?primarycolor1:Colors.white,
                      borderRadius: BorderRadius.circular(10)

                    ),

                    child: Column(
                      mainAxisAlignment: MainAxisAlignment.center,

                      children: [
                        Center(
                          child: Text('Daily',style: GoogleFonts.poppins(
                              fontSize: 15,
                            color: index==0? Colors.white:primarycolor1,
                            fontWeight: FontWeight.w600
                          ),),
                        ),

                      ],
                    ),
                  ),
                ),
                InkWell(
                  onTap: (){
                    showMonthPicker(
                      context: context,
                      initialDate: DateTime.now(), // Today's date
                      firstDate: DateTime(2000, 5), // Stating date : May 2000
                      lastDate: DateTime(2050),
                      // Ending date: Dec 2050
                    ).then((value) {
                      if(value!=null){
                        print(value);
                        DateTime end=DateTime(value.year,value.month+1,0,23,59,59);
                        print(end);
                        getTransaction( value,end);
                      }
                    });
                    setState(() {
                      index=1;
                    });
                  },
                  child: Container(
                    height: width*0.15,
                    width: width*0.45,
                    decoration:BoxDecoration(
                        color:index==1?primarycolor1:Colors.white,
                      borderRadius: BorderRadius.circular(10)

                    ),

                    child: Column(
                      mainAxisAlignment: MainAxisAlignment.center,

                      children: [
                        Center(
                          child: Text('Monthly',style: GoogleFonts.poppins(
                              fontSize: 15,
                              color:index==1? Colors.white:primarycolor1 ,
                          ),),
                        ),

                      ],
                    ),
                  ),
                ),


              ],
            ),
          ),
          Padding(
            padding: const EdgeInsets.only(left: 18.0,right: 18),
            child: Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                Container(
                  height: width*0.2,
                  width: width*0.25,
                  decoration:BoxDecoration(
                    // color: Color(0xffFF808B),
                    color: primarycolor1,
                    borderRadius: BorderRadius.circular(10)

                  ),

                  child: Column(
                    mainAxisAlignment: MainAxisAlignment.center,

                    children: [
                      Center(
                        child: Text('SALES',style: GoogleFonts.poppins(
                            fontSize: 12,
                          color: Colors.white,
                          fontWeight: FontWeight.w600
                        ),),
                      ),
                      SizedBox(height: 5,),
                      Center(
                        child: Text(totalSalesmount.toStringAsFixed(2),style: GoogleFonts.poppins(
                            fontSize: 17,
                          color: Colors.white,
                          fontWeight: FontWeight.w600
                        ),),
                      ),
                    ],
                  ),
                ),
                Container(
                  height: width*0.2,
                  width: width*0.25,
                  decoration:BoxDecoration(
                      color: primarycolor1,
                    borderRadius: BorderRadius.circular(10)

                  ),

                  child: Column(
                    mainAxisAlignment: MainAxisAlignment.center,

                    children: [
                      Center(
                        child: Text('RECEIVED',style: GoogleFonts.poppins(
                            fontSize: 12,
                            color: Colors.white,
                            fontWeight: FontWeight.w600
                        ),),
                      ),
                      SizedBox(height: 5,),
                      Center(
                        child: Text(totalRecievedmount.toStringAsFixed(2),style: GoogleFonts.poppins(
                            fontSize: 17,
                            color: Colors.white,
                            fontWeight: FontWeight.w600
                        ),),
                      ),
                    ],
                  ),
                ),
                Container(
                  height: width*0.2,
                  width: width*0.25,
                  decoration:BoxDecoration(
                      color: primarycolor1,
                    borderRadius: BorderRadius.circular(10)

                  ),

                  child: Column(
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: [
                      Center(
                        child: Text('CREDIT',style: GoogleFonts.poppins(
                            fontSize: 12,
                            color: Colors.white,
                            fontWeight: FontWeight.w600
                        ),),
                      ),
                      SizedBox(height: 5,),
                      Center(
                        child: Text(totalCredit.toStringAsFixed(2),style: GoogleFonts.poppins(
                            fontSize: 17,
                            color: Colors.white,
                            fontWeight: FontWeight.w600
                        ),),
                      ),
                    ],
                  ),
                ),

              ],
            ),
          ),

          statement.length ==0?Container(
            // height: width ,
            child: Center(
              child: Text('No transaction found',
                style:  GoogleFonts.montserrat(color:primarycolor1,fontWeight: FontWeight.w700,fontSize: 14),),
            ),
          ): Expanded(
            child: ListView.builder(
                shrinkWrap: true,
                scrollDirection: Axis.vertical,
                physics: BouncingScrollPhysics(),
                itemCount:statement.length ,
                itemBuilder: (context,index){
                  return  Padding(
                    padding: const EdgeInsets.all(8.0),
                    child: Container(
                      padding: EdgeInsets.only(right: 10),
                      height: 80,
                      width: 200,
                      decoration: BoxDecoration(
                        borderRadius: BorderRadius.circular(10),
                        color: Color(0xffFBFBFB),
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
                              SizedBox(width: 10,),
                              Column(
                                crossAxisAlignment: CrossAxisAlignment.start,
                                children: [
                                  SizedBox(height: 10,),
                                  Text(statement[index].customerName,
                                    style:  GoogleFonts.montserrat(color:primarycolor1,fontWeight: FontWeight.w700,fontSize: 14),),

                                  // Text(statement[index].shopName??"",
                                  //   style: TextStyle(color:Color(0xff5E5F5F),fontWeight: FontWeight.w700,fontSize: 14),),
                                  SizedBox(height: 5,),

                                  // Text(statement[index].bookName??"",
                                  //   style: TextStyle(color:Color(0xff5E5F5F),fontWeight: FontWeight.w700,fontSize: 14),),
                                  SizedBox(height: 5,),

                                  Text(DateFormat('dd MMM yyyy').format(statement[index].toJson().containsKey('date')?statement[index].date:statement[index].date),
                                    style:  GoogleFonts.montserrat(color:Colors.black,fontWeight: FontWeight.w600,fontSize: 11),),

                                ],
                              )
                            ],
                          ),
                          Row(
                            children: [
                              Text("${statement[index].currencyShort.toString()}", style: GoogleFonts.montserrat(color:statement[index].toJson().containsKey('purchaseId')?Colors.black:Colors.green,fontWeight: FontWeight.w600,fontSize: 15),),
                              SizedBox(width: 3,),
                              Text("${statement[index].amount.toStringAsFixed(2)}", style: GoogleFonts.montserrat(color:statement[index].toJson().containsKey('purchaseId')?Colors.black:Colors.green,fontWeight: FontWeight.w600,fontSize: 15),),
                            ],
                          ),
                          // SizedBox(width: 5,),


                        ],
                      ),

                    ),
                  );
                }),
          )
        ],
      ),
    );
  }
}
