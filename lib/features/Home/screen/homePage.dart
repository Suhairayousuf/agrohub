import 'package:agrohub/features/Home/screen/selectShop.dart';
import 'package:cached_network_image/cached_network_image.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_barcode_scanner/flutter_barcode_scanner.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:image_picker/image_picker.dart';
import 'package:intl_phone_field/intl_phone_field.dart';
import 'package:lottie/lottie.dart';


import '../../../Model/bookModel.dart';
import '../../../core/utils/utils.dart';
import '../../../themes/color.dart';

import '../../Book/book/screen/single_book_detailes.dart';
import '../../manage/Purchase/screen/sales_transaction_page.dart';
import '../../manage/Transaction/screen/add_transaction.dart';
import '../../manage/Purchase/screen/purchase.dart';
import '../../auth/screen/splash.dart';






class HomePage extends StatefulWidget {
  const HomePage({Key? key}) : super(key: key);

  @override
  State<HomePage> createState() => _HomePageState();
}

class _HomePageState extends State<HomePage> {


  TextEditingController emailId = TextEditingController();
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
    print('))))))))))))))))))))))))))))))))))))))))');
    print(scanBarcode.split(':')[1]);
    print(scanBarcode.split(':')[0]);
    // if(scanBarcode.split(':')[0]=='C'){
    //
    //   Navigator.push(context, MaterialPageRoute(builder: (context)=>CouponUsePage(
    //     docId: scanBarcode.split(':')[1],
    //   )));
    // }else{
    //   Navigator.push(context, MaterialPageRoute(builder: (context)=>UserSinglePageView(
    //     phoneNumber: scanBarcode.split(':')[1],)));
    // }


