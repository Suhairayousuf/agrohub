import 'dart:async';
import 'dart:convert';
import 'package:agrohub/features/manage/Transaction/controller/transaction_controller.dart';
import 'package:badges/badges.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_barcode_scanner/flutter_barcode_scanner.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:marquee/marquee.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:badges/badges.dart' as badges;

import '../../../../Model/TransactionModel/transactionModel.dart';
import '../../../../Model/bookModel.dart';
import '../../../../model/purchase/purchaseModel.dart';
import '../../../../core/utils/utils.dart';
import '../../../../themes/color.dart';
import '../../../Account/screen/accountdetailesPage.dart';

import '../../../Book/book/screen/addBook.dart';
import '../../../Book/book/screen/bookList.dart';
import '../../../Book/book/screen/single_book_detailes.dart';
import '../../../Home/screen/homePage.dart';
import '../../../Home/screen/selectShop.dart';

import '../../../Offers/screen/Offers.dart';
import '../../../Offers/screen/offerList.dart';
import '../../../auth/screen/splash.dart';
import '../../../chat/screen/chat_List.dart';
import '../../../customers/screen/customers.dart';
import '../../../shopReports/expense/screen/expenseReport.dart';
import '../../../shopReports/purchase/screen/purchaseReport.dart';

import '../../Purchase/screen/purchaseHistory.dart';
import '../../summary/screen/sales_transaction_summary.dart';
import 'transactionHistory.dart';
List <BookModel> allBooks=[];
class ManagePage extends StatefulWidget {
  const ManagePage({Key? key}) : super(key: key);

  @override
  State<ManagePage> createState() => _ManagePageState();
}

class _ManagePageState extends State<ManagePage> {
  int msgCount=0;

  TextEditingController search = TextEditingController();
  
  bool newPurchases=true;
  bool newExpenses=true;
  getNewStatus() async {
    final localStorage= await SharedPreferences.getInstance();
   newPurchases= localStorage.containsKey('purchases');
   newExpenses= localStorage.containsKey('expenses');
    
  }
  


  double salesAmount=0.0;

  String barcodeScanRes='';
  String scanBarcode = 'Unknown';
  Future<void> scanQR() async {
    String barcodeScanRes;
    // Platform messages may fail, so we use a try/catch PlatformException.
    try {
      barcodeScanRes = await FlutterBarcodeScanner.scanBarcode(
          '#ff6666', 'Cancel', true, ScanMode.QR);

    } on PlatformException {
      barcodeScanRes = 'Failed to get platform version.';
    }


    if (!mounted) return;

    setState(() {
      scanBarcode = barcodeScanRes;
    });
    // print(scanBarcode.split(':')[1]);
    var data;
    await FirebaseFirestore.instance.collection('shops')
        .doc(currentshopId).collection('book').where('delete',isEqualTo: false).
     where('members',arrayContains:scanBarcode.split(':')[1]).get().then((event) {
      for(var doc in event.docs){
        data=BookModel.fromJson(doc.data());
      }

      if(mounted){
        setState(() {

        });
      }


    });
    if(data!.block==false ) {
      Navigator.push(context, MaterialPageRoute(builder: (context) =>
          SingleBookDetailesPage(
            bookData: data,
          ))).then((value) => setState((){}));
    }else{
      showUploadMessage1(context, 'This Book is blocked by irregular transaction', style: GoogleFonts.montserrat(
          color: primarycolor2
      ));
    }


  }
  List carouselImages = [
    'https://www.shutterstock.com/image-vector/colorful-discount-sale-'
        'podium-special-260nw-2055955985.jpg'
  ];

  void signOut() {
    FirebaseAuth.instance.signOut();
    // _auth.signOut(context);
  }
  List<PurchaseModel>purchase=[];
  DateTime? fromdate;
  DateTime todate =DateTime.now();
  //
  //
  // StreamSubscription? a;
  // StreamSubscription? b;
  // StreamSubscription? c;
  // StreamSubscription? d;

  // getPurchases(){
  //
  //  a= FirebaseFirestore.instance.collectionGroup('purchase')
  //       .where('shopId',isEqualTo: currentshopId)
  //       .where('date',isGreaterThanOrEqualTo: fromdate)
  //       .where('date',isLessThanOrEqualTo: todate).where('delete',isEqualTo: false).
  //   snapshots().
  //
  //   listen((value)
  //       {
  //     purchase=[];
  //     salesAmount=0.0;
  //     if(value.docs.isNotEmpty){
  //       for (var data in value.docs) {
  //         purchase.add(PurchaseModel.fromJson(data.data()));
  //         salesAmount += data.get('amount');
  //       }
  //     }
  //     if(mounted){
  //       setState(() {
  //       });
  //     }
  //   });
  // }
  // getTransactions(){
  //
  //  b= FirebaseFirestore.instance.collectionGroup('transactions')
  //       .where('shopId',isEqualTo: currentshopId)
  //       .where('date',isGreaterThanOrEqualTo: fromdate)
  //       .where('date',isLessThanOrEqualTo: todate).where('delete',isEqualTo: false)
  //       .orderBy('date').snapshots()
  //       .listen((value) {
  //
  //
  //     transactions=[];
  //     transactionamount=0;
  //     if(value.docs.isNotEmpty){
  //       for (var data in value.docs) {
  //         transactions.add(TransactionModel.fromJson(data.data()));
  //         transactionamount += data.get('amount');
  //
  //       }
  //     }
  //
  //     if(mounted){
  //       setState(() {
  //
  //       });
  //     }
  //
  //   });
  // }
  List<TransactionModel>transactions=[];

