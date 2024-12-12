import 'dart:developer';

import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';

import 'package:virtual_keyboard_multi_language/virtual_keyboard_multi_language.dart';

import '../../../../Model/TransactionModel/transactionModel.dart';
import '../../../../Model/purchase/purchaseModel.dart';
import '../../../../core/utils/utils.dart';
import '../../../../model/notification_model/notification_model.dart';
import '../../../../themes/color.dart';
import '../../../Home/screen/homePage.dart';
import '../../../Home/screen/selectShop.dart';
import '../../../auth/screen/splash.dart';

class SalesTransactionPage extends StatefulWidget {
  final String email;

  const SalesTransactionPage({Key? key, required this .email}) : super(key: key);

  @override
  State<SalesTransactionPage> createState() => _SalesTransactionPageState();
}

class _SalesTransactionPageState extends State<SalesTransactionPage> {
  int index=0;
  String text = '';
  String customerName='';
  String customerPhone='';
  String customerEmail='';
  String customerImage='';
  String customerId='';
  List<dynamic> customerTokens=[];
  String customerIdNo='';
  String CompanyName='';
  String doorNo='';
  String userBookName='';
  String  userBookId='';
  double  bookCreditAmount=0.00;
  double  creditLimit=0.00;
  bool noUser=false;
  bool noBook=false;
  // Timestamp ?today;
  bool _value = false;

  bool disable=false;
  getUserDetailes(){

    log( widget.email);
    FirebaseFirestore.instance.collection('users').
    where('userEmail',isEqualTo: widget.email).
    get().then((event) {
      if(event.docs.isNotEmpty) {
        DocumentSnapshot doc =event.docs[0];

        customerName=doc.get('userName');

        customerPhone=doc.get('phone');

        customerEmail=doc.get('userEmail');

        customerImage=doc.get('userImage');

        customerId=doc.get('userId');
        customerTokens=doc.get('token');

        CompanyName=doc.get('companyName');
        doorNo=doc.get('doorNumber');


        // }

      }
      else{
        noUser=true;
      }
      if(mounted){
        setState(() {

        });
      }



    });
  }
  getBook(){
    FirebaseFirestore.instance.collection('shops')
        .doc(currentshopId)
        .collection('book').
    where('delete',isEqualTo: false).
    where('members',arrayContains: widget.email).get().then((value) {
      if(value.docs.isNotEmpty) {
        for(DocumentSnapshot doc in value.docs){
          userBookName=doc.get('bookName');
          userBookId=doc.get('bookId');
          userBookId=doc.get('bookId');
          bookCreditAmount=double.tryParse(doc.get('credit').toString())!;
          creditLimit=double.tryParse(doc.get('creditLimit').toString())!;

          // customerReward=doc.get('customerReward');
        }

        // }

      }else{
        noBook=true;
      }
      if(mounted){
        setState(() {

        });
      }



    });

  }

