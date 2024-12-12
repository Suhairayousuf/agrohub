import 'package:agrohub/features/auth/screen/splash.dart';
import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:google_sign_in/google_sign_in.dart';
import 'package:lottie/lottie.dart';

import 'package:upgrader/upgrader.dart';

import '../../../core/utils/utils.dart';
import '../../../themes/color.dart';
import '../../Home/screen/homePage.dart';
import '../../Home/screen/selectShop.dart';
import '../controller/auth_controller.dart';
import 'authentication.dart';



class Login extends ConsumerStatefulWidget {
  const Login({Key? key}) : super(key: key);

  @override
  ConsumerState<Login> createState() => _LoginState();
}

class _LoginState extends ConsumerState<Login> {
  final Authentication _auth = Authentication();
  late TextEditingController userName;
  late TextEditingController password;

  @override
  void initState() {
    userName=TextEditingController();
    password=TextEditingController();
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    width = MediaQuery.of(context).size.width;
    return UpgradeAlert(
      child: Scaffold(
        body: SingleChildScrollView(
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              SizedBox(
                height: width * 0.2,
              ),
              Center(
                child: Container(
                    height: width * 0.7,
                    width: width * 0.6,
                    child: Lottie.asset("assets/107723-logindvdvd.json")),
              ),
              SizedBox(
                height: width * 0.2,
              ),
              InkWell(
                onTap: () {
                  ref.read(authControllerProvider.notifier).signInWithGoogle(context);

                  // _auth.signInWithGoogle(context);
                },
                child: Container(
                  width: width * 0.87,
                  height: width * 0.15,
                  child: Row(
                    mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                    children: [
                      CircleAvatar(
                        backgroundImage: CachedNetworkImageProvider(
                            'https://cdn-icons-png.flaticon.com/512/300/300221.png?w=740&t=st=1679903646~exp=1679904246~hmac=1c3642d595d81b19dbc8ff4bd2452c0de9b41e48ad4e0ef3bc0aac4cc15ad7ac'),
                        backgroundColor: primarycolor2,
                      ),
                      Text(
                        'Continue with Google',
                        style: GoogleFonts.montserrat(
                            color: Colors.white,
                            fontSize: width * 0.06,
                            fontWeight: FontWeight.w500),
                      )
                    ],
                  ),
                  decoration: BoxDecoration(
                    color: primarycolor2,
                    borderRadius: BorderRadius.all(Radius.circular(20)),
                  ),
                ),
              ),

              Padding(
                padding:  EdgeInsets.all(width * 0.1),
                child: Column(
                  children: [
                    TextFormField(
                      controller: userName,
                      decoration: InputDecoration(
                        border: OutlineInputBorder(
                          borderRadius: BorderRadius.circular(20),
                          borderSide: BorderSide(color: Colors.black)
                        ),
                        hintText: "Username"
                      ),
                    ),
                    SizedBox(height: 10,),
                    TextFormField(
                      controller: password,
                      decoration: InputDecoration(
                          border: OutlineInputBorder(
                              borderRadius: BorderRadius.circular(20),
                              borderSide: BorderSide(color: Colors.black)
                          ),
                          hintText: "Password"
                      ),
                    ),
                    SizedBox(height: 20,),
                    Center(
                      child: InkWell(
                        onTap: (){
                          if(userName.text=="vivlio"&&password.text=='123456'){
                            Navigator.pushReplacement(context, MaterialPageRoute(builder: (context) => SelectShopWidget(
                              email:'vivlio@gmail.com',
                            )));
                          }else{
                            showUploadMessage1(context, 'Incorrect username or password', style: TextStyle());
                          }
                        },
                        child: Container(
                          decoration: BoxDecoration(
                            color: Colors.blue
                          ),
                          child: Padding(
                            padding: const EdgeInsets.all(8.0),
                            child: Text('auth',style: TextStyle(
                              color: Colors.white,
                              fontWeight: FontWeight.bold,
                              fontSize: 18
                            ),),
                          ),
                        ),
                      ),
                    )
                  ],
                ),
              ),

            ],
          ),
        ),
      ),
    );
  }
  //
  // G_auth() async {
  //   GoogleSignInAccount? googleUser = await GoogleSignIn().signIn();
  //   GoogleSignInAuthentication? googleAuth = await googleUser?.authentication;
  //   AuthCredential credential = GoogleAuthProvider.credential(
  //       accessToken: googleAuth?.accessToken, idToken: googleAuth?.idToken);
  //   UserCredential userCrential =
  //       await FirebaseAuth.instance.signInWithCredential(credential);
  //   if (userCrential.user != null) {
  //     User user = userCrential.user!;
  //     print(user.runtimeType);
  //     uId = user.uid;
  //     email = user.email;
  //
  //     // var data = await FirebaseFirestore.instance
  //     //     .collection('shops')
  //     //     .where('shopAdmins', arrayContains: email)
  //     //     .get();
  //     // if (data.docs.isNotEmpty) {
  //       Navigator.pushAndRemoveUntil(
  //           context,
  //           MaterialPageRoute(
  //             builder: (context) => NavBarPage(),
  //           ),
  //           (route) => false);
  //     // }
  //     // else {
  //     //   SnackBar(
  //     //     content: Text('Unauthorized Email'),
  //     //   );
  //     // }
  //   }
  // }
}