    // showDialog(context: context,
    //     builder: (buildcontext) {
    //       return AlertDialog(
    //         // contentPadding: EdgeInsets.all(20),
    //         title: Text(
    //           'Select Type', style: GoogleFonts.montserrat(),),
    //         content: Container(
    //           width: width * 1,
    //           height: width * 0.5,
    //           child: Row(
    //             mainAxisAlignment: MainAxisAlignment.spaceAround,
    //             crossAxisAlignment: CrossAxisAlignment.center,
    //             children: [
    //               InkWell(
    //                 onTap: (){
    //                   Navigator.pop(buildcontext);
    //                   Navigator.push(context, MaterialPageRoute(builder: (context)=>Purchase(
    //                     iqamaNumber: scanBarcode.split(':')[1],)));
    //                 },
    //                 child: Container(
    //
    //                   width: width*0.28,
    //                   height:  width*0.15 ,
    //                   decoration: BoxDecoration(
    //                       color: primarycolor2,
    //                       borderRadius: BorderRadius.circular(10)
    //                   ),
    //                   child: Center(
    //                     child: Text('Purchase',style: GoogleFonts.poppins(
    //                         fontSize: 15,
    //                         color: Colors.white
    //                     ),),
    //                   ),
    //                 ),
    //               ),
    //               SizedBox(width: 10,),
    //               InkWell(
    //                 onTap: (){
    //                   Navigator.pop(buildcontext);
    //                   Navigator.push(context, MaterialPageRoute(builder: (context)=>AddTransactionPage(
    //                     iqamaNumber: scanBarcode.split(':')[1],)));
    //
    //                 },
    //                 child: Container(
    //                   height:  width*0.15 ,
    //                   width: width*0.28,
    //                   decoration: BoxDecoration(
    //                       borderRadius: BorderRadius.circular(10),
    //                       color: primarycolor2
    //                   ),
    //                   child: Center(
    //                     child: Text('Transaction',style: GoogleFonts.poppins(
    //                         fontSize: 15,
    //                         color: Colors.white
    //                     ),),
    //                   ),
    //                 ),
    //               )
    //             ],
    //           ),
    //         ),
    //         actions: [
    //           TextButton(onPressed: () {
    //             Navigator.pop(buildcontext);
    //           },
    //               child: Text(
    //                   'Cancel', style: GoogleFonts.montserrat())),
    //
    //         ],
    //       );
    //     });

  }
  // getUpdate(){
  //   FirebaseFirestore.instance.collection('users').snapshots().listen((event) {
  //     for(var doc in event.docs){
  //       FirebaseFirestore.instance.collection('users').doc(doc.id).collection('purchase').snapshots().listen((value) {
  //         for(var data in value.docs){
  //           print('xyz');
  //           FirebaseFirestore.instance.collection('users').doc(doc.id).
  //           collection('purchase').doc(data.id).update(
  //               {
  //                 'delete':false
  //               });
  //
  //         }
  //       });
  //     }
  //
  //   });
  //   if(mounted){
  //     setState(() {
  //
  //     });
  //   }
  // }

  @override
  void initState() {
    // getUsers();
    // getUpdate();
    super.initState();
  }
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: primarycolor1,
      body: SingleChildScrollView(
        child: Column(
          children: [
            SizedBox(
              height: width * 0.2,
            ),
            // Container(
            //   width: width * 0.85,
            //   height: width * 0.7,
            //   decoration:  BoxDecoration(
            //     borderRadius: BorderRadius.circular(15),
            //     image: DecorationImage(image: AssetImage("assets/login.png"),
            //     ),
            //   ),
            //  ),
            // SizedBox(
            //   height: width * 0.1,
            // ),
            // InkWell(
            //   onTap:() => scanQR(),
            //   child: Center(
            //     child: Container(
            //       height: width * 0.15,
            //       width: width * 0.4,
            //       decoration: BoxDecoration(
            //         gradient:
            //         LinearGradient(colors: [primarycolor1, primarycolor2]),
            //         borderRadius: BorderRadius.all(
            //           Radius.circular(20),
            //         ),
            //       ),
            //       child: Center(
            //         child: Text(
            //           'Scanner',
            //           style: TextStyle(
            //               color: Colors.white,
            //               fontSize: width * 0.05,
            //               fontWeight: FontWeight.w500),
            //         ),
            //       ),
            //     ),
            //   ),
            // ),
            // SizedBox(
            //   height: width * 0.1,
            // ),
            // Padding(
            //   padding:  EdgeInsets.only(left: width*0.05,right: width*0.05),
            //   child: IntlPhoneField(
            //     keyboardType: TextInputType.phone,
            //     controller:mobileNumber,
            //     decoration: InputDecoration(
            //       hintText:
            //       'Enter your Phone number...',
            //       hintStyle:
            //       GoogleFonts.nunito( color:
            //       Colors.white,
            //         fontSize: 14,
            //         fontWeight:
            //         FontWeight.normal,),
            //       labelText: 'Phone Number',
            //       labelStyle:
            //       GoogleFonts.nunito(
            //         color:
            //         Colors.white,
            //         fontSize: 14,
            //         fontWeight:
            //         FontWeight.normal,),
            //       border: OutlineInputBorder(
            //         borderSide: BorderSide(color: Colors.white),
            //       ),
            //     ),
            //     initialCountryCode: isoCode,
            //     onChanged: (phone) {
            //       print(phone.completeNumber);
            //       print("hiiiiiiiiiiiiiiiiiiiiiiiiiii");
            //       print(phone.countryCode);
            //
            //       // countryCode = phone.countryCode;
            //       // _phoneNumber.text = phone.completeNumber;
            //
            //     },
            //     onCountryChanged: (country) {
            //       print('Country changed to: ' + country.dialCode);
            //
            //       // countryCode='+${country.dialCode}';
            //     },
            //   ),
            // ),
            Container(
              height: width * 0.1,
              width: width * 0.9,
              decoration: BoxDecoration(
                border: Border.all(color: Colors.white),
                borderRadius: BorderRadius.all(
                  Radius.circular(20),
                ),
              ),
              child:
              Padding(
                padding: const EdgeInsets.only(left: 8.0),
                child: TextFormField(
                  autovalidateMode: AutovalidateMode.always,
                  // validator: (phno) {
                  //   if (phno!.isEmpty) {
                  //     return "";
                  //   } else if (mobileNumber?.text.length!=10)
                  //   {
                  //     return "Number is not valid";
                  //   } else {
                  //     return null;
                  //   }
                  // },
                  controller: emailId,
                  keyboardType: TextInputType.text,
                  decoration: InputDecoration(
                    contentPadding: EdgeInsets.only(top: 20,left: 20),
                    border: InputBorder.none,
                    hintText:  'Book No',
                    hintStyle: GoogleFonts.montserrat(color: Colors.white, fontSize: 20),
                    // labelText: 'PhoneNumber',
                     labelStyle: GoogleFonts.montserrat(color: Colors.white, fontSize: 20),
                  ),
                ),
              ),
            ),
            SizedBox(
              height: width * 0.1,
            ),
            InkWell(
              onTap: () async {
                BookModel? data;
                await FirebaseFirestore.instance.collection('shops')
                    .doc(currentshopId).collection('book').
                     where('bookName',isEqualTo: emailId.text).get().then((event) {
                       for(var doc in event.docs){
                         data=BookModel.fromJson(doc.data());
                       }
                       if(mounted){
                         setState(() {

                         });
                       }


                });
                if(data!=null) {
                  if (emailId!.text != '' && data!.block == false) {
                    Navigator.push(
                        context, MaterialPageRoute(builder: (context) =>
                        SingleBookDetailesPage(
                          bookData: data!,
                        )));


                    // showDialog(context: context,
                    //     builder: (buildcontext) {
                    //       return AlertDialog(
                    //         // contentPadding: EdgeInsets.all(20),
                    //         title: Text(
                    //           'Select Type', style: GoogleFonts.outfit(),),
                    //         content: Container(
                    //           width: width * 1,
                    //           height: width * 0.5,
                    //           child: Row(
                    //             mainAxisAlignment: MainAxisAlignment.spaceAround,
                    //             crossAxisAlignment: CrossAxisAlignment.center,
                    //             children: [
                    //               InkWell(
                    //                 onTap: (){
                    //                   Navigator.pop(buildcontext);
                    //                   // Navigator.push(context, MaterialPageRoute(builder: (context)=>Purchase(
                    //                   //   // iqamaNumber: emailId!.text,
                    //                   //    iqamaNumber: emailId!.text,
                    //                   // )));
                    //
                    //                 },
                    //                 child: Container(
                    //
                    //                   width: width*0.28,
                    //                   height:  width*0.15 ,
                    //                   decoration: BoxDecoration(
                    //                       color: primarycolor2,
                    //                     borderRadius: BorderRadius.circular(10)
                    //                   ),
                    //                   child: Center(
                    //                     child: Text('Purchase',style: GoogleFonts.poppins(
                    //                       fontSize: 15,
                    //                       color: Colors.white
                    //                     ),),
                    //                   ),
                    //                 ),
                    //               ),
                    //               SizedBox(width: 10,),
                    //               InkWell(
                    //                 onTap: (){
                    //                   Navigator.pop(buildcontext);
                    //                   Navigator.push(context, MaterialPageRoute(builder: (context)=>AddTransactionPage(
                    //                     iqamaNumber: emailId!.text,)));
                    //
                    //                 },
                    //                 child: Container(
                    //                   height:  width*0.15 ,
                    //                   width: width*0.28,
                    //                   decoration: BoxDecoration(
                    //                       borderRadius: BorderRadius.circular(10),
                    //                       color: primarycolor2
                    //                   ),
                    //                   child: Center(
                    //                     child: Text('Transaction',style: GoogleFonts.poppins(
                    //                       fontSize: 15,
                    //                       color: Colors.white
                    //                     ),),
                    //                   ),
                    //                 ),
                    //               )
                    //             ],
                    //           ),
                    //         ),
                    //         actions: [
                    //           TextButton(onPressed: () {
                    //             Navigator.pop(buildcontext);
                    //           },
                    //               child: Text(
                    //                   'Cancel', style: GoogleFonts.outfit())),
                    //
                    //         ],
                    //       );
                    //     });


                  } else {
                    emailId!.text == '' ?
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
              },
              child: Center(
                child: Container(
                  height: width * 0.15,
                  width: width * 0.4,
                  decoration: BoxDecoration(
                    color:primarycolor3,
                    // gradient:
                    // LinearGradient(colors: [primarycolor2, primarycolor2]),
                    borderRadius: BorderRadius.all(
                      Radius.circular(20),
                    ),
                  ),
                  child: Center(
                    child: Text(
                      'Submit',
                      style: GoogleFonts.montserrat(
                          color: Colors.white,
                          fontSize: width * 0.05,
                          fontWeight: FontWeight.w500),
                    ),
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