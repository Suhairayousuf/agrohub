import 'dart:developer';
import 'dart:io';

import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:datetime_picker_formfield_new/datetime_picker_formfield.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:intl/intl.dart';
import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter/material.dart';


import '../../../../core/utils/utils.dart';
import '../../../../themes/color.dart';
import '../../../Home/screen/selectShop.dart';

import '../../../auth/screen/splash.dart';
import 'expenseAdd.dart';


// import 'package:wifi/wifi.dart';

class ExpenseReport extends StatefulWidget {
  const ExpenseReport({Key? key}) : super(key: key);

  @override
  _ExpenseReportState createState() => _ExpenseReportState();
}

class _ExpenseReportState extends State<ExpenseReport> {

  getTotalBalance() {
    log('1');
    FirebaseFirestore.instance.collection('shops').get().then((shops) {
      for(DocumentSnapshot shop in shops.docs) {
        shop.reference.collection('book').get().then((books) {
          for(DocumentSnapshot book in books.docs) {
            List members= book['members'];

            double pur=0;
            double tra=0;

            if (members.isNotEmpty) {
              for (String i in members) {
                FirebaseFirestore.instance.collection('users')
                    .where('userEmail',isEqualTo: i) .get().then((value) {
                  if(value.docs.isNotEmpty) {
                    DocumentSnapshot doc = value.docs.first;

                    String company = doc['companyName'].toString().toUpperCase();

                    log('"""company"""');
                    log(company);
                    book.reference.update({
                      'company':company,
                    });

                    // value.docs.first.reference.collection('purchase').get().then((value) {
                    //
                    //
                    //
                    //   // log('===============================================');
                    //   // log('TOTALLLLL BALANCEEE : ${book['credit']}');
                    //   // log('TOTALLLLL PURCHASE : $pur');
                    //   // log('TOTALLLLL TRANSACTIONSSSS : $tra');
                    //   // log('===============================================');
                    //
                    // }).then((q) {
                    //
                    //   value.docs.first.reference.collection('transactions').get().then((value) {
                    //
                    //     for(DocumentSnapshot doc in value.docs){
                    //       tra+=doc['amount'];
                    //     }
                    //
                    //     double credit = book['credit'];
                    //     double bal = (pur-tra).abs();
                    //
                    //     if(credit != bal) {
                    //       log('===============================================');
                    //       log(shop['storeName']);
                    //       log(book['bookName']);
                    //       log('CREDITTTTT BALANCEEE : ${book['credit']}');
                    //       log('TOTALLLLL PURCHASE : $pur');
                    //       log('TOTALLLLL TRANSACTIONSSSS : $tra');
                    //       log('TOTALLLLL BAlance : ${pur-tra}');
                    //       log('===============================================');
                    //     }
                    //
                    //
                    //
                    //   });
                    // });

                  }
                });
              }
            }


          }
        });
      }


    });
  }


  final scaffoldKey = GlobalKey<ScaffoldState>();
  late TextEditingController invoiceController;
  DateTime fromDate=DateTime.now();
  DateTime toDate=DateTime.now();
  QuerySnapshot? invoices;
  final format = DateFormat("yyyy-MM-dd hh:mm aaa");
  DateTime selectedOutDate = DateTime.now();
  DateTime selectedFromDate = DateTime.now();
  double totalSorted=0;


