
import 'package:agrohub/features/auth/screen/splash.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:google_sign_in/google_sign_in.dart';
import 'package:shared_preferences/shared_preferences.dart';


import '../../../core/globals/local_variables.dart';
import '../../Home/screen/selectShop.dart';
import 'login.dart';

class Authentication {
  final FirebaseAuth _auth = FirebaseAuth.instance;

  signInWithGoogle(BuildContext context) async {
    await GoogleSignIn().signOut();
    final FirebaseAuth auth = FirebaseAuth.instance;
    final GoogleSignIn googleSignIn = GoogleSignIn();
    final GoogleSignInAccount? googleSignInAccount = await googleSignIn
        .signIn();
    if (googleSignInAccount != null) {
      final GoogleSignInAuthentication googleSignInAuthentication =
      await googleSignInAccount.authentication;
      final AuthCredential authCredential = GoogleAuthProvider.credential(
          idToken: googleSignInAuthentication.idToken,
          accessToken: googleSignInAuthentication.accessToken);
      UserCredential result = await auth.signInWithCredential(authCredential);
      User? user = result.user;
      if (result.user != null) {
        // if(adminUsers.contains(user!.email)){
        SharedPreferences localStorage = await SharedPreferences.getInstance();
        localStorage.setString('email', user!.email ?? '');
        currentShopEmail = user.email ?? '';
        currentShopImage = user.photoURL ?? '';

        Navigator.pushReplacement(
            context, MaterialPageRoute(builder: (context) =>
            SelectShopWidget(
              email: user.email.toString(),
            )));
        // }
        // else{
        //   showUploadMessage(context, 'Access denied');
        // }

      }
      // if result not null we simply call the MaterialpageRoute,
      //
      // for go to the HomePage screen


      //    id=googleSignInAccount.id;
    }
  }

}


// Future<void> verifyPhoneNumber(BuildContext context) async {
//   await FirebaseAuth.instance.verifyPhoneNumber(
//     phoneNumber: phoneNumber,
//     timeout: const Duration(seconds: 15),
//     verificationCompleted: (AuthCredential authCredential) {
//       setState(() {
//         authStatus = "Your account is successfully verified";
//       });
//     },
//     verificationFailed: (AuthException authException) {
//       setState(() {
//         authStatus = "Authentication failed";
//       });
//     },
//     codeSent: (String verId, [int forceCodeResent]) {
//       verificationId = verId;
//       setState(() {
//         authStatus = "OTP has been successfully send";
//       });
//       otpDialogBox(context).then((value) {});
//     },
//     codeAutoRetrievalTimeout: (String verId) {
//       verificationId = verId;
//       setState(() {
//         authStatus = "TIMEOUT";
//       });
//     },
//   );
// }

//SIGN OUT
// signOut() {
//   _auth.signOut();
//   // .then((value) => Navigator.pushAndRemoveUntil(
//   // context,
//   // MaterialPageRoute(
//   //   builder: (context) => const Routing(),
//   // ),
//   // (route) => false));
// }
//
// googleSignOut() {
//   GoogleSignIn().signOut();
// }
// signOut(BuildContext context) async {
//   // await listenUserSub?.cancel();
//   GoogleSignIn().disconnect();
//   await FirebaseAuth.instance
//       .signOut()
//       .then((value) => Navigator.pushAndRemoveUntil(
//       context,
//       MaterialPageRoute(
//         builder: (context) => GetOtpPage(),
//       ),
//           (route) => false));
// }