  @override
  void initState() {
    getUserDetailes();
    getBook();
    // today=Timestamp.now();


    // TODO: implement initState
    super.initState();
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
        ),
        body: Padding(
          padding:  EdgeInsets.all(width*0.03),
          child: noUser==true?SizedBox(
              height: height,
              child: Center(
                child: Text('Unknown Customer',style: GoogleFonts.montserrat(
                    fontSize: 20,
                    color: primarycolor1
                ),),
              )
          ):SingleChildScrollView(
            child: Column(
              children: [
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
                              const SizedBox(height: 20,),
                              Row(
                                children: [
                                  SizedBox(width: width*0.01,),
                                  Expanded(
                                    child: Column(
                                      crossAxisAlignment: CrossAxisAlignment.stretch,
                                      children: [
                                        Text(
                                          'Customer Profile Info,',
                                          style: GoogleFonts.montserrat(
                                              fontSize: 16
                                          ),),
                                        Text(
                                          'Credit Limit : $creditLimit',
                                          style: GoogleFonts.montserrat(
                                              fontSize: 20
                                          ),),
                                      ],
                                    ),
                                  ),
                                  Container(
                                      color: primarycolor1,

                                      child: Padding(
                                        padding: const EdgeInsets.all(8.0),
                                        child: Center(child: Text(

                                            userBookName,
                                            style: GoogleFonts.montserrat(
                                                fontSize: 25,
                                                fontWeight: FontWeight.w700,
                                                color: Colors.white,

                                            ))
                                        ),
                                      )),
                                ],
                              ),
                              const Padding(
                                padding: EdgeInsets.only(left: 18.0,right: 18),
                                child: Divider(thickness: 1),
                              ),
                              Row(
                                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                                children: [
                                  // Padding(
                                  //   padding:  EdgeInsets.only(bottom: width*0.08,left: width*0.04,top:width*0.01 ),
                                  //   child: Container  (
                                  //     // color: Colors.green,
                                  //     height: width*0.17,
                                  //     width:width*0.2,
                                  //
                                  //     child: ClipRRect(
                                  //         borderRadius: BorderRadius.circular(8),
                                  //         child: customerImage!=""?
                                  //         CachedNetworkImage(imageUrl:customerImage ,fit: BoxFit.contain,):Container()
                                  //
                                  //     ),
                                  //   ),
                                  // ),
                                  Padding(
                                    padding:  EdgeInsets.only(bottom: width*0.08,left: width*0.04,top:width*0.01 ),
                                    child: Column(
                                      mainAxisAlignment: MainAxisAlignment.center,
                                      crossAxisAlignment: CrossAxisAlignment.start,
                                      children: [
                                        SizedBox(
                                          width: width*0.3,
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
                                        SizedBox(
                                          width: width*0.3,

                                          child: Text(
                                            customerEmail.toString(),
                                            style:
                                            GoogleFonts.montserrat(
                                                fontSize: 14,
                                                color: primarycolor1
                                            ),

                                          ),

                                        ),

                                      ],
                                    ),
                                  ),
                                  Column(
                                    children: [

                                      SizedBox( width:width*0.2,

                                          child: Center(child: Text(

                                          'Credit',
                                              style: GoogleFonts.montserrat(
                                                fontSize: 15,))
                                          )),
                                      SizedBox(
                                          width:width*0.2,

                                          child: Center(child: Text(
                                              bookCreditAmount.toStringAsFixed(2),
                                            style: GoogleFonts.montserrat(
                                                fontSize: 18,
                                            color: Colors.red))
                                          )),
                                    ],
                                  ),

                                ],
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
                const SizedBox(height: 15,),
                Row(
                  mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                  children: [
                    InkWell(
                      onTap: (){
                        setState(() {
                          index=0;
                        });
                      },
                      child: Container(
                        width: width * 0.25,
                        height: height * 0.045,
                        decoration: BoxDecoration(
                            color: index==0?primarycolor1:Colors.white,
                            border: Border.all(color: primarycolor1),
                            // gradient:
                            borderRadius: const BorderRadius.all(Radius.circular(20))),
                        child: Center(
                          child: Text(
                            'Sale',
                            style:
                            GoogleFonts.montserrat(color:index==0?
                            Colors.white:primarycolor1, fontSize: width * 0.04),
                          ),
                        ),
                      ),
                    ),

                    InkWell(
                      onTap: (){

                        setState(() {
                          index=1;
                        });
                      },

                      child: Container(
                        width: width * 0.25,
                        height: height * 0.045,
                        decoration: BoxDecoration(
                            color: index==1?primarycolor1:Colors.white,
                            border: Border.all(color: primarycolor1),

                            // gradient:
                            borderRadius: const BorderRadius.all(Radius.circular(20))),
                        child: Center(
                          child: Text(
                            'Receive',
                            style:
                            GoogleFonts.montserrat(color:index==1? Colors.white:primarycolor1, fontSize: width * 0.04),
                          ),
                        ),
                      ),
                    ),
                    Row(
                      children: [
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
                        _value==true?Text('No Book',style: GoogleFonts.montserrat(
                          color: Colors.red
                        ),):const SizedBox()
                      ],
                    ),
                  ],
                ),
                SizedBox(
                  height: height * 0.01,
                ),
                Center(
                  child: Container(
                    height: height * 0.07,
                    width: width * 0.9,
                    decoration: BoxDecoration(
                      border: Border.all(color: primarycolor1),
                      borderRadius: const BorderRadius.all(
                        Radius.circular(20),
                      ),
                    ),
                    child: Center(
                      child: Text(text==''?'Enter amount':text.toString(),
                          style: GoogleFonts.montserrat(fontSize: width * 0.04)),
                    ),
                  ),
                ),
                SizedBox(
                  height: height * 0.03,
                ),
                index==0
                    ?InkWell (
                  onTap: (){
                    if((double.tryParse(text)??0)==0){
                      showUploadMessage1(context, 'Enter a valid amount', style:  GoogleFonts.montserrat());
                      return;
                    }
                    if(text!='' && userBookName!=''&& ((bookCreditAmount+(double.tryParse(text)??0.00))<=creditLimit)){
                      showDialog(
                        context: context,
                        builder: (ctx) => AlertDialog(
                          title:  Text("Add Sale ",style:GoogleFonts.montserrat(
                              fontSize: 18,
                              fontWeight:FontWeight.w600,
                              color: primarycolor1),),
                          content:  Text("Are you Sure ?",style:GoogleFonts.montserrat(
                              fontSize: 16,
                              fontWeight:FontWeight.w600,
                              color: primarycolor1),),
                          actions: <Widget>[
                            Row(
                              mainAxisAlignment: MainAxisAlignment.spaceAround,
                              children: [
                                InkWell(
                                    onTap: (){
                                      Navigator.pop(ctx);
                                      // Navigator.pop(context);
                                    },
                                    child: Container(
                                      height: 40,
                                      width:60,
                                      decoration: BoxDecoration(
                                        borderRadius: BorderRadius.circular(10),
                                        border: Border.all(width: 2,color: primarycolor1),

                                      ),
                                      child: Center(
                                        child: Text('No',style:GoogleFonts.montserrat(
                                            fontSize: 14,
                                            fontWeight:FontWeight.w600,
                                            color: primarycolor1),),
                                      ),
                                    ),
                                ),
                                InkWell(
                                    onTap: () async {
                                     if(!disable) {
                                       disable=true;
                                                    final purchaseData =
                                                        PurchaseModel(
                                                            amount: double
                                                                    .tryParse(
                                                                        text) ??
                                                                0,
                                                            customerId:
                                                                customerId,
                                                            customerName:
                                                                customerName,
                                                            customerPhone:
                                                                customerPhone,
                                                            shopId:
                                                                currentshopId,
                                                            shopName:
                                                                currentshopName,
                                                            image:
                                                                currentShopImage,
                                                            status: 0,
                                                            verification: false,
                                                            date:
                                                                DateTime.now(),
                                                            bookId: userBookId,
                                                            bookName:
                                                                userBookName,
                                                            noBook: _value,
                                                            currencyShort:
                                                                currencyCode,
                                                            type: 0,
                                                            delete: false,
                                                          balance: bookCreditAmount +
                                                              (double.tryParse(text
                                                                  .toString()) ??
                                                                  0.00),

                                                        );

                                                    final notiData=NotificationModel(
                                                      date: DateTime.now(),
                                                      heading: "Added a Sale",
                                                      content: "Sale of $currencyCode $text added to your account by $currentshopName",
                                                      ownerEmail: currentShopEmail,
                                                      userId:customerId,
                                                      shopId: currentshopId,
                                                      userName: customerName,
                                                      shopName: currentshopName,
                                                      tokens: customerTokens,
                                                      view: false,

                                                    );

                                                    await createPurchase(
                                                        purchaseData,notiData);

                                                    Navigator.pop(ctx);
                                                    Navigator.pop(context);


                                                    // getShop();
                                                    text = '';
                                                    disable=false;
                                                  }
                                    },
                                    child: Container(
                                      height: 40,
                                      width:75,
                                      decoration: BoxDecoration(
                                        borderRadius: BorderRadius.circular(10),
                                        border: Border.all(width: 2,color: primarycolor1),

                                      ),
                                      child: Center(
                                        child: Text('Yes',style:GoogleFonts.montserrat(
                                            fontSize: 14,
                                            fontWeight:FontWeight.w600,
                                            color: primarycolor1),),
                                      ),
                                    )),
                              ],
                            ),

                          ],),
                      );
                    }
                    else{
                      text==''? showUploadMessage1(context, 'Enter  amount',style: GoogleFonts.montserrat()):
                      ((bookCreditAmount+(double.tryParse(text)??0.00))>creditLimit)?
                      showUploadMessage1(context, 'Your credit limit exceeded',style: GoogleFonts.montserrat()):
                      showUploadMessage1(context, 'Invalid Book Name',style: GoogleFonts.montserrat());

                    }
                  },
                  child: Container(
                    width: width * 0.4,
                    height: height * 0.06,
                    decoration: BoxDecoration(
                        gradient:
                        LinearGradient(colors: [primarycolor1, primarycolor2]),
                        borderRadius: const BorderRadius.all(Radius.circular(20))),
                    child: Center(
                      child: Text(
                        'Submit',
                        style:
                        GoogleFonts.montserrat(color: Colors.white, fontSize: width * 0.045),
                      ),
                    ),
                  ),
                )
                    :InkWell (
                  onTap: (){
                    if((double.tryParse(text)??0)==0){
                      showUploadMessage1(context, 'Enter a valid amount', style:  GoogleFonts.montserrat());

                      return;
                    }
                    if(text!='' && userBookName!=''){
                      showDialog(
                        context: context,
                        builder: (ctx) => AlertDialog(
                          title:  Text("Add Payment",style:GoogleFonts.montserrat(
                              fontSize: 18,
                              fontWeight:FontWeight.w600,
                              color: primarycolor1),),
                          content:  Text("Are you Sure ?",style:GoogleFonts.montserrat(
                              fontSize: 16,
                              fontWeight:FontWeight.w600,
                              color: primarycolor1),),
                          actions: <Widget>[
                            Row(
                              mainAxisAlignment: MainAxisAlignment.spaceAround,
                              children: [
                                InkWell(
                                    onTap: (){
                                      Navigator.pop(ctx);
                                      // Navigator.pop(context);
                                    },
                                    child: Container(
                                      height: 40,
                                      width:75,
                                      decoration: BoxDecoration(
                                        borderRadius: BorderRadius.circular(10),
                                        border: Border.all(width: 2,color: primarycolor1),

                                      ),
                                      child: Center(
                                        child: Text('No',style:GoogleFonts.montserrat(
                                            fontSize: 14,
                                            fontWeight:FontWeight.w600,
                                            color: primarycolor1),),
                                      ),
                                    )),
                                InkWell(
                                    onTap: () async {
                                      if(!disable){
                                        disable=true;

                                        final transactionData = TransactionModel(
                                                        amount: double.tryParse(
                                                                text
                                                                    .toString()) ??
                                                            0.00,
                                                        customerId: customerId,
                                                        customerName:
                                                            customerName,
                                                        customerPhone:
                                                            customerPhone,
                                                        noBook: _value,
                                                        shopId: currentshopId,
                                                        shopName:
                                                            currentshopName,
                                                        image: currentShopImage,
                                                        status: 0,
                                                        verification: false,
                                                        date: DateTime.now(),
                                                        bookId: userBookId,
                                                        bookName: userBookName,
                                                        currencyShort:
                                                            currencyCode,
                                                        type: 1,
                                                        delete: false,
                                                        balance: bookCreditAmount -
                                                            (double.tryParse(text
                                                                    .toString()) ??
                                                                0.00),
                                        );

                                        final notiData=NotificationModel(
                                          date: DateTime.now(),
                                          heading: "Added a Sale",
                                          content: "Sale of $currencyCode $text added to your account by $currentshopName",
                                          ownerEmail: currentShopEmail,
                                          userId:customerId,
                                          shopId: currentshopId,
                                          userName: customerName,
                                          shopName: currentshopName,
                                          tokens: customerTokens,
                                          view: false,

                                        );

                                                    await createTransaction(
                                                        transactionData,notiData);

                                                    Navigator.pop(ctx);
                                                    Navigator.pop(context);

                                                    // showUploadMessage(context,
                                                    //     'amount added successfully',
                                                    //     style: GoogleFonts
                                                    //         .montserrat());
                                                    // getShop();
                                                    text = '';
                                                    disable=false;
                                                  }
                                                },
                                    child: Container(
                                      height: 40,
                                      width:75,
                                      decoration: BoxDecoration(
                                        borderRadius: BorderRadius.circular(10),
                                        border: Border.all(width: 2,color: primarycolor1),

                                      ),
                                      child: Center(
                                        child: Text('Yes',style:GoogleFonts.montserrat(
                                            fontSize: 14,
                                            fontWeight:FontWeight.w600,
                                            color: primarycolor1),),
                                      ),
                                    )),
                              ],
                            ),

                          ],),
                      );
                    }
                    else{
                      text==''? showUploadMessage1(context, 'Enter  amount',style: GoogleFonts.montserrat()):
                      showUploadMessage1(context, 'Validity of plan is expired',style: GoogleFonts.montserrat());
                    }
                  },
                  child: Container(
                    width: width * 0.4,
                    height: height * 0.08,
                    decoration: BoxDecoration(
                        gradient:
                        LinearGradient(colors: [primarycolor1, primarycolor2]),
                        borderRadius: const BorderRadius.all(Radius.circular(20))),
                    child: Center(
                      child: Text(
                        'Pay',
                        style:
                        GoogleFonts.montserrat(color: Colors.white, fontSize: width * 0.04),
                      ),
                    ),
                  ),
                ),

                SizedBox(
                  height:  height* 0.02,
                ),
                Container(
                  height: height*0.35,
                  // Keyboard is transparent
                  color: primarycolor1,
                  child: VirtualKeyboard(
                    // height:height*0.7,
                      textColor: Colors.white,
                      fontSize: 20,

                      type: VirtualKeyboardType.Numeric,
                      onKeyPress: _onKeyPress
                    //     (key) {
                    //   print(key.text);
                    //   up(amount.contains('.') && key.text == "."
                    //       ? ""
                    //       :key.text==''?'':
                    //   key.text == "."
                    //           ? "."
                    //           : int.tryParse(key.text.toString() ?? '0'));
                    // }
                  ),
                )
              ],
            ),
          ),
        )
    );
  }
  createPurchase(PurchaseModel purchaseData, NotificationModel notiData,)  async {
    try{
      bool error =false;
      await FirebaseFirestore.instance.runTransaction((transaction) async {
        DocumentReference a=FirebaseFirestore.instance
            .collection('users')
            .doc(purchaseData.customerId)
            .collection('purchase').doc();
        purchaseData.purchaseId=a.id;
        transaction.set(a, purchaseData.toJson());

        /// ADD NOTIFICATION
        DocumentReference not=FirebaseFirestore.instance
            .collection('notifications')
            .doc();
        final notData=notiData.copyWith(
          docId: not.id,
          docRef: not
        );

        transaction.set(not, notData.toJson());
        ///

        DocumentReference b= FirebaseFirestore.instance
            .collection('shops')
            .doc(currentshopId)
            .collection('book')
            .doc(userBookId);
        transaction.update(b, {
          'credit': FieldValue.increment(purchaseData.amount ?? 0.00),
          'update': DateTime.now(),
        });

        DocumentReference c=FirebaseFirestore.instance.collection('shops').doc(currentshopId);
        transaction.update(c,{
        'totalCredit': FieldValue.increment(purchaseData.amount ?? 0.00),
        } );
        // if(mounted){
        //   showUploadMessage(context,
        //       'amount added successfully',
        //       style: GoogleFonts
        //           .montserrat());
        // }
      }).catchError((err){
        error=true;
        showErrorMessage(context, err.toString(), style:  GoogleFonts.montserrat());
      });
if(mounted && !error){
    showUploadMessage1(context,
        'amount added successfully',
        style: GoogleFonts
            .montserrat());
}


      // FirebaseFirestore.instance
      //     .collection('users')
      //     .doc(purchaseData.customerId)
      //     .collection('purchase')
      //     .add(purchaseData.toJson())
      //     .then((value) {
      //   value.update({'purchaseId': value.id});
      // });
      // FirebaseFirestore.instance
      //     .collection('shops')
      //     .doc(currentshopId)
      //     .collection('book')
      //     .doc(userBookId)
      //     .update({
      //   'credit': FieldValue.increment(purchaseData.amount ?? 0.00),
      //   'update': DateTime.now(),
      // });
      //
      // FirebaseFirestore.instance.collection('shops').doc(currentshopId).update({
      //   'totalCredit': FieldValue.increment(purchaseData.amount ?? 0.00),
      // });
    }catch(e){
      if(mounted) {
        showErrorMessage(
            context, e.toString(), style: GoogleFonts.montserrat());
      }
    }
  }


