import 'dart:developer';

import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:intl/intl.dart';

import '../../../../Model/TransactionModel/transactionModel.dart';
import '../../../../core/utils/utils.dart';
import '../../../../themes/color.dart';
import '../../../Home/screen/selectShop.dart';
import '../../../auth/screen/splash.dart';




class AllTransactionsList extends StatefulWidget {
  const AllTransactionsList({Key? key}) : super(key: key);

  @override
  State<AllTransactionsList> createState() => _AllTransactionsListState();
}

class _AllTransactionsListState extends State<AllTransactionsList> {
  List<TransactionModel>transactions=[];
  getTransactions(){
    print(fromdate);
    print(todate);
    FirebaseFirestore.instance.collectionGroup('transactions')
        .where('shopId',isEqualTo: currentshopId)
        .where('date',isGreaterThanOrEqualTo: Timestamp.fromDate(fromdate!))
        .where('date',isLessThanOrEqualTo: Timestamp.fromDate(todate!)).where('delete',isEqualTo: false)
        .get()
        .then((value) {
      transactions=[];
      for(var data in value.docs){
        transactions.add(TransactionModel.fromJson(data.data()));
        print(transactions);


      }
      transactions.sort((b, a) => a.date!.compareTo(b.date!));
      if(mounted){
        setState(() {

        });
      }

    });
  }