  @override
  void initState() {
    log('helloooo');
    // getTotalBalance();
    invoiceController=TextEditingController();
    super.initState();
    getDailyInvoice();
    DateTime today=DateTime.now();
    selectedFromDate =DateTime(today.year,today.month,today.day,0,0,0);
  }
  getInvoiceByNo() async {
    invoices=await FirebaseFirestore.instance.collection('expenses')
        .doc(currentshopId)
        .collection('expenses')
        .where('invoiceNo',isEqualTo: invoiceController.text)
        .where('delete',isEqualTo: false)
        .get();
    totalSorted=0;
    for(DocumentSnapshot doc in invoices!.docs){
      totalSorted+=doc['amount'];
    }
    setState(() {

    });
  }
  getInvoiceByDate() async {
    if(fromDate!=null && toDate!=null) {
      Timestamp fromDateTimeStamp =Timestamp.fromDate(selectedFromDate);
      // Timestamp toDateTimeStamp =Timestamp.fromDate(DateTime(toDate.year, toDate.month, toDate.day));
      Timestamp toDateTimeStamp =Timestamp.fromDate(selectedOutDate);
      invoices = await FirebaseFirestore.instance.collection('expenses')
          .doc(currentshopId)
          .collection('expenses')
          .where('salesDate', isGreaterThanOrEqualTo: fromDateTimeStamp)
          .where('salesDate', isLessThan: toDateTimeStamp)
          .where('delete', isEqualTo: false)
          .get();

      totalSorted=0;
      for(DocumentSnapshot doc in invoices!.docs){
        totalSorted+=doc['amount'];
      }

      setState(() {

      });
    }
  }
  getDailyInvoice() async {
    var now = DateTime.now();
    var lastMidnight =Timestamp.fromDate(DateTime(now.year, now.month, now.day));

    invoices=await FirebaseFirestore.instance.collection('expenses')
        .doc(currentshopId)
        .collection('expenses')
        .where('salesDate',isGreaterThanOrEqualTo: lastMidnight)
        .where('delete',isEqualTo: false)
        .get();

    totalSorted=0;
    for(DocumentSnapshot doc in invoices!.docs){
      totalSorted+=doc['amount'];
    }

    setState(() {

    });
  }

  // Future<void> testReceipt(NetworkPrinter printer) async {
  //   try {
  //
  //       printer.text('KOT SECTION TESTING');
  //     // for (Map<String, dynamic> item in items) {
  //     //   if(!categories.contains(item['category'])) {
  //     //     categories.add(item['category']);
  //     //   }
  //     // }
  //     // print(categories);
  //     // for(var category in categories) {
  //     //   print(category);
  //     //   // printer.text('Token No : ' + token.toString(),
  //     //   //     styles: const PosStyles(align: PosAlign.center,));
  //     //   printer.text(
  //     //       'Date : ' + DateTime.now().toString().substring(0, 16),
  //     //       styles: const PosStyles(align: PosAlign.center,));
  //     //   // printer.text('Invoice No : ' + invNo.toString(),
  //     //   //     styles: const PosStyles(align: PosAlign.center,));
  //     //   // kotBytes+=generator.text('.............................................',styles: const PosStyles(align: PosAlign.center,));
  //     //   // kotBytes+=generator.emptyLines(2);
  //     //
  //     //   for (Map<String, dynamic> item in items) {
  //     //     if(item['category']==category) {
  //     //       // addOnPrice = item['addOnPrice'];
  //     //       // double total = (double.tryParse(item['price'].toString()) +
  //     //       //     addOnPrice) *
  //     //       //     double.tryParse(item['qty'].toString());
  //     //
  //     //       // double vat = total * 15 / 115;
  //     //        var newAddOn = item['addOns'];
  //     //      var  newAddOnArabic = item['addOnArabic'];
  //     //       // token = item['token'];
  //     //       // String arabic1 = StringUtils.reverse(arabic);
  //     //
  //     //        var addON = newAddOn.isEmpty ? '' : newAddOn.toString();
  //     //       // double price = (double.tryParse(item['price'].toString()) +
  //     //       //     addOnPrice) * 100 / 115;
  //     //
  //     //
  //     //        printer.text("${int.tryParse(item['qty']
  //     //           .toString())} x ${item['pdtname']} $addON");
  //     //
  //     //       print("${int.tryParse(item['qty'].toString())} x ${item['pdtname']} $addON");
  //     //     }
  //     //   }
  //     //
  //     //   if (lastCut == true) {
  //     //     // final utf8Text="Total Amount( الاجمامي )";
  //     //     // final cpText =latin1.encode(utf8Text);
  //     //     printer.feed(2);
  //     //
  //     //     printer.cut();
  //     //
  //     //     // flutterUsbPrinter.write(cpText);
  //     //     // flutterUsbPrinter.write(Uint8List.fromList(kotBytes));
  //     //     // kotBytes = [];//double print
  //     //     // flutterUsbPrinter.
  //     //
  //     //   }
  //     // }
  //
  //
  //
  //
  //
  //     printer.feed(2);
  //     printer.cut();
  //     printer.disconnect(delayMs: 2000);
  //
  //     print("end");
  //   }
  //   catch(err){
  //     printer.disconnect(delayMs: 2000);
  //     print("catch");
  //     print(err);
  //   }
  // }

