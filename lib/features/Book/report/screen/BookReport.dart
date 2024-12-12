import 'dart:async';
import 'dart:io';

import 'package:cached_network_image/cached_network_image.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:csv/csv.dart';
import 'package:flutter/material.dart';
import 'package:flutter_month_picker/flutter_month_picker.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:intl/intl.dart';
import 'package:path_provider/path_provider.dart';
import 'package:share_plus/share_plus.dart';

import '../../../../Model/TransactionModel/transactionModel.dart';
import '../../../../Model/purchase/purchaseModel.dart';
import '../../../../core/utils/utils.dart';
import '../../../../themes/color.dart';
import '../../../Home/screen/selectShop.dart';
import '../../../auth/screen/splash.dart';



class BookReportPage extends StatefulWidget {
  final String? bookId;
  const BookReportPage({Key? key, this. bookId}) : super(key: key);

  @override
  State<BookReportPage> createState() => _BookReportPageState();
}

class _BookReportPageState extends State<BookReportPage> with TickerProviderStateMixin {
  // String generateCsvData(List statement) {
  //   List<List<dynamic>> csvData = [
  //     // Add header row
  //     ['Customer Name', 'Date', 'Currency', 'Amount']
  //   ];
  //
  //   // Add data rows
  //   for (var item in statement) {
  //     String customerName = item.customerName ?? '';
  //     String date = DateFormat('dd MMM yyyy').format(item.toJson().containsKey('date') ? item.date : item.date);
  //     String currency = item.currencyShort.toString();
  //     String amount = item.amount.toString();
  //     print(customerName);
  //     print('customerName');
  //     print(customerName);
  //     print('customerName');
  //
  //     csvData.add([customerName, date, currency, amount]);
  //   }
  //
  //   // Convert to CSV format
  //   return ListToCsvConverter().convert(csvData);
  // }
  // Future<void> saveCsvFile(String csvData) async {
  //   final directory = await getApplicationDocumentsDirectory();
  //   final file = File('${directory.path}/statement.csv');
  //
  //   await file.writeAsString(csvData);
  // }
  // void shareStatement() async {
  //   String csvData = generateCsvData(statement);
  //   await saveCsvFile(csvData);
  //
  //   final directory = await getApplicationDocumentsDirectory();
  //   final file = File('${directory.path}/statement.csv');
  //
  //   if (file.existsSync()) {
  //     // Share the file via WhatsApp
  //     try {
  //       await Share.shareFiles([file.path], text: 'Statement');
  //     } catch (e) {
  //       print('Sharing failed: $e');
  //     }
  //   }
  // }

  String generateCsvData(List statement) {
    List<List<dynamic>> csvData = [
      // Add header row
      ['Customer Name', 'Date', 'Amount','Type']
    ];

    // Add data rows
    for (var item in statement) {
      String customerName = item.customerName ?? '';
      String date = DateFormat('dd-MM-yy').format(
          item.toJson().containsKey('date') ? item.date : item.date
      );
      // String currency = item.currencyShort.toString();
      String amount = item.amount.toString();
      String Type = item.type==0?'Purchase':'Transaction';



      csvData.add([customerName, date, amount,Type]);

    }

    // Convert to CSV format
    return ListToCsvConverter().convert(csvData);
  }

  Future<void> saveCsvFile(String csvData) async {
    final directory = await getApplicationDocumentsDirectory();
    final file = File('${directory.path}/statement.csv');

    await file.writeAsString(csvData);
  }

  void shareStatement() async {
    String csvData = generateCsvData(statement);
    await saveCsvFile(csvData);

    final directory = await getApplicationDocumentsDirectory();
    final file = File('${directory.path}/statement.csv');

    if (file.existsSync()) {
      // Share the file via WhatsApp using share_plus package
      try {
        await Share.shareFiles([file.path], text: 'Statement');
      } catch (e) {
        print('Sharing failed: $e');
      }
    }
  }



  DateTime ?today;

  DateTime fromdate =DateTime.now();
  DateTime todate =DateTime.now();
  bool fromDateSelected = false;
  bool toDateSelected = false;
  var pickDate;
  DateTime date = DateTime.now();
  List statement=[];

  List<TransactionModel> allTransaction=[];
  List<PurchaseModel> allPurchase=[];
  StreamSubscription? a;
  StreamSubscription? b;
  getTransaction(DateTime from,DateTime to){
   a= FirebaseFirestore.instance.collectionGroup('transactions')
        .where('shopId',isEqualTo: currentshopId)
        .where('bookId',isEqualTo: widget.bookId)
        .where('date',isGreaterThanOrEqualTo: from)
        .where('date',isLessThanOrEqualTo: to).where('delete',isEqualTo: false).
    orderBy('date',descending: true)
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
        .where('bookId',isEqualTo: widget.bookId)
        .where('date',isGreaterThanOrEqualTo: from)
        .where('date',isLessThanOrEqualTo: to).where('delete',isEqualTo: false).
    orderBy('date',descending: true)
        .snapshots()
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
          print(allPurchase.length);
          print('allPurchase');

        });
      }

    });


    // statement.followedBy(allTransaction);


  }

  double totalSalesmount=0.0;
  double totalRecievedmount=0.0;
  double totalCredit=0.0;
  int index=0;
  DateTime? now ;

  late TabController _tabController;
  @override
  void initState() {
    // DateTime select=DateTime.now();
    now=DateTime.now();

    _tabController = TabController(length: 2, vsync: this, initialIndex: 0);
    getTransaction(DateTime(now!.year,now!.month,now!.day,0,0,0), DateTime(now!.year,now!.month,now!.day,23,59,59));
    // getPurchases();
    super.initState();
  }
  @override
  void dispose() {
    a?.cancel();
    b?.cancel();
    super.dispose();
  }

  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title:  Text('TRANSACTIONS',
          style: GoogleFonts.montserrat(color:primarycolor1,fontWeight: FontWeight.w700,fontSize: 14),),

        leading: IconButton(
          onPressed: () {
            Navigator.pop(context);
          },

          icon: Icon(Icons.arrow_back_ios,color: primarycolor2,),
        ),
        backgroundColor: Colors.white,
        elevation: 0,
        actions: [
          statement.length!=0?Padding(
            padding: const EdgeInsets.only(right: 18.0),
            child: IconButton(
              icon: Icon(Icons.share,color: Colors.green,size: 35,),
              onPressed: () => shareStatement(),
            ),
          ):Container()

        ],
      ),
      body: Column(
        children: [
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
          SizedBox(
            height: width * 0.015,
          ),
          statement.length ==0
              ?Container(
            height: width*0.5 ,
            child: Center(
              child: Text('No transaction found',
                style:  GoogleFonts.montserrat(color:primarycolor1,fontWeight: FontWeight.w700,fontSize: 14),),
            ),
          )
              :Expanded(
                child: ListView.builder(
                shrinkWrap: true,
                scrollDirection: Axis.vertical,
                physics: BouncingScrollPhysics(),
                itemCount:statement.length ,
                itemBuilder: (context,index){
                  return Padding(
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