  List customer = [];
  List activeCustomer = [];
  List inactiveCustomer = [];
  Map bookDataByUserId = {};

  // getCustomer() {
  //
  //  c= FirebaseFirestore.instance
  //       .collection('shops')
  //       .doc(currentshopId)
  //       .collection('book').where('delete',isEqualTo: false).snapshots()
  //       .listen((value) {
  //     customer = [];
  //     activeCustomer = [];
  //     inactiveCustomer = [];
  //     allBooks = [];
  //     if(value.docs.isNotEmpty) {
  //       for (var abc in value.docs) {
  //         allBooks.add(BookModel.fromJson(abc.data()));
  //         // if(DateTime.now().difference(abc.get('update').toDate()).inDays>=14){
  //         //   inactiveBooks.add(BookModel.fromJson(abc.data()));
  //         // }
  //         // for(var data in abc['members'] )
  //         customer.addAll(abc.get("members"));
  //         // for (var a in abc.get('members')) {
  //         //   bookDataByUserId[a] = abc.data();
  //         // }
  //         if (abc.get('block') == false) {
  //           for (var user in abc['members']) {
  //             activeCustomer.add(user);
  //           }
  //           //  activeCustomer=abc.get("members");
  //         } else {
  //           for (var item in abc['members']) {
  //             inactiveCustomer.add(item);
  //           }
  //         }
  //       }
  //     }
  //     if (mounted) {
  //       setState(() {});
  //     }
  //   });
  // }

