import 'dart:async';
import 'dart:developer';

import 'package:agrohub/core/globals/local_variables.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:shared_preferences/shared_preferences.dart';

import '../../../core/utils/utils.dart';
import '../../../themes/color.dart';
import '../../Home/screen/NavigationBar.dart';
import '../../Home/screen/selectShop.dart';

import 'authentication.dart';
import 'login.dart';

// var width;
// var height;
String currentShopEmail='';
String currentShopImage='';
class Splash extends StatefulWidget {
  const Splash({Key? key}) : super(key: key);

  @override
  State<Splash> createState() => _SplashState();
}

class _SplashState extends State<Splash> {
  final Authentication _auth = Authentication();
  @override
  bool login=false;

  @override
  getValidation() async {

     final localStorage= await SharedPreferences.getInstance();

     // bool log=userDataBox!.get('email');
     bool log=localStorage.containsKey('email');
   // var email=userDataBox?.get('email');
    print('email');
    // if(email!='' &&email!=null) {
    if(log) {
      currentShopEmail=localStorage.getString('email')!;      // currentShopEmail=userDataBox?.get('email')!;
      // if(shopAdmins.contains(currentShopUserEmail)){
      login=true;
      setState(() {

      });

    }

    setState(() {

    });


  }
  
  updateUserData(){
    FirebaseFirestore.instance.collection('shops').
    // doc('0UODnE0BJRVO6wVD0DWj').collection('book').get().then((mainColl) {
    doc(currentshopId).collection('book').get().then((mainColl) {

      // for(DocumentSnapshot doc in mainColl.docs) {
      //
      //   doc.reference.collection('book').get().then((subColl) async {
          for(DocumentSnapshot subDoc in mainColl.docs) {

            String comp=subDoc['company'].toString().trimRight();
            log('"""""""""comp"""""""""');
            log(comp);

            subDoc.reference.update({

              'company' : comp.toUpperCase().trim(),

            });

            // print('================================');
            // // print(doc['storeName']);
            // // // print('================================');
            // // print(subDoc['bookName']);
            // // print(subDoc['members']);
            //
            // List members = subDoc['members'];
            // List search=[];
            //
            // search= await setSearchParam('${(doc['storeName']).toString().trim()} ${(subDoc['bookName']).toString().trim()}');
            //
            // String comp='';
            //
            // for(String i in members ){
            //   List s=[];
            //   s= await setSearchParam(i);
            //
            //
            //
            //   search.addAll(s);
            //
            //   subDoc.reference.update({
            //     'search':search,
            //     'company':comp,
            //   });


              ///Update User Data
              // await FirebaseFirestore.instance.collection('users').where('userEmail',isEqualTo: i)
              //     .get().then((user) async {
              //       if(user.docs.isNotEmpty) {
              //         print('***************************');
              //         print(user.docs[0]['userName']);
              //         List books=[];
              //
              //         try {
              //           // books=user.docs[0]['books'];
              //           comp=user.docs[0]['userName'];
              //         }catch (e) {
              //           books=[];
              //         }
              //
              //         List d=[];
              //         d= await setSearchParam(comp);
              //
              //         subDoc.reference.update({
              //           'search':FieldValue.arrayUnion(d),
              //           // 'company':comp,
              //         });
              //         // if(!books.contains('${doc.id}-${subDoc['bookName']}')){
              //         //   user.docs[0].reference.update({
              //         //     'books':FieldValue.arrayUnion(['${doc.id}-${subDoc['bookName']}']),
              //         //   });
              //         // }
              //
              //       }
              //
              // });
            }

            ///Update User Data
            // FirebaseFirestore.instance.collection('users').where('userEmail',isEqualTo: i)
            //     .get().then((user) {
            //       if(user.docs.isNotEmpty) {
            //         print('***************************');
            //         print(user.docs[0]['userName']);
            //         List books=[];
            //         try {
            //           books=user.docs[0]['books'];
            //         }catch (e) {
            //           books=[];
            //         }
            //         if(!books.contains('${doc.id}-${subDoc['bookName']}')){
            //           user.docs[0].reference.update({
            //             'books':FieldValue.arrayUnion(['${doc.id}-${subDoc['bookName']}']),
            //           });
            //         }
            //
            //       }
            //
            // });

            // print('"""""""""""""""s"""""""""""""""');
            // print(search);



            ///userEmail

        // });
      // }

    });
    
    ///
    
    // FirebaseFirestore.instance.collection('users').get().then((userColl) async {
    //   for(DocumentSnapshot doc in userColl.docs) {
    //     String con='';
    //     // doc.reference.update({
    //     //   'whatsappNumber':'',
    //     //   'phonePrefix':'',
    //     // });
    //     try{
    //       con = doc['countryCode'];
    //     } catch (e) {
    //       con='';
    //     }
    //
    //     if(con.isNotEmpty){
    //
    //       if(con =='QA') {
    //         doc.reference.update({
    //           'phonePrefix':'974'
    //         });
    //       } else if(con =='AE') {
    //         doc.reference.update({
    //           'phonePrefix':'971'
    //         });
    //       } else if(con =='AI') {
    //         doc.reference.update({
    //           'phonePrefix':'1264'
    //         });
    //       } else if(con =='AM') {
    //         doc.reference.update({
    //           'phonePrefix':'374'
    //         });
    //       } else if(con =='BD') {
    //         doc.reference.update({
    //           'phonePrefix':'880'
    //         });
    //       } else if(con =='ET') {
    //         doc.reference.update({
    //           'phonePrefix':'251'
    //         });
    //       } else if(con =='IN') {
    //         doc.reference.update({
    //           'phonePrefix':'91'
    //         });
    //       }else if(con =='KE') {
    //         doc.reference.update({
    //           'phonePrefix':'254'
    //         });
    //       } else if(con =='LK') {
    //         doc.reference.update({
    //           'phonePrefix':'94'
    //         });
    //       } else if(con =='MA') {
    //         doc.reference.update({
    //           'phonePrefix':'212'
    //         });
    //       } else if(con =='NP') {
    //         doc.reference.update({
    //           'phonePrefix':'977'
    //         });
    //       } else if(con =='PH') {
    //         doc.reference.update({
    //           'phonePrefix':'63'
    //         });
    //       } else if(con =='PK') {
    //         doc.reference.update({
    //           'phonePrefix':'92'
    //         });
    //       } else if(con =='SD') {
    //         doc.reference.update({
    //           'phonePrefix':'249'
    //         });
    //       } else if(con =='UG') {
    //         doc.reference.update({
    //           'phonePrefix':'256'
    //         });
    //       }
    //
    //
    //
    //
    //
    //       // FirebaseFirestore.instance.collection('shops')
    //       //     .doc(shopId).get().then((value) {
    //       //
    //       //       List a =[];
    //       //       try {
    //       //         a= value['companies'];
    //       //       } catch (e) {
    //       //         a=[];
    //       //       }
    //       //
    //       //
    //       //       if(!a.contains(doc['companyName'])) {
    //       //         value.reference.update({
    //       //           'companies':FieldValue.arrayUnion([doc['companyName']]),
    //       //         });
    //       //       }
    //       //
    //       // });
    //     }
    //
    //     // if(books.isNotEmpty) {
    //     //
    //     //   for(String i in books){
    //     //
    //     //     List b= i.split('-').toList();
    //     //     List search = await setSearchParam(doc['companyName']);
    //     //     for(String k in b) {
    //     //       List s= await setSearchParam(k);
    //     //
    //     //       search.addAll(s);
    //     //
    //     //     }
    //     //
    //     //     doc.reference.update({
    //     //       'search':search,
    //     //     });
    //     //     print('"""""""""""""books"""""""""""""');
    //     //     print(search);
    //     //   }
    //     //
    //     //
    //     // }
    //   }
    // });
    
  }
  