  // Future<void> _printTicket() async {
  //   try {
  //     await printer.connect();
  //
  //     final ticket = Ticket();
  //
  //     // Add your print text here
  //     ticket.text('Thank you for your purchase!');
  //
  //     await printer.printTicket(ticket);
  //   } on PlatformException catch (e) {
  //     print('Error: ${e.message}');
  //   } finally {
  //     await printer.disconnect();
  //   }
  // }

  // void checkPortRange(String subnet, int fromPort, int toPort) {
  //   if (fromPort > toPort) {
  //     return;
  //   }
  //
  //   print('port ${fromPort}');
  //
  //   final stream = NetworkAnalyzer.discover2(subnet, fromPort);
  //
  //   stream.listen((NetworkAddress addr) {
  //     if (addr.exists) {
  //       print('Found device: ${addr.ip}:${fromPort}');
  //     }
  //   }).onDone(() {
  //     checkPortRange(subnet, fromPort + 1, toPort);
  //   });
  // }


  @override
  Widget build(BuildContext context) {
    log('1111111');
    return Scaffold(
      key: scaffoldKey,
      floatingActionButton: FloatingActionButton(
        onPressed: () {

        Navigator.push(context, MaterialPageRoute(builder: (context)=>Expenses()));
      },
        backgroundColor: primarycolor1,
        child: Icon(Icons.add),

      ),
      appBar: AppBar(
        backgroundColor: primarycolor1,
        automaticallyImplyLeading: true,
        title: Text(
          'Expense Reports',
          style: TextStyle(
              fontFamily: 'Poppins',color: Colors.white
          ),
        ),
        actions: [],
        centerTitle: true,
        elevation: 0,
      ),
      body: SafeArea(
        child: Padding(
          padding: const EdgeInsets.all(10.0),
          child: Column(
            children: [

              Row(
                children: [
                  Expanded(
                    child: Container(
                      width: 200,
                      decoration: BoxDecoration(
                          borderRadius: BorderRadius.circular(3),
                          color: Colors.white),
                      child: Center(
                        child: TextFormField(
                          controller: invoiceController,
                          keyboardType: TextInputType.text,
                          decoration: InputDecoration(
                            labelText: 'Bill No',
                            hoverColor: Colors.red,
                            hintText: 'search bill no',
                            border: OutlineInputBorder(
                              borderRadius: BorderRadius.circular(5.0),
                            ),
                            focusedBorder: OutlineInputBorder(
                              borderSide: BorderSide(color: Colors.pink.shade900, width: 1.0),
                            ),
                          ),
                        ),
                      ),
                    ),
                  ),
                  const SizedBox(width: 20,),
                  TextButton(
                    onPressed: (){
                      FocusScope.of(context).unfocus();
                      getInvoiceByNo();

                    },
                    child: const Text('Search By invoiceNo'),
                  ),
                  // const SizedBox(width: 50,),
                  // InkWell(
                  //   onTap: () async {
                  //     final DateTime picked = await showDatePicker(
                  //         context: context,
                  //         initialDate: fromDate??DateTime.now(),
                  //         firstDate: DateTime(2015, 8),
                  //         lastDate: DateTime(2101));
                  //     if (picked != null && picked != fromDate) {
                  //       setState(() {
                  //         fromDate = picked;
                  //       });
                  //     }
                  //   },
                  //   child:Container(
                  //     width: 200,
                  //     decoration: BoxDecoration(
                  //         borderRadius: BorderRadius.circular(3),
                  //         color: Colors.white),
                  //     child: Center(
                  //       child: Text(
                  //           fromDate==null?'Date From':fromDate.toLocal().toString().substring(0,10)
                  //       ),
                  //     ),
                  //   ),
                  // ),
                  // const SizedBox(width: 20,),
                  // InkWell(
                  //   onTap: () async {
                  //     final DateTime picked = await showDatePicker(
                  //         context: context,
                  //         initialDate: toDate??DateTime.now(),
                  //         firstDate: DateTime(2015, 8),
                  //         lastDate: DateTime(2101));
                  //     if (picked != null && picked != toDate) {
                  //       setState(() {
                  //         toDate = picked;
                  //       });
                  //     }
                  //   },
                  //   child:Container(
                  //     width: 200,
                  //     decoration: BoxDecoration(
                  //         borderRadius: BorderRadius.circular(3),
                  //         color: Colors.white),
                  //     child: Center(
                  //       child: Text(
                  //           toDate==null?'To Date ':toDate.toLocal().toString().substring(0,10)
                  //       ),
                  //     ),
                  //   ),
                  // ),
                  // const SizedBox(width: 20,),


                ],

              ),
              const SizedBox(height: 20,),
              Row(
                children: [
                  Expanded(
                    child: Container(
                      height: 50,
                      width: 220,
                      decoration: BoxDecoration(
                          border: Border.all(
                              color: primarycolor1,
                              width: 1),
                          borderRadius:
                          BorderRadius.circular(
                              10)),
                      child: DateTimeField(
                        initialValue:selectedFromDate ,
                        format: format,
                        enableInteractiveSelection: false,
                        decoration: InputDecoration(

                          border: null,
                          focusedBorder: null,
                          enabledBorder: null,
                          errorBorder:null,
                          focusedErrorBorder:null,
                          disabledBorder:null,

                        ),
                        onShowPicker: (context,
                            currentValue) async {
                          final date =
                          await showDatePicker(
                              context: context,
                              firstDate:
                              DateTime(1900),
                              initialDate:
                              currentValue ??
                                  DateTime
                                      .now(),
                              lastDate:
                              DateTime(2100));
                          if (date != null) {
                            final time =
                            await showTimePicker(
                              context: context,
                              initialTime: TimeOfDay
                                  .fromDateTime(
                                  currentValue ??
                                      DateTime
                                          .now()),
                            );

                            if(time != null) {
                              selectedFromDate =
                                  DateTime(
                                      date.year,
                                      date.month,
                                      date.day,
                                      time.hour,
                                      time.minute);
                            }
                            // datePicked1=Timestamp.fromDate(selectedFromDate);
                            return DateTimeField
                                .combine(date, time);
                          } else {
                            return currentValue;
                          }
                        },
                      ),
                    ),
                  ),

                  Text(
                    'To',
                    style: TextStyle(
                        fontFamily: 'Poppins',fontWeight: FontWeight.bold
                    ),
                  ),

                  Expanded(
                    child: Container(
                      height: 50,
                      width: 220,
                      decoration: BoxDecoration(
                          border: Border.all(
                              color: primarycolor1,
                              width: 1),
                          borderRadius:
                          BorderRadius.circular(
                              10)),
                      child: DateTimeField(
                        initialValue:selectedOutDate ,
                        format: format,
                        onShowPicker: (context,
                            currentValue) async {
                          final date =
                          await showDatePicker(
                              context: context,
                              firstDate:
                              DateTime(1900),
                              initialDate:
                              currentValue ??
                                  DateTime
                                      .now(),
                              lastDate:
                              DateTime(2100));
                          if (date != null) {
                            final time =
                            await showTimePicker(
                              context: context,
                              initialTime: TimeOfDay
                                  .fromDateTime(
                                  currentValue ??
                                      DateTime
                                          .now()),
                            );
                            if(time != null) {
                              selectedOutDate =
                                  DateTime(
                                      date.year,
                                      date.month,
                                      date.day,
                                      time.hour,
                                      time.minute);
                            }
                            // datePicked2=Timestamp.fromDate(selectedOutDate) ;
                            return DateTimeField
                                .combine(date, time);
                          } else {
                            return currentValue;
                          }
                        },
                      ),
                    ),
                  ),

                  Expanded(
                    child: TextButton(
                      onPressed: (){
                        getInvoiceByDate();
                      },
                      child: const Text('Search By Date'),
                    ),
                  ),

                  // InkWell
                  //   (
                  //     onTap: () async {
                  //       // checkPortRange('192.168.1', 9100, 9110);
                  //       // return;
                  //       const PaperSize paper = PaperSize.mm80;
                  //       final profile = await CapabilityProfile.load();
                  //       final printer = NetworkPrinter(paper, profile);
                  //
                  //      print('1.                $printer');
                  //
                  //       try{
                  //         // await printer.connect('192.168.123.100', port: 9100);
                  //         final PosPrintResult res = await printer.connect('192.168.1.222', port: 9100,timeout: const Duration(seconds: 10));
                  //       print('0.                ${res.value}');
                  //       print(res.msg);
                  //       if (res == PosPrintResult.success) {
                  //         print('SUUUUUUUUU');
                  //         testReceipt(printer);
                  //       }else
                  //       {
                  //         print("no printer found");
                  //       }
                  //       }catch(e){
                  //         print("button catch");
                  //         print(e.toString());
                  //       }
                  //     },
                  //     child: const Text('Eprint test',style: TextStyle(color: Colors.red),)),
                ],

              ),
              const SizedBox(height: 20,),
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
                              style: GoogleFonts.montserrat(color:Colors.black,fontWeight: FontWeight.w700,fontSize: 20),
                            ),
                            TextSpan(text: '$currencyCode.'),
                            TextSpan(
                              // Text((data.credit??0).toStringAsFixed(2),
                              // style:  GoogleFonts.montserrat(color:Colors.black,fontWeight: FontWeight.w900,fontSize: 20),);
                              text: totalSorted.toStringAsFixed(2),
                              style: GoogleFonts.montserrat(color:Colors.black,fontWeight: FontWeight.w700,fontSize: 18),
                            ),
                          ],
                        ),
                      ),
                    )
                  ],
                ),
              ),
              const SizedBox(height: 20,),

              Expanded(
                child: GridView.builder(
                  shrinkWrap: true,
                  primary: false,
                  padding: const EdgeInsets.all(10),
                  gridDelegate:
                   SliverGridDelegateWithFixedCrossAxisCount(
                    crossAxisCount: width>500?3:2,
                    crossAxisSpacing: 10,
                    mainAxisSpacing:10,
                    childAspectRatio: .7,
                  ),

                  itemCount:
                  invoices==null?0:invoices!.docs.length,
                  itemBuilder: (context, index) {
                    DocumentSnapshot invoice =
                    invoices!.docs[index];
                    return  InkWell(
                      // onTap: () async {
                      //   await Navigator.push(
                      //     context,
                      //     MaterialPageRoute(builder: (context) =>  ViewInvoice(invoiceNo: int.tryParse(invoice.id)??0,)),
                      //   );
                      // },
                      child:  Card(
                        child: Column(
                          children: [
                            Expanded(
                              child: Container(
                                color: Colors.grey.shade300,
                                height: 200,
                                child:invoice.get('image')!='' && invoice.get('image')!=null
                                    ? CachedNetworkImage(
                                  imageUrl: invoice.get('image')
                                  ,fit: BoxFit.cover,
                                )
                                    :Container(
                                    height:220
                                ),
                              ),
                            ),
                            Padding(
                              padding: const EdgeInsets.only(left: 10,right: 10),
                              child: Row(
                                  mainAxisAlignment:
                                  MainAxisAlignment.spaceEvenly,
                                  children: [
                                    Text("Voucher No"),
                                    Text(":"),
                                    Text(invoice
                                        .get('voucherNo')
                                        .toString())
                                  ]),
                            ),
                            Divider(),
                            Padding(
                                padding: const EdgeInsets.only(left: 10,right: 10),
                                child: Row(
                                    mainAxisAlignment:
                                    MainAxisAlignment.spaceEvenly,
                                    children: [
                                      Text("Invoice No"),
                                      Text(":"),
                                      Text(invoice
                                          .get('invoiceNo')
                                          .toString()),
                                    ])),
                            Divider(),
                            Padding(
                              padding: const EdgeInsets.only(left: 10,right: 10),
                              child: Row(
                                  mainAxisAlignment:
                                  MainAxisAlignment.spaceEvenly,
                                  children: [
                                    Text(" Amount"),
                                    Text(":"),
                                    Text(
                                        invoice.get('amount').toString()),
                                  ]),
                            ),
                            Divider(),
                            // Padding(
                            //     padding: const EdgeInsets.only(left: 10,right: 10),
                            //     child: Row(
                            //         mainAxisAlignment:
                            //         MainAxisAlignment.spaceBetween,
                            //         children: [
                            //           Text("Vat Amount"),
                            //           Text(":"),
                            //           Text(invoice.get('gst').toString()),
                            //         ])
                            // ),
                            // Divider(),
                            Padding(
                                padding: const EdgeInsets.only(left: 10,right: 10),
                                child: Row(
                                    mainAxisAlignment:
                                    MainAxisAlignment.spaceEvenly,
                                    children: [
                                      Text("Description"),
                                      Text(":"),
                                      Text(invoice
                                          .get('description')
                                          .toString()),
                                    ]
                                )
                            ),
                            Divider(),
                            // Padding(
                            //     padding: const EdgeInsets.only(left: 10,right: 10),
                            //     child: Row(
                            //         mainAxisAlignment:
                            //         MainAxisAlignment.spaceEvenly,
                            //         children: [
                            //           Text("Staff"),
                            //           Text(":"),
                            //           // Text(PosUserIdToName[invoice
                            //           //     .get('currentUserId')
                            //           //     .toString()]),
                            //         ]
                            //     )
                            // ),
                            IconButton(onPressed: () async {

                              bool proceed = await alert(context, 'You want to Delete?');
                              if(proceed){
                                invoice.reference.update({
                                  'delete':true,
                                });
                                setState(() {});
                                Navigator.pop(context);
                              }



                            }, icon: Icon(Icons.delete,color: Colors.red,))

                          ],
                        ),
                      ),
                    ) ;
                  },
                ),
              )
            ],
          ),
        ),
      ),
    );

  }

  Future<bool> alert(BuildContext context, String message,
      ) async {
    bool result=  await showDialog(
        context: context,
        builder: (context) => AlertDialog(
          shape: RoundedRectangleBorder(
              borderRadius: BorderRadius.circular(24.0)
          ),
          title: Text('Are you sure ?'),
          content: Text(message),
          actions: <Widget>[
            TextButton(
              onPressed: (){
                Navigator.of(context, rootNavigator: true).pop(false);
              },
              child: Text(
                  'No',
                  style: TextStyle(
                      fontSize: 18.0,
                      fontWeight: FontWeight.bold,
                      color: Colors.black
                  )
              ),
            ),
            TextButton(
              onPressed: (){
                Navigator.of(context, rootNavigator: true).pop(true);
              },
              child: Text(
                  'Yes',
                  style: TextStyle(
                      fontSize: 18.0,
                      fontWeight: FontWeight.bold,
                      color: Colors.red
                  )
              ),
            )
          ],
        )
    );
    return result;
  }

}