  double totalCredit=0.00;
  // getTotalCredit(){
  //  d= FirebaseFirestore.instance.collection('shops')
  //       .doc(currentshopId).collection('book').where('delete',isEqualTo: false).snapshots()
  //       .listen((event) {
  //     totalCredit=0.00;
  //     if(event.docs.isNotEmpty){
  //       for (var data in event.docs) {
  //         totalCredit += data.get('credit');
  //       }
  //     }
  //     if(mounted){
  //           setState(() {
  //
  //           });
  //         }
  //
  //   });
  // }
  @override
  void initState() {
    getNewStatus();
    DateTime select=DateTime.now();

    fromdate =   DateTime(select.year,select.month,select.day,0,0,0);

    todate =  DateTime.now();
    // getCustomer();
    // getTotalCredit();
    //getPurchases();

    // getTransactions();
    super.initState();
  }
  @override
  void dispose() {
    // a?.cancel();
    // b?.cancel();
    // c?.cancel();
    // d?.cancel();
    super.dispose();
  }
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: bgcolor,
      body: SizedBox(
        width: width,
        height: height,
        child: Stack(
          clipBehavior: Clip.none,
          children: [
            Container(
              width: width * 1,
              height: width * 0.7,
              decoration: const BoxDecoration(
                  image: DecorationImage(
                      image: AssetImage("assets/appBar.png"),
                      fit: BoxFit.cover)),
              child: Padding(
                padding:  const EdgeInsets.only(left: 15,right: 15),
                child: SingleChildScrollView(
                  child: Column(
                    children: [
                      const SizedBox(height: 30,),
                      Row(
                        mainAxisAlignment: MainAxisAlignment.spaceBetween,
                        children: [
                          // SizedBox(
                          //   width: width * 0.025,
                          // ),

                          PopupMenuButton(
                            icon: SvgPicture.asset("assets/icons/menu.svg"),
                            // itemBuilder: (context) {
                            itemBuilder: (context) => [
                              PopupMenuItem(
                                height: 75,
                                child:InkWell(
                                  onTap: (){
                                    Navigator.push(context, MaterialPageRoute(builder: (context)=>const AllTransactionsList()));

                                  },
                                  child: SizedBox(
                                      width: 220,
                                      child: Row(
                                        children: [
                                          SvgPicture.asset("assets/transaction.svg"),
                                          const SizedBox(width: 20,),
                                          Text("TRANSACTIONS ",style: GoogleFonts.montserrat(),),
                                        ],
                                      )),
                                ),
                              ),
                              PopupMenuItem(
                                onTap: () {
                                  // Uri call = Uri.parse('http://wa.me/91${ku!}');
                                  //
                                  // launchUrl(call);
                                },
                                height: 75,
                                child:InkWell(
                                  onTap: (){
                                    Navigator.push(context, MaterialPageRoute(builder: (context)=>const Customer()));

                                  },
                                  child: SizedBox(
                                      width: 220,
                                      child: Row(
                                        children: [
                                          SvgPicture.asset("assets/customers.svg"),
                                          const SizedBox(width: 20,),
                                          Text("CUSTOMERS ",style: GoogleFonts.montserrat(),),
                                        ],
                                      )),
                                ),
                              ),
                              PopupMenuItem(
                                onTap: () {
                                  // Uri call = Uri.parse('http://wa.me/91${ku!}');
                                  //
                                  // launchUrl(call);
                                },
                                height: 75,
                                child:InkWell(
                                  onTap: (){
                                    Navigator.push(context, MaterialPageRoute(builder: (context)=>const SummaryPage()));


                                  },
                                  child: SizedBox(
                                      width: 220,
                                      child: Row(
                                        children: [
                                          SvgPicture.asset("assets/summary.svg"),
                                          const SizedBox(width: 20,),
                                          Text("SUMMARY ",style: GoogleFonts.montserrat(),),
                                        ],
                                      )),
                                ),
                              ),
                              PopupMenuItem(
                                onTap: () {
                                  // Uri call = Uri.parse('http://wa.me/91${ku!}');
                                  //
                                  // launchUrl(call);
                                },
                                height: 75,
                                child:SizedBox(
                                    width: 220,
                                    child: Row(

                                      children: [
                                        // SvgPicture.asset("assets/account.svg"),
                                        const Icon(Icons.wallet_travel),
                                        const SizedBox(width: 20,),
                                        Row(
                                          children: [
                                            Text("WALLET",style: GoogleFonts.montserrat(),),
                                            Text("(coming soon)",style: GoogleFonts.montserrat(
                                                fontSize:10
                                            ),),

                                          ],
                                        ),
                                      ],
                                    )),
                              ),
                              PopupMenuItem(
                                onTap: () {
                                  // Uri call = Uri.parse('http://wa.me/91${ku!}');
                                  //
                                  // launchUrl(call);
                                },
                                height: 75,
                                child:InkWell(
                                  onTap: (){
                                    Navigator.push(context, MaterialPageRoute(builder: (context)=>const OfferList()));

                                  },
                                  child: SizedBox(
                                      width: 220,
                                      child: Row(
                                        children: [
                                          SvgPicture.asset("assets/offers.svg"),
                                          const SizedBox(width: 20,),
                                          Text("OFFERS ",style: GoogleFonts.montserrat(),),
                                        ],
                                      )),
                                ),
                              ),
                              PopupMenuItem(
                                onTap: () {
                                  // Uri call = Uri.parse('http://wa.me/91${ku!}');
                                  //
                                  // launchUrl(call);
                                },
                                height: 75,
                                child:InkWell(
                                  onTap: (){
                                    Navigator.push(context, MaterialPageRoute(builder: (context)=>const BookListPage()));

                                  },

                                  child: SizedBox(
                                      width: 220,
                                      child: Row(
                                        children: [
                                          // SvgPicture.asset("assets/profile.svg"),
                                            Image.asset("assets/icons/report.png",height: 20,width: 20,color: Colors.black,),
                                          const SizedBox(width: 20,),
                                          Text(" REPORT ",style: GoogleFonts.montserrat(),),
                                        ],
                                      )),
                                ),
                              ),
                              PopupMenuItem(
                                onTap: () {
                                  // Uri call = Uri.parse('http://wa.me/91${ku!}');
                                  //
                                  // launchUrl(call);
                                },
                                height: 75,
                                child:InkWell(
                                  onTap: (){
                                    Navigator.push(context, MaterialPageRoute(builder: (context)=>const ProfilePage()));

                                  },

                                  child: SizedBox(
                                      width: 220,
                                      child: Row(
                                        children: [
                                          SvgPicture.asset("assets/profile.svg"),
                                          const SizedBox(width: 20,),
                                          Text(" PROFILE ",style: GoogleFonts.montserrat(),),
                                        ],
                                      )),
                                ),
                              ),





                            ],
                            // return List.generate(7, (index) =>
                            //     PopupMenuItem(
                            //       height: 75,
                            //
                            //         child: Container(
                            //           width: 220,
                            //             child: Text("Button ${index+1}"))));
                          ),
                          Row(
                            children: [
                              InkWell(
                                  onTap: (){
                                    scanQR();
                                  },
                                  child: SvgPicture.asset("assets/icons/scaner.svg")),
                              SizedBox(
                                width: width * 0.05,
                              ),
                              InkWell(
                                  onTap: (){
                                    Navigator.push(context, MaterialPageRoute(builder: (context)=> const HomePage()));
                                  },
                                  child: SvgPicture.asset("assets/icons/phone.svg")),
                              SizedBox(
                                width: width * 0.05,
                              ),

                              InkWell(
                                onTap: (){
                                  Navigator.push(context, MaterialPageRoute(builder: (context)=> const ChatListPage()));
                                },
                                child:
                                // msgCount==0?Icon(Icons.chat_bubble_outline,color: Colors.white,):
                                badges.Badge(

                                  //elevation: 0,
                                    position: BadgePosition.topEnd(top: -5,end: -2),
                                    //padding: EdgeInsetsDirectional.only(end: 0),
                                    // badgeColor: Colors.red,
                                    badgeContent: Padding(
                                      padding: const EdgeInsets.all(1.0),
                                      child: StreamBuilder<QuerySnapshot>(
                                          stream: FirebaseFirestore
                                              .instance
                                              .collectionGroup('chat').where('isRead',isEqualTo: false).
                                          where('receiverId',isEqualTo: currentshopId).snapshots(),
                                          builder: (context, snapshot) {

                                            if(!snapshot.hasData){
                                              return const Text('0',style: TextStyle(fontSize: 8,color: Colors.white));

                                            }
                                            return Text(snapshot.data!.docs.length.toString(),style: const TextStyle(fontSize: 8,color: Colors.white
                                            ),);
                                          }
                                      ),
                                    ),
                                    child: const Icon(Icons.chat_bubble_outline,color: Colors.white,)),

                              ),

                            ],
                          )


                        ],
                      ),
                      const SizedBox(height: 10,),
                      Text(currentshopName!,style: GoogleFonts.montserrat(
                        fontSize: 30,
                        color: Colors.white,
                        fontWeight: FontWeight.w800
                      ),),
                      const SizedBox(height: 10,),
                    ],
                  ),
                ),
              ),
            ),
            // SizedBox(height: 10,),

            Positioned(
              top: width * 0.24,

              child: Container(
                decoration: BoxDecoration(
                  color: bgcolor,
                  borderRadius: BorderRadius.circular(32.11),
                ),
                width: width,
                height: height * 0.8,
                child: SingleChildScrollView(
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.stretch,
                    children: [
                      SizedBox(
                        height: width * 0.03,
                      ),

                      ( (currentshopPlanEnd!.difference(DateTime.now()).inDays)<=7 &&
                          (currentshopPlanEnd!.difference(DateTime.now()).inDays)>0)?SizedBox(
                        height: width * 0.05,
                        child: Marquee(
                          text: 'Your Plan will be expire within ${ currentshopPlanEnd!.difference(DateTime.now()).inDays} days . . .',
                          style: GoogleFonts.montserrat(fontWeight: FontWeight.bold,color: Colors.red),
                          scrollAxis: Axis.horizontal,
                          crossAxisAlignment: CrossAxisAlignment.start,
                          blankSpace: 10.0,
                          velocity: 100.0,
                          pauseAfterRound: const Duration(seconds: 1),
                          startPadding: 10.0,
                          accelerationDuration: const Duration(seconds: 1),
                          accelerationCurve: Curves.linear,
                          decelerationDuration: const Duration(milliseconds: 500),
                          decelerationCurve: Curves.easeOut,

                        ),
                      ): (currentshopPlanEnd!.difference(DateTime.now()).inDays)==0?SizedBox(
                        height: width * 0.05,
                        child: Marquee(
                          text: 'Your Plan will be expire today. Please renew your plan',
                          style: GoogleFonts.montserrat(fontWeight: FontWeight.bold,color: Colors.red),
                          scrollAxis: Axis.horizontal,
                          crossAxisAlignment: CrossAxisAlignment.start,
                          blankSpace: 10.0,
                          velocity: 100.0,
                          pauseAfterRound: const Duration(seconds: 1),
                          startPadding: 10.0,
                          accelerationDuration: const Duration(seconds: 1),
                          accelerationCurve: Curves.linear,
                          decelerationDuration: const Duration(milliseconds: 500),
                          decelerationCurve: Curves.easeOut,

                        ),
                      ):
                      currentshopPlanEnd!.difference(DateTime.now()).inDays<=0?SizedBox(
                        height: width * 0.05,
                        child: Marquee(
                          text: 'Your Plan expired. Please renew your plan',
                          style: GoogleFonts.montserrat(fontWeight: FontWeight.bold,color: Colors.red),
                          scrollAxis: Axis.horizontal,
                          crossAxisAlignment: CrossAxisAlignment.start,
                          blankSpace: 10.0,
                          velocity: 100.0,
                          pauseAfterRound: const Duration(seconds: 1),
                          startPadding: 10.0,
                          accelerationDuration: const Duration(seconds: 1),
                          accelerationCurve: Curves.linear,
                          decelerationDuration: const Duration(milliseconds: 500),
                          decelerationCurve: Curves.easeOut,

                        ),
                      ):Container(),
                      // SizedBox(
                      //   height: width * 0.01,
                      // ),
                      Center(
                        child: InkWell(
                          onTap: (){
                            Navigator.push(context, MaterialPageRoute(builder: (context)=>const SummaryPage()));

                          },
                          child: Container(
                            width: width * 0.82,
                            // height: width * 0.43,
                            decoration: const BoxDecoration(
                              image: DecorationImage(
                                  image: AssetImage("assets/status.png"),
                                  fit: BoxFit.fill),
                            ),
                            child: Padding(
                              padding:  EdgeInsets.only(left: width*0.05,right: width*0.05),
                              child: Column(
                                children: [
                                  SizedBox(
                                    height: width * 0.03,
                                  ),
                                  Row(
                                    mainAxisAlignment:
                                    MainAxisAlignment.spaceBetween,
                                    children: [
                                      Text("SALES(${purchase.length.toString()})",
                                          style: GoogleFonts.montserrat(
                                              fontSize: width * 0.028,
                                              color: Colors.white)),
                                      // Text("DISCOUNT",
                                      //     style: GoogleFonts.montserrat(
                                      //         fontSize: width * 0.029,
                                      //         color: Colors.white)),
                                      Text("PAYMENT(${transactions.length.toString()})",
                                          style: GoogleFonts.montserrat(
                                              fontSize: width *0.028,
                                              color: Colors.white)),
                                    ],
                                  ),
                                  SizedBox(
                                    height: width * 0.01,
                                  ),
                                  Row(
                                    mainAxisAlignment:
                                    MainAxisAlignment.spaceBetween,
                                    children: [
                                      Consumer(
                                      builder: (context,ref,child) {
                                        final purchaseData=ref.watch(getPurchaseProvider);
                                        return purchaseData.when(data: (data) {
                                          if(data.isNotEmpty){
                                            purchase=[];
                                            // transactionamount=0;
                                            double salesAmount=0.0;
                                            for (var doc in data) {
                                              purchase.add(doc);
                                              salesAmount += doc.amount??0;

                                            }
                                            return  Text(salesAmount.toStringAsFixed(2),
                                                style: GoogleFonts.montserrat(
                                                    fontSize: width * 0.045,
                                                    fontWeight: FontWeight.w600,
                                                    color: Colors.white));
                                          }
                                          return Text(salesAmount.toStringAsFixed(2),
                                              style: GoogleFonts.montserrat(
                                                  fontSize: width * 0.045,
                                                  fontWeight: FontWeight.w600,
                                                  color: Colors.white));
                                        },error: (error, stackTrace) => Center(child: Text("df"),),
                                          loading: () => CircularProgressIndicator(),);


                                      },

                                      ),
                                      // Text('0',
                                      //     style: GoogleFonts.montserrat(
                                      //         fontSize: width * 0.04,
                                      //         color: Colors.white)),
                                      Consumer(
                                        builder: (context,ref,child) {
                                          Map a={
                                            "fromdate":fromdate,
                                            "todate":todate
                                          };
                                          final transactionData=ref.watch(getTransactionProvider);
                                          return transactionData.when(data: (data) {

                                            double transactionamount=0.0;
                                            if(data.isNotEmpty){
                                              transactions=[];
                                              // transactionamount=0;
                                               transactionamount=0.0;
                                              for (var doc in data) {
                                                transactions.add(doc);
                                                transactionamount += doc.amount??0;


                                              }
                                              return Text(transactionamount.toStringAsFixed(2),
                                                  style: GoogleFonts.montserrat(
                                                      fontSize: width * 0.045,
                                                      fontWeight: FontWeight.w600,

                                                      color: Colors.white));
                                            }
                                            return Text(transactionamount.toStringAsFixed(2),
                                                style: GoogleFonts.montserrat(
                                                    fontSize: width * 0.045,
                                                    fontWeight: FontWeight.w600,

                                                    color: Colors.white));
                                          }, error: (error, stackTrace) => Center(child: Text("error"),),
                                              loading: () => CircularProgressIndicator(),);
                                        },

                                      ),
                                    ],
                                  ),

                                  // SizedBox(
                                  //   height: width * 0.045,
                                  // ),
                                  Row(
                                    mainAxisAlignment: MainAxisAlignment.center,
                                    children: [
                                      Text("CUSTOMERS",
                                          style: GoogleFonts.montserrat(
                                              fontSize: width * 0.04,
                                              color: Colors.white)),
                                    ],
                                  ),


                                  Consumer(
                                    builder: ( context,  ref,  child) {
                                      final customerData=ref.watch(getCustomerProvider);
                                      return customerData.when(data: (data){
                                        customer = [];
                                        activeCustomer = [];
                                        inactiveCustomer = [];
                                        allBooks = [];
                                        if(data.isNotEmpty) {
                                          for (var abc in data) {
                                            allBooks.add(abc);
                                            // if(DateTime.now().difference(abc.get('update').toDate()).inDays>=14){
                                            //   inactiveBooks.add(BookModel.fromJson(abc.data()));
                                            // }
                                            // for(var data in abc['members'] )
                                            customer.addAll(abc.members!);
                                            // for (var a in abc.get('members')) {
                                            //   bookDataByUserId[a] = abc.data();
                                            // }
                                            if (abc.block == false) {
                                              for (var user in abc.members!) {
                                                activeCustomer.add(user);
                                              }
                                              //  activeCustomer=abc.get("members");
                                            } else {
                                              for (var item in abc.members!) {
                                                inactiveCustomer.add(item);
                                              }
                                            }
                                          }
                                          return Row(
                                            mainAxisAlignment:
                                            MainAxisAlignment.spaceBetween,
                                            children: [
                                              Column(
                                                children: [
                                                  Text(
                                                    "active",
                                                    style: GoogleFonts.montserrat(
                                                        fontSize: width * 0.035,
                                                        color: Colors.white),
                                                  ),
                                                  const SizedBox(height: 5,),
                                                  Text(
                                                    activeCustomer.length.toString(),
                                                    style: GoogleFonts.montserrat(
                                                        fontSize: width * 0.05,
                                                        fontWeight: FontWeight.w600,
                                                        color: Colors.white),
                                                  ),
                                                ],
                                              ),

                                              Column(
                                                children: [
                                                  Text(
                                                    "Inactive",
                                                    style: GoogleFonts.montserrat(
                                                        fontSize: width * 0.035,
                                                        color: Colors.white),
                                                  ),
                                                  Text(
                                                    inactiveCustomer.length.toString(),
                                                    style: GoogleFonts.montserrat(
                                                        fontSize: width * 0.05,
                                                        fontWeight: FontWeight.w600,


                                                        color: Colors.white),
                                                  ),
                                                ],
                                              ),
                                            ],
                                          );
                                        }
                                        return Row(
                                          mainAxisAlignment:
                                          MainAxisAlignment.spaceBetween,
                                          children: [
                                            Column(
                                              children: [
                                                Text(
                                                  "active",
                                                  style: GoogleFonts.montserrat(
                                                      fontSize: width * 0.035,
                                                      color: Colors.white),
                                                ),
                                                const SizedBox(height: 5,),
                                                Text(
                                                  activeCustomer.length.toString(),
                                                  style: GoogleFonts.montserrat(
                                                      fontSize: width * 0.05,
                                                      fontWeight: FontWeight.w600,
                                                      color: Colors.white),
                                                ),
                                              ],
                                            ),

                                            Column(
                                              children: [
                                                Text(
                                                  "Inactive",
                                                  style: GoogleFonts.montserrat(
                                                      fontSize: width * 0.035,
                                                      color: Colors.white),
                                                ),
                                                Text(
                                                  inactiveCustomer.length.toString(),
                                                  style: GoogleFonts.montserrat(
                                                      fontSize: width * 0.05,
                                                      fontWeight: FontWeight.w600,


                                                      color: Colors.white),
                                                ),
                                              ],
                                            ),
                                          ],
                                        );
                                      }, error: (Object error, StackTrace stackTrace) {
                                        return Text('0');
                                      }, loading: () {
                                        return CircularProgressIndicator();

                                      }, );

                                    },

                                  ),
                                  SizedBox(height: width*0.025,),


                                  Row(
                                    mainAxisAlignment:
                                    MainAxisAlignment.center,
                                    children: [
                                      // Text(
                                      //   "TOTAL PAYABLE",
                                      //   style: GoogleFonts.montserrat(
                                      //       fontSize: width * 0.03,
                                      //       color: Colors.white),
                                      // ),
                                      Text(
                                        "TOTAL CREDIT AMOUNT",
                                        style: GoogleFonts.montserrat(
                                            fontSize: width * 0.03,
                                            color: Colors.white),
                                      ),
                                    ],
                                  ),
                                  SizedBox(
                                    height: width * 0.01,
                                  ),
                                  Row(
                                    mainAxisAlignment:
                                    MainAxisAlignment.spaceAround,
                                    children: [
                                      // Text(
                                      //   "20000",
                                      //   style:  GoogleFonts.montserrat(
                                      //       fontSize: width * 0.03,
                                      //       color: Colors.white),
                                      // ),
                                      Consumer(
                                        builder: ( context,  ref,  child) {
                                          final creditData=ref.watch(getTotalCreditProvider);
                                          return creditData.when(data: (data) {
                                            totalCredit=0.00;
                                            if(data.isNotEmpty){
                                              for (var doc in data) {
                                                totalCredit += doc.credit!;
                                              }
                                            }

                                            return Text(
                                              totalCredit.toStringAsFixed(2),
                                              style:  GoogleFonts.montserrat(
                                                  fontSize: width * 0.045,
                                                  fontWeight: FontWeight.w600,
                                                  color: Colors.white),
                                            );
                                          }, error: (Object error, StackTrace stackTrace) {
                                            return Text('error');
                                          }, loading: () {
                                            return CircularProgressIndicator();
                                          });

                                        },

                                      ),
                                    ],
                                  ),

                                ],
                              ),
                            ),
                          ),
                        ),
                      ),
                      SizedBox(
                        height: width * 0.1,
                      ),
                      Row(
                        mainAxisAlignment: MainAxisAlignment.spaceAround,
                        children: [
                          GestureDetector(
                            onTap: () {
                              Navigator.push(
                                context,
                                MaterialPageRoute(
                                  builder: (context) =>  const AddBook(),
                                ),);
                            },
                            child: Container(
                              width: width * 0.3,
                              height: width * 0.25,
                              decoration: BoxDecoration(
                                color: Colors.white,
                                borderRadius: BorderRadius.circular(9),
                              ),
                              child: Column(
                                mainAxisAlignment:
                                MainAxisAlignment.spaceEvenly,
                                children: [
                                  Container(
                                    width: width * 0.15,
                                    height: width * 0.15,
                                    decoration: const BoxDecoration(
                                      image: DecorationImage(
                                          image:
                                          AssetImage("assets/book 1.png"),
                                          fit: BoxFit.contain),
                                    ),
                                  ),
                                  Text("ADD BOOK",
                                      style: GoogleFonts.poppins(
                                          fontWeight: FontWeight.w500,
                                          fontSize: 15,
                                          color: primarycolor1))
                                ],
                              ),
                            ),
                          ),
                          InkWell(
                            onTap: () {
                              Navigator.push(
                                  context,
                                  MaterialPageRoute(
                                    builder: (context) => const AddOffer(),
                                  ));
                            },
                            child: Container(
                              width: width * 0.3,
                              height: width * 0.25,
                              decoration: BoxDecoration(
                                color: Colors.white,
                                borderRadius: BorderRadius.circular(9),
                              ),
                              child: Column(
                                mainAxisAlignment:
                                MainAxisAlignment.spaceEvenly,
                                children: [
                                  Container(
                                    width: width * 0.15,
                                    height: width * 0.15,
                                    decoration: const BoxDecoration(
                                      image: DecorationImage(
                                          image: AssetImage(
                                              "assets/gift (1) 1.png"),
                                          fit: BoxFit.contain),
                                    ),
                                  ),
                                  Text("ADD OFFERS",
                                      style: GoogleFonts.poppins(
                                          fontWeight: FontWeight.w500,
                                          fontSize: 15,
                                          color: primarycolor1))
                                ],
                              ),
                            ),
                          ),
                        ],
                      ),
                      SizedBox(
                        height: width * 0.03,
                      ),
                      Row(
                        mainAxisAlignment: MainAxisAlignment.spaceAround,
                        children: [
                          InkWell(
                            onTap: () {
                              Navigator.push(context, MaterialPageRoute(builder: (context) => const AllPurchasesList(),));
                            },
                            child: Container(
                              width: width * 0.3,
                              height: width * 0.25,
                              decoration: BoxDecoration(
                                color: Colors.white,
                                borderRadius: BorderRadius.circular(9),
                              ),
                              child: Column(
                                mainAxisAlignment:
                                MainAxisAlignment.spaceEvenly,
                                children: [
                                  InkWell(
                                    onTap: () {
                                      Navigator.push(context, MaterialPageRoute(builder: (context) => const AllPurchasesList(),));
                                    },
                                    child: Container(
                                      width: width * 0.15,
                                      height: width * 0.15,
                                      decoration: const BoxDecoration(
                                        image: DecorationImage(
                                            image: AssetImage(
                                                "assets/shopping1.png"),
                                            fit: BoxFit.contain),
                                      ),
                                    ),
                                  ),
                                  Text("SALES",
                                      style: GoogleFonts.poppins(
                                          fontWeight: FontWeight.w500,
                                          fontSize: 15,
                                          color: primarycolor1))
                                ],
                              ),
                            ),
                          ),
                          InkWell(
                            onTap:(){
                              Navigator.push(context, MaterialPageRoute(builder: (context) => const AllTransactionsList(),));
                            },
                            child: Container(
                              width: width * 0.3,
                              height: width * 0.25,
                              decoration: BoxDecoration(
                                color: Colors.white,
                                borderRadius: BorderRadius.circular(9),
                              ),
                              child: Column(
                                mainAxisAlignment:
                                MainAxisAlignment.spaceEvenly,
                                children: [
                                  Container(
                                    width: width * 0.15,
                                    height: width * 0.15,
                                    decoration: const BoxDecoration(
                                      image: DecorationImage(
                                          image: AssetImage(
                                              "assets/transaction (1) 1.png"),
                                          fit: BoxFit.contain),
                                    ),
                                  ),
                                  Text("TRANSACTION",
                                      style: GoogleFonts.poppins(
                                          fontWeight: FontWeight.w500,
                                          fontSize: 15,
                                          color: primarycolor1))
                                ],
                              ),
                            ),
                          ),
                        ],
                      ),
                      SizedBox(
                        height: width * 0.03,
                      ),
                      Row(
                        mainAxisAlignment: MainAxisAlignment.spaceAround,
                        children: [
                          InkWell(
                            onTap: () async {


                              final localStorage= await SharedPreferences.getInstance();

                              localStorage.setBool('purchases', true);
                              newPurchases=true;

                              await Navigator.push(context, MaterialPageRoute(builder: (context) => const PurchaseReport(),));
                            setState(() {

                            });
                            },
                            child: Container(
                              width: width * 0.3,
                              height: width * 0.27,
                              decoration: BoxDecoration(
                                color: Colors.white,
                                borderRadius: BorderRadius.circular(9),
                              ),
                              child: Column(
                                mainAxisAlignment:
                                MainAxisAlignment.spaceEvenly,
                                children: [
                                  Row(
                                    mainAxisAlignment: MainAxisAlignment.end,
                                    children: [

                                      newPurchases?SizedBox(): SizedBox(

                                          child: Image.asset('assets/icons/newgif.gif',width: 20,)),
                                    ],
                                  ),
                                  InkWell(
                                    onTap: () async {

                                      final localStorage= await SharedPreferences.getInstance();

                                      localStorage.setBool('purchases', true);
                                      newPurchases=true;

                                     await Navigator.push(context, MaterialPageRoute(builder: (context) => const PurchaseReport(),));

                                     setState(() {

                                     });
                                    },
                                    child: Container(
                                      width: width * 0.15,
                                      height: width * 0.15,
                                      // decoration:  BoxDecoration(
                                      //   image: DecorationImage(
                                      //       image: SvgPicture.asset(
                                      //           "assets/shopping1.png"),
                                      //       fit: BoxFit.contain),
                                      // ),
                                      child: SvgPicture.asset('assets/icons/purchases.svg'),
                                    ),
                                  ),
                                  Text("PURCHASES",
                                      style: GoogleFonts.poppins(
                                          fontWeight: FontWeight.w500,
                                          fontSize: 15,
                                          color: primarycolor1))
                                ],
                              ),
                            ),
                          ),
                          InkWell(
                            onTap:() async {

                              final localStorage= await SharedPreferences.getInstance();

                              localStorage.setBool('expenses', true);

                              newExpenses=true;

                              await Navigator.push(context, MaterialPageRoute(builder: (context) => const ExpenseReport(),));
                            setState(() {

                            });
                            },
                            child: Container(
                              width: width * 0.3,
                              height: width * 0.27,
                              decoration: BoxDecoration(
                                color: Colors.white,
                                borderRadius: BorderRadius.circular(9),
                              ),
                              child: Column(
                                mainAxisAlignment:
                                MainAxisAlignment.spaceEvenly,
                                children: [
                                  Row(
                                    mainAxisAlignment: MainAxisAlignment.end,
                                    children: [
                                      
                                     newExpenses?SizedBox(): SizedBox(

                                          child: Image.asset('assets/icons/newgif.gif',width: 20,)),
                                    ],
                                  ),
                                  Container(
                                    width: width * 0.15,
                                    height: width * 0.15,
                                    // decoration: const BoxDecoration(
                                    //   image: DecorationImage(
                                    //       image: AssetImage(
                                    //           "assets/icons/expense.svg"),
                                    //       fit: BoxFit.contain),
                                    // ),
                                    child: SvgPicture.asset('assets/icons/expense.svg'),
                                  ),
                                  Text("EXPENSES",
                                      style: GoogleFonts.poppins(
                                          fontWeight: FontWeight.w500,
                                          fontSize: 15,
                                          color: primarycolor1))
                                ],
                              ),
                            ),
                          ),
                        ],
                      ),

                      SizedBox(
                        height: width * 0.03,
                      ),
                      // Row(
                      //   mainAxisAlignment: MainAxisAlignment.spaceAround,
                      //   children: [
                      //     InkWell(
                      //       onTap: () {
                      //         Navigator.push(context, MaterialPageRoute(builder: (context) => const AllPurchasesList(),));
                      //       },
                      //       child: Container(
                      //         width: width * 0.3,
                      //         height: width * 0.25,
                      //         decoration: BoxDecoration(
                      //           color: Colors.white,
                      //           borderRadius: BorderRadius.circular(9),
                      //         ),
                      //         child: Column(
                      //           mainAxisAlignment:
                      //           MainAxisAlignment.spaceEvenly,
                      //           children: [
                      //             InkWell(
                      //               onTap: () {
                      //                 Navigator.push(context, MaterialPageRoute(builder: (context) => const AllPurchasesList(),));
                      //               },
                      //               child: Container(
                      //                 width: width * 0.15,
                      //                 height: width * 0.15,
                      //                 // decoration:  BoxDecoration(
                      //                 //   image: DecorationImage(
                      //                 //       image: SvgPicture.asset(
                      //                 //           "assets/shopping1.png"),
                      //                 //       fit: BoxFit.contain),
                      //                 // ),
                      //                 child: SvgPicture.asset('assets/icons/dailyReport.svg'),
                      //               ),
                      //             ),
                      //             Text("DAILY REPORT",
                      //                 style: GoogleFonts.poppins(
                      //                     fontWeight: FontWeight.w500,
                      //                     fontSize: 15,
                      //                     color: primarycolor1))
                      //           ],
                      //         ),
                      //       ),
                      //     ),
                      //     SizedBox(
                      //
                      //       width: width * 0.3,
                      //       height: width * 0.25,
                      //     ),
                      //   ],
                      // ),

                      SizedBox(
                        height: width * 0.08,
                      ),
                    ],
                  ),
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }
}