  createTransaction( TransactionModel transactionData, NotificationModel notiData,)  async {
    try{
      bool error=true;
      await FirebaseFirestore.instance.runTransaction(
              (transaction) async {
        DocumentReference a = FirebaseFirestore.instance
            .collection('users')
            .doc(customerId)
            .collection('transactions').doc();
        transactionData.transactionId=a.id;
        transaction.set(a, transactionData.toJson());

        /// ADD NOTIFICATION
        DocumentReference not=FirebaseFirestore.instance
            .collection('notifications')
            .doc();
        final notData=notiData.copyWith(
            docId: not.id,
            docRef: not
        );

        transaction.set(not, notData.toJson());
        ///

        ///
        DocumentReference b= FirebaseFirestore.instance
            .collection('shops')
            .doc(currentshopId)
            .collection('book')
            .doc(userBookId) ;
        transaction.update(b, {
          'credit': FieldValue.increment((-(transactionData.amount ?? 0.00))),
          'update': DateTime.now(),
        });

        ///
        DocumentReference c =  FirebaseFirestore.instance.collection('shops').doc(currentshopId);
        transaction.update(c, {
        'totalCredit':
        FieldValue.increment((-(transactionData.amount ?? 0.00))),
        });
        if(mounted){
          showUploadMessage1(context,
              'amount added successfully',
              style: GoogleFonts
                  .montserrat());
        }
      },
              timeout: const Duration(seconds: 120),
             maxAttempts: 10,
      )
          .catchError((err){
        error=true;
        showErrorMessage(context, err.toString(), style:  GoogleFonts.montserrat());
      });
      if(mounted && !error){
        showUploadMessage1(context,
            'amount added successfully',
            style: GoogleFonts
                .montserrat());
      }
      // FirebaseFirestore.instance
      //     .collection('users')
      //     .doc(customerId)
      //     .collection('transactions')
      //     .add(transactionData.toJson())
      //     .then((value) {
      //   value.update({
      //     'transactionId': value.id,
      //   });
      // });
      // FirebaseFirestore.instance
      //     .collection('shops')
      //     .doc(currentshopId)
      //     .collection('book')
      //     .doc(userBookId)
      //     .update({
      //   'credit': FieldValue.increment((-(transactionData.amount ?? 0.00))),
      //   'update': DateTime.now(),
      // });

      // id=value.id;

      // FirebaseFirestore.instance.collection('shops').doc(currentshopId).update({
      //   'totalCredit':
      //       FieldValue.increment((-(transactionData.amount ?? 0.00))),
      // });
    }catch(e){
      if(mounted) {
        showErrorMessage(
            context, e.toString(), style: GoogleFonts.montserrat());
      }
    }
  }
  _onKeyPress(VirtualKeyboardKey key) {
    if (!text.contains('.')) {
      text = "$text${key.text}";
    } else if (text.contains('.') && key.text != '.') {
      text = "$text${key.text}";
    }
    switch (key.action) {
      case VirtualKeyboardKeyAction.Backspace:
        if (text.isEmpty) return;
        text = text.substring(0, text.length - 1);
        break;
      default:
    }

// Update the screen
    setState(() {});
  }
}
