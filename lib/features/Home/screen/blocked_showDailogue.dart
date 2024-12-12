import 'dart:async';

import 'package:agrohub/features/Home/screen/selectShop.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';

import '../../../core/utils/utils.dart';
import '../../../themes/color.dart';
import '../../auth/screen/splash.dart';
import 'NavigationBar.dart';

class BlockedShowDialoguePage extends StatefulWidget {
  const BlockedShowDialoguePage({Key? key}) : super(key: key);

  @override
  State<BlockedShowDialoguePage> createState() => _BlockedShowDialoguePageState();
}

class _BlockedShowDialoguePageState extends State<BlockedShowDialoguePage> {
  StreamSubscription? a;
  getShop(){
    a=FirebaseFirestore.instance.collection('shops').doc(currentshopId).snapshots().listen((event) {

      bool blocked=event['block'];
      if(!blocked){
        Navigator.pushAndRemoveUntil(context,
            MaterialPageRoute(builder: (context)=>NavBarPage()), (route) => false);

      }
    });
  }
  @override
  void initState() {
    getShop();
    super.initState();
  }
  @override
  void dispose() {
    a?.cancel();
    super.dispose();
  }
  @override
  Widget build(BuildContext context) {
    return Container(
      width: width,
      child: AlertDialog(
        title: Row(
          mainAxisAlignment:
          MainAxisAlignment.center,
          children: [
            Text(
              "Your shop has been \nblocked due to  unpaid\n payment."
                  "\n"
                  "Please contact \n admin to reactivate it ",
              style: GoogleFonts.montserrat(
                  fontSize: 20,
                  color: primarycolor1,
                  fontWeight: FontWeight.w500),
            ),
          ],
        ),
        // content: Container(
        //   height: width * 0.1,
        //   width: width * 0.3,
        //   decoration: BoxDecoration(
        //     color: primarycolor1,
        //     borderRadius:
        //     BorderRadius.circular(
        //         6),
        //   ),
        //   child: Center(
        //     child: Text(
        //       "Ok",
        //       style:
        //       GoogleFonts.montserrat(
        //         fontSize: 20,
        //         color: Colors.white,
        //         fontWeight:
        //         FontWeight.w400,
        //       ),
        //     ),
        //   ),
        // ),
      ),
    );
  }
}
