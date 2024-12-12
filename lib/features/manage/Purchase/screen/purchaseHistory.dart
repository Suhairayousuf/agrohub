import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:flutter_svg/svg.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:intl/intl.dart';

import '../../../../Model/purchase/purchaseModel.dart';
import '../../../../core/utils/utils.dart';
import '../../../../themes/color.dart';
import '../../../Home/screen/selectShop.dart';
import '../../../auth/screen/splash.dart';




class AllPurchasesList extends StatefulWidget {
  const AllPurchasesList({Key? key}) : super(key: key);

  @override
  State<AllPurchasesList> createState() => _AllPurchasesListState();
}

class _AllPurchasesListState extends State<AllPurchasesList> {
  List<PurchaseModel>purchase=[];
  double totalSales=0;
  getPurchases(){

    FirebaseFirestore.instance.collectionGroup('purchase')
        .where('shopId',isEqualTo: currentshopId).where('delete',isEqualTo: false)
        .where('date',isGreaterThanOrEqualTo: Timestamp.fromDate(fromdate!))
        .where('date',isLessThanOrEqualTo: Timestamp.fromDate(todate)).get().then((value) {
      purchase=[];
      totalSales=0;
          for(var data in value.docs){
            purchase.add(PurchaseModel.fromJson(data.data()));
            totalSales+=data['amount'];
          }
      purchase.sort((b, a) => a.date!.compareTo(b.date!));
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
              // color: Colors.red,
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
                  SizedBox(width: width*0.05,),
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

  Future<void> _selectedToDate(BuildContext context) async {
    final DateTime? picked = await showDatePicker(
        context: context,
        initialDate: DateTime.now(),
        firstDate: DateTime(2015,8),
        lastDate: DateTime.now());
    if (picked != null && picked != todate)
      setState(() {
        todate = DateTime(picked.year,picked.month,picked.day,23,59,59);
      });
  }

  @override
  void initState() {
    DateTime select=DateTime.now();
    fromdate =   DateTime(select.year,select.month,select.day,0,0,0);

    // fromdate =   DateTime(select.year,select.month,1,0,0,0);
    todate =  DateTime.now();
    getPurchases();
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: bgcolor,
      body:  Column(
        children: [
          AppBar("SALES"),


          SizedBox(
            height: width * 0.03,
          ),
          Container(
            width: width*0.9,
            // height: width*0.5,
            decoration: BoxDecoration(
              color: Colors.white,
              borderRadius: BorderRadius.circular(6),
            ),
            child: SingleChildScrollView(
              child: Column(
                children: [
                  SizedBox(height: width*0.04,),
                  Row(
                    mainAxisAlignment: MainAxisAlignment.spaceAround,
                    children: [
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
                              Text(
                                DateFormat('dd/MM/yyyy').format(todate),
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
                      getPurchases();
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
          ),
          Padding(
            padding: const EdgeInsets.all(20),
            child: Row(
              mainAxisAlignment: MainAxisAlignment.end,
              children: [


                Padding(
                  padding:  EdgeInsets.only(right: 20.0,top: 10),
                  child: Text.rich(
                    TextSpan(
                      children: [
                        TextSpan(text: 'TOTAL :  ',
                          style: GoogleFonts.montserrat(color:Colors.black,fontWeight: FontWeight.w700,fontSize: 25),
                        ),
                        TextSpan(text: 'QAR.'),
                        TextSpan(
                          // Text((data.credit??0).toStringAsFixed(2),
                          // style:  GoogleFonts.montserrat(color:Colors.black,fontWeight: FontWeight.w900,fontSize: 20),);
                          text: totalSales.toStringAsFixed(2),
                          style: GoogleFonts.montserrat(color:Colors.black,fontWeight: FontWeight.w700,fontSize: 23),
                        ),
                      ],
                    ),
                  ),
                )
              ],
            ),
          ),
          // Row(
          //   mainAxisAlignment: MainAxisAlignment.spaceEvenly,
          //   children: [
          //     Column(
          //       children: [
          //         Text('From',style: GoogleFonts.poppins(color: primarycolor2),),
          //         InkWell(
          //           onTap: () async {
          //             final datePick = await showDatePicker(
          //                 context: context,
          //                 initialDate: date,
          //                 firstDate: DateTime(2020),
          //                 lastDate: DateTime(3020));
          //             if (datePick != null && datePick != pickDate) {
          //               setState(() {
          //                 date = datePick;
          //
          //                 fromdate = DateTime(date.year,date.month,date.day,0,0,0);
          //               });
          //             }
          //           },
          //           child: Container(
          //             width: width * 0.3,
          //             height: width * 0.1,
          //             decoration: BoxDecoration(
          //                 border: Border.all(color: primarycolor1),
          //                 borderRadius: BorderRadius.all(Radius.circular(10))),
          //             child: Center(
          //               child: Text(
          //                 "${fromdate.day}/${fromdate.month}/${fromdate.year} ",
          //                 style: TextStyle(
          //                     fontSize: width * 0.05, color: primarycolor2),
          //               ),
          //             ),
          //           ),
          //         ),
          //       ],
          //     ),
          //     Column(
          //       children: [
          //         Text('To',style: GoogleFonts.poppins(color: primarycolor2),),
          //         InkWell(
          //           onTap: () async {
          //             final datePick = await showDatePicker(
          //                 context: context,
          //                 initialDate: date,
          //                 firstDate: DateTime(2020),
          //                 lastDate: DateTime(3020));
          //             if (datePick != null && datePick != pickDate) {
          //               setState(() {
          //                 date = datePick;
          //
          //                 todate =  DateTime(date.year,date.month,date.day,23,59,59);
          //                 getPurchases();
          //               });
          //             }
          //           },
          //           child: Container(
          //             width: width * 0.3,
          //             height: width * 0.1,
          //             decoration: BoxDecoration(
          //                 border: Border.all(color: primarycolor1),
          //                 borderRadius: BorderRadius.all(Radius.circular(10))),
          //             child: Center(
          //               child: Text(
          //                   "${todate.day}/${todate.month}/${todate.year} ",
          //                 style: TextStyle(
          //                     fontSize: width * 0.05, color: primarycolor2),
          //               ),
          //             ),
          //           ),
          //         ),
          //       ],
          //     ),
          //   ],
          // ),
          // SizedBox(
          //   height: width * 0.04,
          // ),
          // Expanded(
          //   child: ListView.builder(
          //     shrinkWrap: true,
          //     scrollDirection: Axis.vertical,
          //     physics: NeverScrollableScrollPhysics(),
          //     itemCount: purchase.length,
          //     itemBuilder: (context, index) {
          //       PurchaseModel data = purchase[index];
          //       return Padding(
          //         padding: const EdgeInsets.only(top: 20,left: 10, right: 10),
          //         child: Container(
          //           height: height * 0.11,
          //           width: width * 0.89,
          //           decoration: BoxDecoration(
          //             borderRadius: BorderRadius.circular(9),
          //             color: Colors.white,
          //             boxShadow: const [
          //               BoxShadow(
          //                 color: Color.fromRGBO(0, 0, 0, 0.1), // shadow color
          //                 blurRadius: 15, // shadow radius
          //                 offset: Offset(5, 10), // shadow offset
          //                 spreadRadius: 0.4, // The amount the box should be inflated prior to applying the blur
          //                 blurStyle: BlurStyle.normal, // set blur style
          //               ),
          //             ],
          //           ),
          //           child: Padding(
          //             padding: const EdgeInsets.all(8.0),
          //             child: Row(
          //               mainAxisAlignment: MainAxisAlignment.spaceBetween,
          //               crossAxisAlignment: CrossAxisAlignment.center,
          //               children: [
          //                 Column(
          //                   crossAxisAlignment: CrossAxisAlignment.start,
          //                   children: [
          //                     SizedBox(
          //                       height: 15,
          //                     ),
          //                     Text(
          //                       data.customerName ?? "",
          //                       style: GoogleFonts.poppins(
          //                           fontSize: 18,
          //                           fontWeight: FontWeight.w800,
          //                           color: Color(0xff464646)),
          //                     ),
          //                     Row(
          //                       children: [
          //                         Text(
          //                           DateFormat('dd MMM yyyy').format(data.purchaseDate!),
          //                           style: GoogleFonts.poppins(
          //                               fontSize: 12,
          //                               fontWeight: FontWeight.w500,
          //                               color: Color(0xff464646)),
          //                         ),
          //                         SizedBox(
          //                           width: 10,
          //                         ),
          //                         Text(
          //                           DateFormat('jms').format(data.purchaseDate!),
          //                           style: GoogleFonts.poppins(
          //                               fontSize: 12,
          //                               fontWeight: FontWeight.w500,
          //                               color: Color(0xff464646)),
          //                         ),
          //                       ],
          //                     ),
          //                   ],
          //                 ),
          //                 Container(
          //
          //                   width: 100,
          //                   child: Center(
          //                     child: Text(
          //                       "${data.currencyShort ?? ''} ${data.amount ?? ''}",
          //                       style: GoogleFonts.poppins(
          //                           fontSize: 15,
          //                           fontWeight: FontWeight.w500,
          //                           color: primarycolor1),
          //                     ),
          //                   ),
          //                 ),
          //               ],
          //             ),
          //           ),
          //         ),
          //       );
          //     },
          //   ),
          // ),
          purchase.isEmpty
              ? Container(
            height: width*0.5,


            child: Center(

              child: Text('No purchase History',style: GoogleFonts.poppins(color: primarycolor2),),
            ),
          )
              :Expanded(
            // width: double.infinity,
            child: ListView.builder(
              shrinkWrap: true,
              scrollDirection: Axis.vertical,
              physics: BouncingScrollPhysics(),
              itemCount: purchase.length,
              itemBuilder: (context, index) {
                PurchaseModel data = purchase[index];
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
                                    style: GoogleFonts.poppins(
                                        fontSize: 13,
                                        fontWeight: FontWeight.w700,
                                        color: Color(0xff464646)),
                                  ),
                                  Row(
                                    children: [
                                      Text(
                                        DateFormat('dd MMM yyyy').format(data.date!),
                                        style: GoogleFonts.poppins(
                                            fontSize: 10,
                                            fontWeight: FontWeight.w400,
                                            color: Color(0xff464646)),
                                      ),
                                      SizedBox(
                                        width: 10,
                                      ),
                                      Text(
                                        DateFormat('jms').format(data.date!),
                                        style: GoogleFonts.poppins(
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
                                style: GoogleFonts.poppins(
                                    fontSize: 15,
                                    fontWeight: FontWeight.w500,
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