  DateTime todate =DateTime.now();
  var pickDate;

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
                  SizedBox(width: width*0.02,),
                  Text(
                    title,
                    style: GoogleFonts.montserrat(
                        fontSize: 20,
                        color: primarycolor1,
                        fontWeight: FontWeight.w600),
                  ),
                  SvgPicture.asset("assets/icons/transaction.svg")
                  // SizedBox(.
                  //   width: 10,
                  // ),
                ],
              ),
            ),
          ),
        ],
      ),
    );
  }

  DateTime? fromdate;
  Future<void> _selectedFromDate(BuildContext context) async {
    final DateTime? picked = await showDatePicker(
        context: context,
        initialDate: DateTime.now(),
        firstDate: DateTime(2015,8),
        lastDate: DateTime.now());
    if (picked != null && picked != fromdate)
      setState(() {
        fromdate = picked;
      });
  }

  // DateTime selectedToDate = DateTime.now();
  Future<void> _selectedToDate(BuildContext context) async {
    final DateTime? picked = await showDatePicker(
        context: context,
        initialDate: DateTime.now(),
        firstDate: DateTime(2015,8),
        lastDate: DateTime.now());
    if (picked != null && picked != todate)
      setState(() {
        todate = DateTime(picked.year,picked.month,picked.day,23,59,59);;
      });
  }

  @override
  void initState() {
    DateTime select=DateTime.now();
    // fromdate =  DateTime(select.year,select.month,1,0,0,0);
    fromdate =   DateTime(select.year,select.month,select.day,0,0,0);
    todate =  DateTime.now();
    getTransactions();
    super.initState();
  }



  @override
  Widget build(BuildContext context) {
    log('object');
    return Scaffold(
      backgroundColor: bgcolor,
      body: Column(
            children: [
              AppBar("TRANSACTION"),

              SizedBox(
                height: width * 0.05,
              ),
              Container(
                width: width*0.9,
                // height: width*0.5,
                decoration: BoxDecoration(
                  color: Colors.white,
                  borderRadius: BorderRadius.circular(6),
                ),
                child: Column(
                  children: [
                    SizedBox(height: width*0.04,),
                    Row(
                      mainAxisAlignment: MainAxisAlignment.spaceAround,
                      children: [
                        // Column(
                        //   children: [
                        //     Text('From',style: GoogleFonts.poppins(color: primarycolor2),),
                        //     InkWell(
                        //       onTap: () async {
                        //         final datePick = await showDatePicker(
                        //             context: context,
                        //             initialDate: date,
                        //             firstDate: DateTime(2020),
                        //             lastDate: DateTime(3020));
                        //         if (datePick != null && datePick != pickDate) {
                        //           setState(() {
                        //             date = datePick;
                        //             fromDateSelected = true;
                        //             fromdate = DateTime(date.year,date.month,date.day,0,0,0);
                        //           });
                        //         }
                        //       },
                        //       child: Container(
                        //         width: width * 0.3,
                        //         height: width * 0.1,
                        //         decoration: BoxDecoration(
                        //             border: Border.all(color: primarycolor1),
                        //             borderRadius: BorderRadius.all(Radius.circular(10))),
                        //         child: Center(
                        //           child: Text(
                        //             "${fromdate.day}/${fromdate.month}/${fromdate.year} ",
                        //             style: TextStyle(
                        //                 fontSize: width * 0.05, color: primarycolor2),
                        //           ),
                        //         ),
                        //       ),
                        //     ),
                        //   ],
                        // ),
                        // Column(
                        //   children: [
                        //     Text('To',style: GoogleFonts.poppins(color: primarycolor2),),
                        //     InkWell(
                        //       onTap: () async {
                        //         final datePick = await showDatePicker(
                        //             context: context,
                        //             initialDate: date,
                        //             firstDate: DateTime(2020),
                        //             lastDate: DateTime(3020));
                        //         if (datePick != null && datePick != pickDate) {
                        //           setState(() {
                        //             date = datePick;
                        //             toDateSelected = true;
                        //             todate =  DateTime(date.year,date.month,date.day,23,59,59);
                        //             getTransactions();
                        //           });
                        //         }
                        //       },
                        //       child: Container(
                        //         width: width * 0.3,
                        //         height: width * 0.1,
                        //         decoration: BoxDecoration(
                        //             border: Border.all(color: primarycolor1),
                        //             borderRadius: BorderRadius.all(Radius.circular(10))),
                        //         child: Center(
                        //           child: Text(
                        //             "${todate.day}/${todate.month}/${todate.year} ",
                        //             style: TextStyle(
                        //                 fontSize: width * 0.05, color: primarycolor2),
                        //           ),
                        //         ),
                        //       ),
                        //     ),
                        //   ],
                        // ),
                        InkWell(
                          onTap: () {
                            _selectedFromDate(context);
                          },
                          child: SizedBox(
                            child: Column(
                              children: [
                                Row(
                                  children: [
                                    Text("FROM",
                                      style: GoogleFonts.montserrat(
                                        color: Colors.black,
                                        fontWeight: FontWeight.w700,
                                        fontSize: 13,
                                      ),
                                    ),
                                    SizedBox(width: width*0.01,),
                                    SvgPicture.asset("assets/icons/date.svg",
                                      color: primarycolor1,
                                      width: width*0.045,
                                    ),

                                  ],
                                ),
                                SizedBox(height: width*0.03,),
                                Text(
                                  // selectedFromDate==DateTime.now()?
                                  DateFormat('dd/MM/yyyy').format(fromdate!),
                                  // :DateFormat('dd/MM/yyyy').format(selectedFromDate),
                                  style: GoogleFonts.montserrat(
                                    color: Colors.black,
                                    fontWeight: FontWeight.w600,
                                    fontSize: 20,
                                  ),
                                ),
                              ],
                            ),
                          ),
                        ),
                        SizedBox(width:width*0.2,),
                        InkWell(
                          onTap: () {
                            _selectedToDate(context);
                          },
                          child: SizedBox(
                            child: Column(
                              children: [
                                Row(
                                  children: [
                                    Text("TO",
                                      style: GoogleFonts.montserrat(
                                        color: Colors.black,
                                        fontWeight: FontWeight.w700,
                                        fontSize: 13,
                                      ),
                                    ),
                                    SizedBox(width: width*0.01,),
                                    SvgPicture.asset("assets/icons/date.svg",
                                      color: primarycolor1,
                                      width: width*0.045,
                                    ),

                                  ],
                                ),
                                SizedBox(height: width*0.03,),
                                Text(DateFormat('dd/MM/yyyy').format(todate),
                                  style: GoogleFonts.montserrat(
                                    color: Colors.black,
                                    fontWeight: FontWeight.w600,
                                    fontSize: 20,
                                  ),
                                ),
                              ],
                            ),
                          ),
                        ),
                      ],
                    ),
                    SizedBox(
                      height: width*0.08,
                    ),
                    InkWell(
                      onTap: () {
                        getTransactions();
                      },
                      child: Container(
                        width: width*0.4,
                        height: width*0.1,
                        decoration: BoxDecoration(
                          color: primarycolor1,
                          borderRadius:  BorderRadius.circular(6),
                        ),
                        child: Center(
                          child: Text("SELECT",
                            style: GoogleFonts.montserrat(
                              color: Colors.white,
                              fontWeight: FontWeight.w700,
                              fontSize: 15,
                            ),
                          ),
                        ),
                      ),
                    ),
                    SizedBox(height: width*0.04,),
                  ],
                ),
              ),
              transactions.length==0
                  ? Center(
                child: Padding(
                  padding: const EdgeInsets.only(top: 60),
                  child: Text('No Transactions History',style: GoogleFonts.montserrat(color: primarycolor2),),
                ),
              )
                  : Expanded(
                    // width: double.infinity,
                    child: ListView.builder(
                      shrinkWrap: true,
                      scrollDirection: Axis.vertical,
                      physics: BouncingScrollPhysics(),
                      itemCount: transactions.length,
                      itemBuilder: (context, index) {
                        TransactionModel data = transactions[index];
                        return Padding(
                          padding: const EdgeInsets.only(top: 20,left: 10, right: 10),
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
                                      SizedBox(
                                        width: width*0.03,
                                      ),
                                      Column(
                                        crossAxisAlignment: CrossAxisAlignment.start,
                                        children: [
                                          SizedBox(
                                            height: 15,
                                          ),
                                          Text(
                                            data.customerName!,
                                            style: GoogleFonts.montserrat(
                                                fontSize: 13,
                                                fontWeight: FontWeight.w700,
                                                color: Color(0xff464646)),
                                          ),
                                          Row(
                                            children: [
                                              Text(
                                                DateFormat('dd MMM yyyy').format(data.date!),
                                                style: GoogleFonts.montserrat(
                                                    fontSize: 10,
                                                    fontWeight: FontWeight.w400,
                                                    color: Color(0xff464646)),
                                              ),
                                              SizedBox(
                                                width: 10,
                                              ),
                                              Text(
                                                DateFormat('jms').format(data.date!),
                                                style: GoogleFonts.montserrat(
                                                    fontSize: 10,
                                                    fontWeight: FontWeight.w400,
                                                    color: Color(0xff464646)),
                                              ),
                                            ],
                                          ),
                                        ],
                                      ),
                                    ],
                                  ),
                                  Container(
                                    width: 100,
                                    child: Center(
                                      child: Text(
                                        "${data.currencyShort!} ${data.amount!.toStringAsFixed(2)}",
                                        style: GoogleFonts.montserrat(
                                            fontSize: 17,
                                            fontWeight: FontWeight.w600,
                                            color: primarycolor1),
                                      ),
                                    ),
                                  ),

                                ],
                              ),
                            ),
                          ),
                        );
                      },
                    ),
                  ),
            ],
          ),

    );
  }
}