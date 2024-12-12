import 'dart:async';
import 'dart:developer';
import 'dart:io';

import 'package:agrohub/features/Book/book/screen/send_bill.dart';
import 'package:cached_network_image/cached_network_image.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:flutter_tts/flutter_tts.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:intl/intl.dart';
import 'package:intl_phone_field/intl_phone_field.dart';

import 'package:url_launcher/url_launcher.dart';
import 'package:whatsapp_share/whatsapp_share.dart';

import '../../../../Model/TransactionModel/transactionModel.dart';
import '../../../../Model/bookModel.dart';
import '../../../../Model/purchase/purchaseModel.dart';
import '../../../../core/globals/local_variables.dart';
import '../../../../core/utils/utils.dart';
import '../../../../themes/color.dart';
import '../../../Home/screen/NavigationBar.dart';
import '../../../Home/screen/homePage.dart';
import '../../../Home/screen/selectShop.dart';
import '../../../manage/Purchase/screen/sales_transaction_page.dart';
import '../../../auth/screen/splash.dart';
import '../../book/screen/singleImageViewer.dart';


class SingleBookDetailesPage extends ConsumerStatefulWidget {
  final BookModel bookData;
  const SingleBookDetailesPage({Key? key, required this.bookData}) : super(key: key);

  @override
  ConsumerState<SingleBookDetailesPage> createState() => _SingleBookDetailesPageState();
}

class _SingleBookDetailesPageState extends ConsumerState<SingleBookDetailesPage> {

  String initialCountryCode ='QA';
  String countryCode ='974';
  TextEditingController whatsAppNumberController=TextEditingController();


  String memberName="";
  String userID="";
  String profImage="";
  FlutterTts flutterTts = FlutterTts();

  bool showWhatsapp=false;

  Future<dynamic> _speakText() async {

    String text = memberName==''?'No Member Found':memberName;

    await flutterTts.setLanguage('en-US');
    // await flutterTts.setVoice({"name": "Karen", "locale": "en-AU"});
    await flutterTts.setPitch(0.6);
    await flutterTts.setSpeechRate(.6);
    await flutterTts.speak(text);


    await flutterTts.awaitSpeakCompletion(true);
  }


