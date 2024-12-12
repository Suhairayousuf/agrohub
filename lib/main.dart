import 'package:firebase_core/firebase_core.dart';
import 'package:firebase_crashlytics/firebase_crashlytics.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

import 'features/auth/screen/splash.dart';
import 'firebase_options.dart';


import 'Model/bookModel.dart';


String? uId;

Future<void> main() async {


// ...
  WidgetsFlutterBinding.ensureInitialized();
  await Firebase.initializeApp(
    options: DefaultFirebaseOptions.currentPlatform,
  );

   // WidgetsFlutterBinding.ensureInitialized();
   //  await Firebase.initializeApp();
   // FlutterError.onError = FirebaseCrashlytics.instance.recordFlutterError;

   SystemChrome.setPreferredOrientations([
     DeviceOrientation.portraitUp,
   ]);
  // GoogleSignIn().signOut();
  runApp(ProviderScope(child: const MyApp()));
       // (error, stack) => FirebaseCrashlytics.instance.recordError(error, stack);

}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  // This widget is the root of your application.
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      debugShowCheckedModeBanner: false,

      theme: ThemeData(
        backgroundColor: Colors.white,
        primarySwatch: Colors.blue,
      ),
      home:Splash(),
    );
  }
}
String extractNumericPart(String input) {
  try {
    // Create a regular expression pattern to match numeric digits

    RegExp numericRegex = new RegExp(r'\d+');

    // Use the firstMatch method to find the first occurrence of the numeric part
    RegExpMatch? match = numericRegex.firstMatch(input);

    if (match != null) {
      // Extract the numeric part from the matched substring
      return match.group(0) ?? "0";
    }

    return "";
  }
  catch(ex){
    return "";
  }
}
int sortBooks(BookModel a, BookModel b){
  // Extracting the letter part from the names
  String aLetterPart = a.bookName!.toUpperCase().replaceAll(RegExp(r'[0-9]'), '');
  String bLetterPart = b.bookName!.toUpperCase().replaceAll(RegExp(r'[0-9]'), '');

  // Extracting the numeric part from the names
  // int aNumericPart = int.tryParse(a.bookName!.replaceAll(RegExp(r'[A-Za-z]'), ''))??0;
  int aNumericPart = int.tryParse(extractNumericPart(a.bookName!))??0;
  // int bNumericPart = int.tryParse(b.bookName!.replaceAll(RegExp(r'[A-Za-z]'), ''))??0;
  // int bNumericPart = int.tryParse(b.bookName!.replaceAll(RegExp(r'(\w+)'), ''))??0;
  int bNumericPart = int.tryParse(extractNumericPart(b.bookName!))??0;

  // Comparing the letter parts
  int letterComparison = aLetterPart.compareTo(bLetterPart);
  if (letterComparison != 0) {
    return letterComparison;
  }

  // Comparing the numeric parts
  return bNumericPart.compareTo(aNumericPart);
}