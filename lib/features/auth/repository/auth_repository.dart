import 'package:agrohub/features/auth/screen/splash.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:fpdart/fpdart.dart';
import 'package:google_sign_in/google_sign_in.dart';
import 'package:rounded_loading_button/rounded_loading_button.dart';
import 'package:shared_preferences/shared_preferences.dart';
import '../../../Model/usermodel/user_model.dart';
import '../../../core/constants/firebase_constants.dart';
import '../../../core/failure.dart';
import '../../../core/globals/local_variables.dart';
import '../../../core/providers/firebase_providers.dart';
import '../../../core/type_defs.dart';
import '../controller/auth_controller.dart';


final authRepositoryProvider = Provider((ref) => AuthRepository(
  firestore: ref.read(firestoreProvider),
  auth: ref.read(authProvider),
  googleSignIn: ref.read(googleSignInProvider),
  ref: ref,

),
);

class AuthRepository{
  final RoundedLoadingButtonController _btnController1 =
  RoundedLoadingButtonController();
  final FirebaseFirestore _firestore;
  final FirebaseAuth _auth;
  final GoogleSignIn _googleSignIn;
  final Ref _ref;

  AuthRepository({
    required FirebaseFirestore firestore,
    required FirebaseAuth auth,
    required GoogleSignIn googleSignIn,
    required Ref ref,
  })  : _auth = auth,
        _firestore = firestore,
        _googleSignIn = googleSignIn,
        _ref = ref;
  CollectionReference get _users => _firestore.collection(FirebaseConstants.usersCollection);

  Stream<User?> get authStateChange => _auth.authStateChanges();

  FutureEither<UserModel> signInWithGoogle({required BuildContext context,}) async {
    try {
      print("2");
      UserCredential userCredential;
      // if (kIsWeb) {
      //   GoogleAuthProvider googleProvider = GoogleAuthProvider();
      //   googleProvider.addScope('https://www.googleapis.com/auth/contacts.readonly');
      //   userCredential = await _auth.signInWithPopup(googleProvider);
      // } else {
      final GoogleSignInAccount? googleUser = await _googleSignIn.signIn();

      final googleAuth = await googleUser?.authentication;
      print("3");
      final credential = GoogleAuthProvider.credential(
        accessToken: googleAuth?.accessToken,
        idToken: googleAuth?.idToken,
      );
      userCredential = await _auth.signInWithCredential(credential);
      print("4");
      print(userCredential);

      //userCredential = await _auth.currentUser!.linkWithCredential(credential);

      // }

      UserModel userModel;

      if (userCredential.additionalUserInfo!.isNewUser) {
        // print("new user");
        // userDataBox?.put('email', userCredential.user!.email??"" );
        SharedPreferences localStorage =await SharedPreferences.getInstance();
        localStorage.setString('email', userCredential.user!.email??"");
        // currentShopEmail=userCredential.user!.email??"";

        userModel = UserModel(

          userName: userCredential.user!.displayName ?? 'No Name',
          userImage: userCredential.user!.photoURL ?? '',
          userEmail: userCredential.user!.email??"" ,
          userId: userCredential.user!.uid,
          // phone: '',
          countryCode: '',
          phone:userCredential.user!.phoneNumber??'',



        );
        _ref.read(userProvider.notifier).update((state) => userModel);
        // await _users.doc(userCredential.user!.uid).set(userModel.toJson());
      } else {
        userModel = UserModel(

          userName: userCredential.user!.displayName ?? 'No Name',
          userImage: userCredential.user!.photoURL ?? '',
          userEmail: userCredential.user!.email??"" ,
          userId: userCredential.user!.uid,
          // phone: '',
          countryCode: '',
          phone:userCredential.user!.phoneNumber??'',


        );

        // userDataBox?.put('email', userCredential.user!.email??"" );
        // currentShopEmail=userCredential.user!.email??"";
        // userDataBox?.put('uid', userCredential.user!.uid??"" );
        SharedPreferences localStorage =await SharedPreferences.getInstance();
        localStorage.setString('email', userCredential.user!.email??"");
        currentShopEmail=userCredential.user!.email??"";
        //userModel = await getUserData(userCredential.user!.uid).first;
        _ref.read(userProvider.notifier).update((state) => userModel);

      }
      return right(userModel);
    } on FirebaseException catch (e) {
      print(e.message);
      throw e.message!;

    } catch (e) {
      return left(Failure(e.toString()));
    }

  }
  Stream<UserModel> getUserData(String uid) {
    return _users.doc(uid).snapshots().map((event) => UserModel.fromJson(event.data() as Map<String, dynamic>));
  }



  void logOut() async {
    await _googleSignIn.signOut();
    await _auth.signOut();
  }
}