  List statement=[];
  double credit=0.00;
  List<TransactionModel> allTransaction=[];
  List<PurchaseModel> allPurchase=[];
getCredit(){
FirebaseFirestore.instance.collection('shops').
  doc(currentshopId).collection('book').doc(widget.bookData.bookId).get().then((event) {
   credit=event.get('credit').toDouble();
   if(mounted){
     setState(() {

     });
   }

 });
}
  Future<void>_makeCall(String url) async {
    if(await canLaunch(url)){
      await launch(url);
    }
    else{
      throw 'Could not call$url';
    }
  }
  getTransaction(){
        FirebaseFirestore.instance.collectionGroup('transactions')
        .where('shopId',isEqualTo: currentshopId).where('delete',isEqualTo: false)
        .where('bookId',isEqualTo: widget.bookData.bookId)
        .where('date',isGreaterThan: DateTime.now().subtract(const Duration(days: 30)))
        .orderBy('date',descending: true)
        .get()
        .then((event) {
        allTransaction =[];
        for(DocumentSnapshot <Map<String,dynamic>> doc in event.docs){
          allTransaction.add(TransactionModel.fromJson(doc.data()!));
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

    FirebaseFirestore.instance.collectionGroup('purchase')
        .where('shopId',isEqualTo: currentshopId)
        .where('bookId',isEqualTo: widget.bookData.bookId).where('delete',isEqualTo: false)
        .where('date',isGreaterThan: DateTime.now().subtract(const Duration(days: 30)))
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

  String customerName='';
  String customerPhone='';
  String customerEmail='';
  String companyName='';
  String whatsappNumber='';
  String phoneCode='';

  getUsers(){
  FirebaseFirestore.instance.collection('users')
      .where('shopId',isEqualTo: currentshopId)
      .where('userEmail',whereIn: widget.bookData.members).get().then((event) async {
      userList=[];
      for(var doc in event.docs){
        userList.add(doc.data());
        userMap[doc['userEmail']]=doc.data();

      }
      if(widget.bookData.members!.isNotEmpty){
        memberName=userMap[widget.bookData.members![0]]['userName'];
        userID=userMap[widget.bookData.members![0]]['userId'];
        profImage=userMap[widget.bookData.members![0]]['userImage'];
        customerName=userMap[widget.bookData.members![0]]['userName'];
        customerPhone=userMap[widget.bookData.members![0]]['phone'];
        customerEmail=userMap[widget.bookData.members![0]]['userEmail'];
        companyName=userMap[widget.bookData.members![0]]['companyName'];
        phoneCode=userMap[widget.bookData.members![0]]['phonePrefix'];
        whatsappNumber=userMap[widget.bookData.members![0]]['whatsappNumber'];
        whatsAppNumberController=TextEditingController(text: whatsappNumber.isEmpty?customerPhone:whatsappNumber);

        phoneCode=phoneCode.isEmpty?'974':phoneCode;
      }
      await Future.delayed(const Duration(milliseconds: 100));
      _speakText();

      if(mounted){
        setState(() {
          showWhatsapp=true;
        });
      }


    });

  }



  @override
  void initState() {
    if(widget.bookData.members!.isNotEmpty){
      getUsers();
    }

    getCredit();
    getTransaction();
    super.initState();
  }
  set(){
    setState(() {

    });
  }

  @override
  void dispose() {
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        leading: IconButton(
          onPressed: () {
            Navigator.pop(context);
          },
          icon: const Icon(Icons.arrow_back_ios),
        ),
        elevation: 0,
        backgroundColor: primarycolor1,
        actions: [
          Center(child: InkWell(
            onTap: (){
              Navigator.push(context, MaterialPageRoute(builder: (context)=>SendBill(phone: customerPhone.toString(), name: customerName,id: customerEmail,bookId: widget.bookData.bookId??'', bookName: widget.bookData.bookName??'', creditLimit: widget.bookData.creditLimit??0,bookCredit: widget.bookData.credit??0,)))
              .then((value) {
                getCredit();
                getTransaction();
                if(mounted){
                  setState(() {

                  });
                }
              });
            },
            child: Container(
              decoration: BoxDecoration(
                color: Colors.white,
                borderRadius: BorderRadius.circular(10)
              ),
                child: Padding(
                  padding: const EdgeInsets.fromLTRB(15,5,15,5),
                  child: Text('Send Bill',style: TextStyle(fontSize: 14,fontWeight: FontWeight.w600,color: primarycolor1),),
                )),
          )),
          // const SizedBox(width: 5,),

          Visibility(
            visible: showWhatsapp,
            child: IconButton(onPressed: () async {

              String url= '';
              String text= 'Greetings from My Book \n$currentshopName \nHi, $customerName \nyour outstanding amount as of ${DateFormat('dd / MMM / yyyy').format(DateTime.now())} is $currencyCode  ${credit.toStringAsFixed(2)}';

              // if (Platform.isAndroid) {
              //   // add the [https]
              //   return "https://wa.me/$phone/?text=${Uri.parse(message)}"; // new line
              // } else {
              //   // add the [https]
              //   return "https://api.whatsapp.com/send?phone=$phone=${Uri.parse(message)}"; // new line
              // }

              /// https://wa.me/918089410846/?text=hello
              // bool a= (await WhatsappShare.isInstalled(package: Package.whatsapp)??false) ||
              //     (await WhatsappShare.isInstalled(package: Package.businessWhatsapp)??false);
              ///





               // WhatsappShare.share(phone: '918089410846',text: 'Helloooo');
              // if(a) {



                  if ( phoneCode.isEmpty||whatsappNumber.isEmpty) {
                    showUploadMessage1(
                        context, "Please Update user's whatsApp Number",
                        style: GoogleFonts.montserrat());

                     showAlertForWhatsappNumber();


                  } else {

                    // if (Platform.isAndroid) {
                    //   // add the [https]
                    //   log('hereeeee');
                    //   url= "https://wa.me/<918089410846>"; // new line
                    // } else {
                    //   // add the [https]
                    //   url= "https://api.whatsapp.com/send?phone=$whatsappNumber=${Uri.parse(text)}"; // new line
                    // }
                    //
                    //
                    // if (await canLaunchUrl(Uri.parse(url))) {
                    //   await launchUrl(Uri.parse(
                    //     url,
                    //   ));
                    // } else {
                    //   ScaffoldMessenger.of(context).showSnackBar(
                    //       const SnackBar(content: Text("Whatsapp not installed")));
                    // }

                    try {
                      WhatsappShare.share(
                          phone: phoneCode + whatsappNumber,
                          text: 'Greetings from My Book \n$currentshopName \nHi, $customerName \nyour outstanding amount as of ${DateFormat('dd/MM/yyyy').format(DateTime.now())} is $currencyCode  ${credit.toStringAsFixed(2)}');

                    } catch (e) {
                      showErrorMessage(context, e.toString(), style:GoogleFonts.montserrat() );
                    }
                    }
              // } else {
              //   showUploadMessage(context, 'Please Install WhatApp to use this Feature.', style: GoogleFonts.montserrat());
              // }

            },
                icon: SvgPicture.asset('assets/icons/whatsapp.svg',width: width*0.055,)),
          ),
          // const SizedBox(width: 5,),
        ],
      ),


      body:  Column(
        children: [
          const SizedBox(height: 35,),

          // AppBar(widget.bookData.bookName.toString()),

          SingleChildScrollView(
            child: Column(
              children: [
                Card(
                  shadowColor: Colors.black,
                  child: Container(
                    // height: 220,
                    width: width,
                    decoration:BoxDecoration(
                      // color: Colors.red,

                        boxShadow: [
                          BoxShadow(
                            color:primarycolor1,
                            offset: const Offset(
                              5.0,
                              5.0,
                            ),
                            blurRadius: 5.0,
                            spreadRadius: 2.0,
                          ), //BoxShadow
                          const BoxShadow(
                            color: Colors.white,
                            offset: Offset(0.0, 0.0),
                            blurRadius: 0.0,
                            spreadRadius: 0.0,
                          ), //BoxShadow
                        ],
                        // border: Border.all(
                        //     width: 0.5,
                        // ),
                        borderRadius: BorderRadius.circular(5)
                    ),
                    child: Column(
                      mainAxisAlignment: MainAxisAlignment.start,
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        // SizedBox(height: 20,),
                        Row(
                          children: [
                            SizedBox(width: width*0.01,),
                            Expanded(
                              child: Column(
                                crossAxisAlignment: CrossAxisAlignment.stretch,
                                children: [
                                  Text(
                                    'Customer Profile Info',
                                    style: GoogleFonts.montserrat(
                                        fontSize: 16
                                    ),),
                                  Text(
                                    "Credit Limit : ${widget.bookData.creditLimit}",
                                    style: GoogleFonts.montserrat(
                                        fontSize: 20
                                    ),),
                                ],
                              ),
                            ),
                            Container(
                              height: 55,
                                width:width*0.2,
                                color: primarycolor1,

                                child: Center(child: Text(

                                    widget.bookData.bookName.toString(),
                                    style: GoogleFonts.montserrat(
                                      fontSize: 25,
                                      fontWeight: FontWeight.w700,
                                      color: Colors.white,

                                    ))
                                )),
                            SizedBox(width: width*0.01,)
                          ],
                        ),
                        const Padding(
                          padding: EdgeInsets.only(left: 18.0,right: 18),
                          child: Divider(thickness: 1),
                        ),
                        Row(
                          mainAxisAlignment: MainAxisAlignment.spaceBetween,
                          children: [
                            Padding(
                              padding:  EdgeInsets.only(bottom: width*0.08,left: width*0.04,top:width*0.01 ),
                              child: SizedBox  (

                                height: width*0.17,
                                width:width*0.2,

                                child: ClipRRect(
                                    borderRadius: BorderRadius.circular(8),
                                    child: (profImage!=""&&!profImage.startsWith('/'))?
                                    InkWell(
                                      onTap: (){
                                        Navigator.push(context,
                                            MaterialPageRoute(builder: (context) => ImageViewer(img: profImage),));
                                      },
                                        child: CachedNetworkImage(imageUrl:profImage ,fit: BoxFit.contain,))
                                        :Container()

                                ),
                              ),
                            ),
                            Column(
                              mainAxisAlignment: MainAxisAlignment.center,
                              crossAxisAlignment: CrossAxisAlignment.start,
                              children: [
                                SizedBox(
                                  width: width*0.7,
                                  child: Text(
                                    'Name : ${customerName.toString()}',
                                    style:
                                    GoogleFonts.montserrat(
                                        fontSize: 14,
                                        color: primarycolor1
                                    ),

                                  ),
                                ),
                                const SizedBox(height: 10,),
                                Text(
                                  'Mobile: ${ customerPhone.toString()}',
                                  style:
                                  GoogleFonts.montserrat(
                                      fontSize: 14,
                                      color: primarycolor1
                                  ),

                                ),
                                const SizedBox(height: 10,),
                                Text(
                                  'Company: ${ companyName.toString()}',
                                  style:
                                  GoogleFonts.montserrat(
                                      fontSize: 14,
                                      color: primarycolor1
                                  ),

                                ),

                                const SizedBox(height: 10,),
                                SizedBox(
                                  width: width*0.7,

                                  child: Text(

                                    'ID: ${ customerEmail.toString()}',                                    style:
                                    GoogleFonts.montserrat(
                                        fontSize: 14,
                                        color: primarycolor1
                                    ),

                                  ),

                                ),



                              ],
                            ),

                          ],
                        ),
                        const SizedBox(height:10),
                        SizedBox(
                          width: width,
                          child: Column(
                            crossAxisAlignment: CrossAxisAlignment.center,
                            children: [
                              const SizedBox(height: 12,),

                              // Text(widget.bookData.bookName.toString(),style: GoogleFonts.poppins(fontSize: 30),),
                              Text('Credit:',style: GoogleFonts.poppins(fontSize: 10),),
                              const SizedBox(height: 5,),
                              // Text(currencyCode=='INR'?'₹'+ '  '+widget.bookData.credit.toString():currencyCode.toString()+ '  '+widget.bookData.credit.toString(),style: GoogleFonts.poppins(
                              Text(currencyCode=='INR'?'₹  $credit':'$currencyCode  ${credit.toStringAsFixed(2)}',style: GoogleFonts.poppins(
                                  fontSize: 25,
                                  color: Colors.red,
                                  fontWeight: FontWeight.bold
                              ),),
                            ],
                          ),
                        ),


                      ],

                    ),
                  ),
                ),

                // SizedBox(
                //   height: width * 0.05,
                // ),


              ],
            ),
          ),

          widget.bookData.members!.isEmpty
              ? Center(
            child: Text('No members Found',style: GoogleFonts.poppins(color: primarycolor2),),
          )
              : ListView.builder(
                shrinkWrap: true,
                scrollDirection: Axis.vertical,
                physics: const BouncingScrollPhysics(),
                itemCount: widget.bookData.members!.length,

                itemBuilder: (context, index) {
                  var member=widget.bookData.members![index];
                  return Padding(
                    padding: const EdgeInsets.only(left: 10, right: 10,top: 5),
                    child: InkWell(
                      onTap: (){

                        Navigator.push(context, MaterialPageRoute(builder: (context)=>SalesTransactionPage(
                         email:member
                        ))).then((value) {
                          getCredit();
                          getTransaction();
                          if(mounted){
                            setState(() {

                            });
                          }
                        });
                      },
                      child: Container(
                        // padding: EdgeInsets.only(left: 10, right: 10),

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
                          padding: const EdgeInsets.all(5.0),
                          child: Row(
                            mainAxisAlignment: MainAxisAlignment.spaceBetween,
                            children: [
                              SizedBox(width: width*0.02,),

                              Column(
                                crossAxisAlignment: CrossAxisAlignment.center,
                                children: [
                                  const SizedBox(
                                    height: 10,
                                  ),
                                  Row(
                                    mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                                    crossAxisAlignment: CrossAxisAlignment.center,
                                    children: [
                                        SizedBox(
                                          width: width*0.8,
                                          child:Text(
                                            userMap[member.toString()]==null
                                                ?member.toString():userMap[member.toString()]['userName'],textAlign: TextAlign.center,
                                            style: GoogleFonts.montserrat(
                                                fontSize: 21,
                                                fontWeight: FontWeight.w800,
                                                color: Colors.black
                                            ),
                                          ),


                                        )
                                    ],
                                  ),
                                  const SizedBox(
                                    height: 5,
                                  )

                                ],
                              ),
                              const SizedBox(height: 10,)

                            ],
                          ),
                        ),
                      ),
                    ),
                  );
                },
              ),
          statement.isEmpty?Center(
            child: Text('No transaction found',
              style:  GoogleFonts.montserrat(color:primarycolor1,fontWeight: FontWeight.w700,fontSize: 14),),
          ): Expanded(

            child: ListView.builder(

                scrollDirection: Axis.vertical,
                physics: const BouncingScrollPhysics(),
                itemCount:statement.length ,
                itemBuilder: (context,index){
                  return  Padding(
                    padding: const EdgeInsets.all(8.0),
                    child: Container(
                      padding: const EdgeInsets.only(right: 10),
                      // height: 80,
                      width: 200,
                      decoration: BoxDecoration(
                        borderRadius: BorderRadius.circular(10),
                        color: const Color(0xffFBFBFB),
                      ),
                      child: Row(
                        mainAxisAlignment: MainAxisAlignment.spaceBetween,
                        children: [
                          Row(
                            children: [

                              const SizedBox(width: 10,),
                              Column(
                                crossAxisAlignment: CrossAxisAlignment.start,
                                children: [
                                  const SizedBox(height: 10,),
                                  SizedBox(
                                    width: width*0.55,
                                    child: Text(statement[index].customerName,
                                      style:  GoogleFonts.montserrat(color:primarycolor1,fontWeight: FontWeight.w700,fontSize: 14),) ,

                                  ),


                                  const SizedBox(height: 5,),

                                 const SizedBox(height: 5,),

                                  Text(DateFormat('dd MMM yyyy hh:mm aa').format(statement[index].date),
                                    style:  GoogleFonts.montserrat(color:Colors.black,fontWeight: FontWeight.w600,fontSize: 11),),
                                  const SizedBox(height: 5,),
                                  (!statement[index].toJson().containsKey('purchaseId'))? Text("Balance : ${(statement[index].balance??0).toStringAsFixed(2)} ",
                                    style:  GoogleFonts.montserrat(color:Colors.orange.shade700,fontWeight: FontWeight.w800,fontSize: 14),):Container(),
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
                              Row(
                                children: [
                                  Text(statement[index].currencyShort.toString(), style: GoogleFonts.montserrat(color:statement[index].toJson().containsKey('purchaseId') ?Colors.black:Colors.green,fontWeight: FontWeight.w600,fontSize: 15),),
                                  const SizedBox(width: 3,),
                                  Text(statement[index].amount.toString(), style: GoogleFonts.montserrat(color:statement[index].toJson().containsKey('purchaseId')?Colors.black:Colors.green,fontWeight: FontWeight.w600,fontSize: 15),),
                                ],
                              ),

                              const SizedBox(height: 5),
                              Visibility(
                                visible: index==0 || ref.read(editTransaction.notifier).state,
                                child: InkWell(
                                    onTap: () {
                                      showDialog(
                                          context: context,
                                          builder:
                                              (BuildContext context) {
                                            return EditAmountPage(
                                                id:statement[index].type==0? statement[index].purchaseId.toString():statement[index].transactionId,
                                                type: statement[index].type,
                                                data: statement[index],
                                                nobook:statement[index].noBook,
                                                userId:statement[index].customerId,
                                                bookId:statement[index].bookId,
                                                amount:statement[index].amount,
                                                set: set,
                                            );
                                          }).then((value) {

                                          getTransaction();
                                          getCredit();
                                          setState(() {

                                          });

                  }  );
                                    },
                                    child: const Icon(
                                      Icons.edit,
                                      color: Colors.grey,
                                    )),
                              )

                            ],
                          ),


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



  showAlertForWhatsappNumber() {
    showDialog(context: context,
        builder: (buildContext)
        {
          return AlertDialog(
            title:  Text('Update WhatsApp Number',style: GoogleFonts.montserrat(color: primarycolor2),),
            content:  Container(
              height: height*0.2,
              child: SingleChildScrollView(
                child: Column(
                  children: [
                    Text('Please update whatsapp number',style: GoogleFonts.montserrat(color: primarycolor2)),

                    SizedBox(height: 20,),
                    Padding(
                      padding: const EdgeInsets.all(10.0),
                      child: IntlPhoneField(
                        style: TextStyle(color: Colors.black),
                        dropdownTextStyle: TextStyle(color: Colors.black),
                        keyboardType: TextInputType.phone,
                        controller: whatsAppNumberController,
                        readOnly: false,
                        onSaved: (value){

                        },
                        onSubmitted: (value){

                        },
                        decoration: InputDecoration(
                          iconColor: Colors.black,
                          counterStyle: TextStyle(color: Colors.black),
                          hintText: 'Enter your whatsapp number...',
                          hintStyle: GoogleFonts.nunito(
                            color: Colors.black,
                            fontSize: 14,
                            fontWeight: FontWeight.normal,
                          ),

                          labelText: 'WhatsApp Number',
                          labelStyle: GoogleFonts.nunito(
                            color: Colors.black,
                            fontSize: 14,
                            fontWeight: FontWeight.normal,
                          ),

                          disabledBorder: OutlineInputBorder(
                            borderSide: BorderSide(color: Colors.black, width: 1),
                            borderRadius: BorderRadius.circular(8),
                          ),

                          focusedBorder: OutlineInputBorder(
                            borderSide: BorderSide(color: Colors.black, width: 1),
                            borderRadius: BorderRadius.circular(8),
                          ),

                          enabledBorder: OutlineInputBorder(
                            borderSide: BorderSide(color: Colors.black, width: 1),
                            borderRadius: BorderRadius.circular(8),
                          ),

                          border: OutlineInputBorder(
                            borderSide: BorderSide(color: Colors.black, width: 2),
                            borderRadius: BorderRadius.circular(8),
                          ),
                        ),

                        initialCountryCode: initialCountryCode,
                        dropdownIcon: Icon(Icons.arrow_drop_down,color: Colors.black,),
                        onChanged: (phone) {

                          countryCode = phone.countryCode;

                          print(countryCode);

                        },
                        onCountryChanged: (country) {

                          phoneCode = country.dialCode;
                          print('"""""""""country"""""""""');
                          print(phoneCode);
                          print(country.dialCode);
                        },
                      ),
                    ),
                    SizedBox(height: 20,),


                  ],
                ),
              ),
            ),
            actions: [
              TextButton(onPressed: (){
                Navigator.pop(buildContext);
              },
                  child:  Text('Cancel',style: GoogleFonts.montserrat(color: primarycolor1))),
              TextButton(onPressed: (){
                print('userID');
                print(userID);
                FirebaseFirestore.instance.collection('users')
                .doc(userID).update({
                  'whatsappNumber':whatsAppNumberController.text,
                  'phonePrefix' :  phoneCode,
                }).then((value) {
                  try {
                    WhatsappShare.share(
                        phone: phoneCode + whatsAppNumberController.text,
                        text: 'Greetings from My Book \n$currentshopName \nHi, $customerName \nyour outstanding amount as of ${DateFormat('dd/MM/yyyy').format(DateTime.now())} is $currencyCode  ${credit.toStringAsFixed(2)}');
                  } catch (e) {
                    showErrorMessage(
                        context, e.toString(), style: GoogleFonts.montserrat());
                  }
                });
                Navigator.pop(buildContext);
              },
                  child:  Text('Yes',style: GoogleFonts.montserrat(color: primarycolor1))),
            ],
          );

        });
  }

}
class EditAmountPage extends StatefulWidget {
  final String id;
  final String userId;
  final String bookId;
  final int type;
  final double amount;
  final bool nobook;
  final Function set;
   final dynamic data;
   const EditAmountPage({Key? key, required this.id, required this.type, required this.data, required this.nobook, required this.userId, required this.bookId, required this.amount, required this.set, }) : super(key: key);

  @override
  State<EditAmountPage> createState() => _EditAmountPageState();
}

class _EditAmountPageState extends State<EditAmountPage> {



  TextEditingController editAmount = TextEditingController();
  TextEditingController editDescription = TextEditingController();
  bool _value = false;

  @override
  void initState() {


     editAmount = TextEditingController(text:widget.data.amount.toString());    // TODO: implement initState
     _value = widget.nobook;    // TODO: implement initState
    super.initState();
  }
  @override
  Widget build(BuildContext context) {
    return SizedBox(
      height: 200,
      child: AlertDialog(
        content: Container(
          width: width * 1,
          height: width * 0.7,
          decoration: BoxDecoration(
              borderRadius:
              BorderRadius.circular(15)),
          child: Column(
            mainAxisAlignment:
            MainAxisAlignment.spaceEvenly,
            children: [
              Text(
                'Edit amount ',
                style: GoogleFonts.outfit(
                  fontSize: 15,
                ),
              ),
              Container(
                width: width * 1,
                // height: width * 0.12,
                decoration: BoxDecoration(
                    borderRadius:
                    BorderRadius.circular(
                        15),
                    border: Border.all(
                        color: primarycolor1)),
                child: TextFormField(
                  controller: editAmount,
                  cursorColor: Colors.black,
                  style: GoogleFonts.outfit(
                    color: primarycolor1,
                    fontWeight: FontWeight.w600,
                    fontSize: 15,
                  ),
                  keyboardType:
                  TextInputType.text,
                  decoration: InputDecoration(
                    hintText:
                    'Enter amount',
                    hintStyle:
                    GoogleFonts.outfit(
                      color:
                      Colors.grey.shade100,

                      fontWeight:
                      FontWeight.w500,
                      fontSize: 15,
                    ),
                    fillColor:
                    Colors.grey.shade100,
                    filled: true,
                    disabledBorder:
                    InputBorder.none,
                    enabledBorder:
                    OutlineInputBorder(
                        borderSide:
                        BorderSide(
                            color:
                            primarycolor1,
                            width: 1.0),
                        borderRadius:
                        BorderRadius
                            .circular(
                            15)),
                    errorBorder:
                    InputBorder.none,
                    border: InputBorder.none,

                    focusedBorder:
                    UnderlineInputBorder(
                      borderRadius:
                      BorderRadius.circular(
                          15),
                      borderSide: BorderSide(
                        color: primarycolor1,
                        width: 2,
                      ),
                    ),

                    //
                    // border: OutlineInputBorder(),
                    // focusedBorder: OutlineInputBorder(
                    //     borderSide: BorderSide(color: Color(0xff034a82),width: 2)
                    // ),
                  ),
                ),
              ),
              const SizedBox(height: 5,),
              Text(
                'No book ',
                style: GoogleFonts.outfit(
                  fontSize: 15,
                ),
              ),
              Center(
                child: Switch(
                  value: _value,
                  onChanged: (bool newValue) {
                    setState(() {
                      _value = newValue;
                    });

                  },
                ),
              ),

              InkWell(
                onTap: () async {

                  if(editAmount.text!=''){

                    if(widget.type==0){

                      FirebaseFirestore.instance.collection('users').doc(widget.userId)
                          .collection('purchase').doc(widget.id).update({
                        'amount': double.tryParse(editAmount.text.toString())??0,
                        'noBook':_value,
                        'balance':FieldValue.increment((double.parse((editAmount.text.toString()))-widget.amount)),

                      }).then((value) {
                        FirebaseFirestore.instance.collection('shops')
                            .doc(currentshopId)
                            .collection('book').doc(widget.bookId).update({

                          'credit':FieldValue.increment((double.parse((editAmount.text.toString()))-widget.amount)),
                        });
                      }).then((value) {
                        FirebaseFirestore.instance.collection('shops').doc(currentshopId).update(
                            {
                              'totalCredit':FieldValue.increment((double.parse((editAmount.text.toString()))-widget.amount)),

                            });
                      });

                      setState(() {});


                    } else {

                      FirebaseFirestore.instance.collection('users').doc(widget.userId)
                          .collection('transactions').doc(widget.id).update({
                        'amount': double.tryParse(editAmount.text.toString())??0,
                        'noBook':_value,
                        'balance':FieldValue.increment((double.parse((editAmount.text.toString()))-widget.amount)),

                      }).then((value) {
                           FirebaseFirestore.instance.collection('shops')
                            .doc(currentshopId)
                            .collection('book').doc(widget.bookId).update({

                          'credit':FieldValue.increment(widget.amount-(double.parse((editAmount.text.toString())))),
                        });
                      }).then((value) {
                        FirebaseFirestore.instance.collection('shops').doc(currentshopId).update(
                            {
                              'totalCredit':FieldValue.increment(widget.amount-(double.parse((editAmount.text.toString())))),
                            });
                      });
                      setState(() {});

                    }
                     setState(() {});
                    Navigator.pop(context);
                    widget.set();

                  }else{
                    showUploadMessage1(context, 'Please enter amount', style: GoogleFonts.montserrat());
                  }


                },
                child: Container(
                  width: width * 0.3,
                  height: width * 0.12,
                  decoration: BoxDecoration(
                    borderRadius:
                    BorderRadius.circular(
                        15),
                    color: primarycolor1,
                  ),
                  child: Center(
                    child: Text(
                      " Ok",
                      style: GoogleFonts.outfit(
                          fontSize:
                          width * 0.05,
                          color: Colors.white,
                          fontWeight:
                          FontWeight.w600),
                    ),
                  ),
                ),
              ),

            ],
          ),
        ),

      ),
    );
  }




}
