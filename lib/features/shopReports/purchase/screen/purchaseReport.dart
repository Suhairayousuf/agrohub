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
import 'addPurchase.dart';

class PurchaseReport extends StatefulWidget {
  const PurchaseReport({Key? key}) : super(key: key);

  @override
  _PurchaseReportState createState() => _PurchaseReportState();
}

class _PurchaseReportState extends State<PurchaseReport> {
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
    invoiceController=TextEditingController();
    super.initState();
    getDailyInvoice();
    DateTime today=DateTime.now();
    selectedFromDate =DateTime(today.year,today.month,today.day,0,0,0);
    // datePicked1 =Timestamp.fromDate(DateTime(today.year,today.month,today.day,0,0,0));
    // datePicked2 =Timestamp.fromDate(DateTime(today.year,today.month,today.day,23,59,59));
  }
  getInvoiceByNo() async {
    invoices=await FirebaseFirestore.instance.collection('purchases')
        .doc(currentshopId)
        .collection('purchases')
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

      Timestamp toDateTimeStamp =Timestamp.fromDate(selectedOutDate);
      print(1);
      invoices = await FirebaseFirestore.instance.collection('purchases')
          .doc(currentshopId)
          .collection('purchases')
          .where('delete',isEqualTo: false)
          .where('salesDate', isGreaterThanOrEqualTo: fromDateTimeStamp)
          .where('salesDate', isLessThan: toDateTimeStamp)
          .get();

      totalSorted=0;
      for(DocumentSnapshot doc in invoices!.docs){
        totalSorted+=doc['amount'];
      }

      print(invoices);
      setState(() {

      });
    }
  }
  getDailyInvoice() async {
    var now = DateTime.now();
    var lastMidnight =Timestamp.fromDate(DateTime(now.year, now.month, now.day));

    invoices=await FirebaseFirestore.instance.collection('purchases')
        .doc(currentshopId)
        .collection('purchases')
        .where('delete',isEqualTo: false)
        .where('salesDate',isGreaterThanOrEqualTo: lastMidnight).get();

    totalSorted=0;
    for(DocumentSnapshot doc in invoices!.docs){
      totalSorted+=doc['amount'];
    }

    setState(() {

    });
  }

  @override
  Widget build(BuildContext context) {
    print('"""""width"""""');
    print(width);
    return Scaffold(
      key: scaffoldKey,
      floatingActionButton: FloatingActionButton(onPressed: () {

        Navigator.push(context, MaterialPageRoute(builder: (context)=>Purchases()));
      },
        backgroundColor: primarycolor1,
        child: Icon(Icons.add),

      ),
      appBar: AppBar(
        backgroundColor: primarycolor1,
        automaticallyImplyLeading: true,
        title: Text(
          'Purchase Report',
          style: TextStyle(
              fontFamily: 'Poppins',color: Colors.white
          ),
        ),
        actions: [],
        centerTitle: true,
        elevation: 0,
      ),
      body: SafeArea(
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


              ],

            ),
            SizedBox(height: 20,),
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceAround,
              children: [


                Expanded(
                  child: Container(
                    height: 50,
                    width: 220,
                    decoration: BoxDecoration(
                        border: Border.all(
                            color: Colors.white,
                            width: 1),
                        borderRadius:
                        BorderRadius.circular(
                            10)),
                    child: DateTimeField(
                      initialValue:selectedFromDate ,
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
                          if(time!=null) {
                            selectedFromDate =
                              DateTime(
                                  date.year,
                                  date.month,
                                  date.day,
                                  time!.hour,
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
                const Text(
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
                            color: Colors.white,
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
                          if(time!=null) {
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
              ],

            ),
            SizedBox(height: 20,),
            Padding(
              padding: const EdgeInsets.all(20),
              child: Row(
                mainAxisAlignment: MainAxisAlignment.end,
                children: [


                  Padding(
                    padding:  EdgeInsets.only(right: 10.0),
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
                  childAspectRatio: .57,
                ),

                itemCount:
                invoices==null?0:invoices!.docs.length,
                itemBuilder: (context, index) {
                  DocumentSnapshot invoice =
                  invoices!.docs[index];
                  return invoices!.docs==null?Center(child: CircularProgressIndicator()):
                  invoices!.docs.isEmpty?Center(child: Text('No Data')):InkWell(
                    // onTap: () async {
                    //   await Navigator.push(
                    //     context,
                    //     MaterialPageRoute(builder: (context) =>  ViewInvoice(invoiceNo: int.tryParse(invoice.id)??0,)),
                    //   );
                    // },
                    child: Card(
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
                                MainAxisAlignment.spaceBetween,
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
                                  MainAxisAlignment.spaceBetween,
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
                                MainAxisAlignment.spaceBetween,
                                children: [
                                  Text("Taxable Amount"),
                                  Text(":"),
                                  Text(
                                      invoice.get('amount').toString()),
                                ]),
                          ),
                          Divider(),
                          Padding(
                              padding: const EdgeInsets.only(left: 10,right: 10),
                              child: Row(
                                  mainAxisAlignment:
                                  MainAxisAlignment.spaceBetween,
                                  children: [
                                    Text("Vat Amount"),
                                    Text(":"),
                                    Text(invoice.get('gst').toString()),
                                  ])),
                          Divider(),
                          Padding(
                              padding: const EdgeInsets.only(left: 10,right: 10),
                              child: Row(
                                  mainAxisAlignment:
                                  MainAxisAlignment.spaceBetween,
                                  children: [
                                    Text("Description"),
                                    Text(":"),
                                    Text(invoice
                                        .get('description')
                                        .toString()),
                                  ])),
                          Divider(),
                          // Padding(
                          //     padding: const EdgeInsets.only(left: 10,right: 10),
                          //     child: Row(
                          //         mainAxisAlignment:
                          //         MainAxisAlignment.spaceBetween,
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
                              setState(() {

                              });
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