  void initState() {
    // updateUserData();
    getValidation();
    // getUserData();
    Timer(Duration(seconds: 3), () {
      Navigator.pushAndRemoveUntil(
          context, MaterialPageRoute(
          builder: (context)=>
          login?SelectShopWidget( email:currentShopEmail):Login()), (route) => false);
      // Navigator.pushAndRemoveUntil(context, MaterialPageRoute(builder:  (context) =>SelectShopWidget( email:currentShopEmail) ,), (route) => false);


      // if(currentUserEmail!=null&& currentUserEmail!="" ){
      // }

      // }else{

      // Navigator.pushAndRemoveUntil(context, MaterialPageRoute(builder: (context)=>LoginSelectPage()), (route) => false);
      // }
      //
      //
    });
    super.initState();
  }
  @override
  Widget build(BuildContext context) {
    width = MediaQuery.of(context).size.width;
    height = MediaQuery.of(context).size.height;
    return Container(
      color: Colors.white,
      height: width*2.2,
      width: width,
      child: Center(
        child: CircularProgressIndicator(
          color: primarycolor1,
        ),
      ),
    );
  }
}


setSearchParam(String caseNumber) {
  List<String> caseSearchList = <String>[];
  String temp = "";

  List<String> nameSplits = caseNumber.split(" ");
  for (int i = 0; i < nameSplits.length; i++) {
    String name = "";

    for (int k = i; k < nameSplits.length; k++) {
      name = name + nameSplits[k] + " ";
    }
    temp = "";

    for (int j = 0; j < name.length; j++) {
      temp = temp + name[j];
      caseSearchList.add(temp.toUpperCase());
    }
  }
  return caseSearchList;
}