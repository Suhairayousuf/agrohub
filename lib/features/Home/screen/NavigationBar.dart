import 'dart:async';

import 'package:agrohub/features/Home/controller/home_controller.dart';
import 'package:agrohub/features/Home/screen/selectShop.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:fluid_bottom_nav_bar/fluid_bottom_nav_bar.dart';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

import 'package:upgrader/upgrader.dart';

import '../../../core/globals/local_variables.dart';
import '../../../core/utils/utils.dart';
import '../../../themes/color.dart';
import '../../Account/screen/accountdetailesPage.dart';
import 'package:flutter_svg/flutter_svg.dart';
import '../../Book/book/screen/search_book.dart';
import '../../manage/Transaction/screen/ManagePage.dart';
import '../../Offers/screen/offerList.dart';
import 'blocked_showDailogue.dart';
import 'homePage.dart';




List userList=[];
// List allUserList=[];

List<String> userEmailList=[];
// List<String> offlineuserEmailList=[];
Map userMap={};
// Map alluserMap={};

class NavBarPage extends ConsumerStatefulWidget {

  const NavBarPage({Key? key,
  }) : super(key: key);
  @override
  ConsumerState createState() {return _NavBarPageState();}
}

class _NavBarPageState extends  ConsumerState {

  getSettings()async{
    final trans= await ref.read(homeControllerProvider.notifier).getsettings();
    print("trans: $trans");
    // FirebaseFirestore.instance.collection('settings')
    //     .doc('settings').get().then((value) {
    //       if(value.exists){
    //         ref.read(editTransaction.notifier).state=value['editTran'];
    //         print(  ref.read(editTransaction.notifier).state);
    //       }
    // });
  }

  TextEditingController bookName = TextEditingController();

  StreamSubscription? a;
  StreamSubscription? b;
  getShop(){
   a= FirebaseFirestore.instance.collection('shops').doc(currentshopId).snapshots().listen((event) {

    bool blocked=event['block'];
    if(blocked){
      Navigator.pushAndRemoveUntil(context,
          MaterialPageRoute(builder: (context)=>BlockedShowDialoguePage()), (route) => false);

    }
  });
}

  Widget? _child;

  int selectedIndex=0;

  @override
  void initState() {
    // getUsers();
    getShop();
    getSettings();
    _child = ManagePage();
    super.initState();
  }

  // getUsers(){
  //   currentshopId
  //   print('object');
  //  b= FirebaseFirestore.instance.collection('users').snapshots().listen((event) {
  //     userList=[];
  //     userEmailList=[];
  //     // alluserMap={};
  //     for(var doc in event.docs){
  //       userList.add(doc.data());
  //       userEmailList.add(doc.get('userEmail'));
  //
  //       // alluserMap[doc['userEmail']]=doc.data();
  //       // userIdMap[doc['userId']]=doc.data();
  //
  //     }
  //
  //     if(mounted){
  //       setState(() {
  //
  //       });
  //     }
  //
  //
  //   });
  //   // FirebaseFirestore.instance.collection('offlineUsers').snapshots().listen((event) {
  //   //   allUserList=[];
  //   //   offlineuserEmailList=[];
  //   //   for(var doc in event.docs){
  //   //     allUserList.add(doc.data());
  //   //     offlineuserEmailList.add(doc.get('userEmail'));
  //   //     alluserMap[doc['userEmail']]=doc.data();
  //   //     // userIdMap[doc['userId']]=doc.data();
  //   //   }
  //   //   offlineuserEmailList.addAll(userEmailList);
  //   //   allUserList.addAll(userList);
  //   //
  //   //   if(mounted){
  //   //     setState(() {
  //   //
  //   //     });
  //   //   }
  //   //
  //   //
  //   // });
  //
  // }
@override
  void dispose() {
    a?.cancel();
    b?.cancel();
    super.dispose();
  }
  @override
  Widget build(context) {
    // Build a simple container that switches content based of off the selected navigation item
    return  UpgradeAlert(
      child: WillPopScope(

        onWillPop: () async {
          final shouldPop = await confirmQuitDialog1(context);
          return shouldPop ?? false;},
        child: Scaffold(
            backgroundColor:primarycolor1,
            extendBody: true,
            body: _child,
            bottomNavigationBar: FluidNavBar(

              icons: [
                FluidNavBarIcon(
                    icon: Icons.home_rounded,
                    backgroundColor:selectedIndex==0?primarycolor1:Colors.white,
                    extras: {"label": "Home"}),

                // FluidNavBarIcon(
                //     icon: Icons.manage_accounts,
                //     backgroundColor:selectedIndex==1?primarycolor2:Colors.white,
                //
                //     extras: {"label": "Manage"}),
                FluidNavBarIcon(

                    icon: Icons.book,
                    backgroundColor:selectedIndex==1?primarycolor1:Colors.white,
                    extras: {"label": "book"}),
                FluidNavBarIcon(

                    icon: Icons.person,
                    backgroundColor:selectedIndex==2?primarycolor1:Colors.white,
                    extras: {"label": "Profile"}),
                FluidNavBarIcon(
                  svgPath: "assets/offers.svg",

                    // icon: SvgPicture.asset("assets/icons/menu.svg"),
                    backgroundColor:selectedIndex==3?primarycolor1:Colors.white,
                    extras: {"label": "Offer"}),

              ],
              onChange: _handleNavigationChange,
              style: FluidNavBarStyle(
                iconUnselectedForegroundColor: primarycolor1,
                iconSelectedForegroundColor: Colors.white,
                barBackgroundColor: primarycolor1,
                iconBackgroundColor: primarycolor1,




              ),
              scaleFactor: 2,
              defaultIndex: 0,

              itemBuilder: (icon, item) => Semantics(


                label: icon.extras!["label"],
                child: item,
              ),
            ),
          ),
      ),
    );
  }

  void _handleNavigationChange(int index) {
    setState(() {
      switch (index) {
        case 0:
          _child =ManagePage();
          selectedIndex=0;
          setState(() {

          });
          break;
        // case 1:
        //   _child = ManagePage();
        //   selectedIndex=1;
        //   setState(() {
        //
        //   });
        case 1:
          _child = SearchBookPage();
          // _child = BookListPage();
          selectedIndex=1;
          setState(() {

          });
          break;
        case 2:
          _child = ProfilePage();
          selectedIndex=2;
          setState(() {

          });
          break;
      case 3:
        _child = OfferList();
        selectedIndex=3;
        setState(() {

        });

      }
      _child = AnimatedSwitcher(
     reverseDuration: Duration(milliseconds: 1),
        switchInCurve: Curves.easeOut,
        switchOutCurve: Curves.easeIn,
        duration: Duration(milliseconds: 1),
        child: _child,
      );
    });
  }
}