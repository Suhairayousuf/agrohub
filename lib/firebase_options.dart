// File generated by FlutterFire CLI.
// ignore_for_file: lines_longer_than_80_chars, avoid_classes_with_only_static_members
import 'package:firebase_core/firebase_core.dart' show FirebaseOptions;
import 'package:flutter/foundation.dart'
    show defaultTargetPlatform, kIsWeb, TargetPlatform;

/// Default [FirebaseOptions] for use with your Firebase apps.
///
/// Example:
/// ```dart
/// import 'firebase_options.dart';
/// // ...
/// await Firebase.initializeApp(
///   options: DefaultFirebaseOptions.currentPlatform,
/// );
/// ```
class DefaultFirebaseOptions {
  static FirebaseOptions get currentPlatform {
    if (kIsWeb) {
      return web;
    }
    switch (defaultTargetPlatform) {
      case TargetPlatform.android:
        return android;
      case TargetPlatform.iOS:
        return ios;
      case TargetPlatform.macOS:
        throw UnsupportedError(
          'DefaultFirebaseOptions have not been configured for macos - '
          'you can reconfigure this by running the FlutterFire CLI again.',
        );
      case TargetPlatform.windows:
        throw UnsupportedError(
          'DefaultFirebaseOptions have not been configured for windows - '
          'you can reconfigure this by running the FlutterFire CLI again.',
        );
      case TargetPlatform.linux:
        throw UnsupportedError(
          'DefaultFirebaseOptions have not been configured for linux - '
          'you can reconfigure this by running the FlutterFire CLI again.',
        );
      default:
        throw UnsupportedError(
          'DefaultFirebaseOptions are not supported for this platform.',
        );
    }
  }

  static const FirebaseOptions web = FirebaseOptions(
    apiKey: 'AIzaSyB77XgBkUd9txCWxfFaASaHWuL2uRN2x7A',
    appId: '1:4343602446:web:aadc4785f4394a2e648b5f',
    messagingSenderId: '4343602446',
    projectId: 'agrohub-8b592',
    authDomain: 'agrohub-8b592.firebaseapp.com',
    storageBucket: 'agrohub-8b592.appspot.com',
    measurementId: 'G-99Q19HELRP',
  );

  static const FirebaseOptions android = FirebaseOptions(
    apiKey: 'AIzaSyBTJ2tyVJeGWF0KkIZafo1uG0JMCl0Aqmw',
    appId: '1:4343602446:android:9dbc274bb97d600b648b5f',
    messagingSenderId: '4343602446',
    projectId: 'agrohub-8b592',
    storageBucket: 'agrohub-8b592.appspot.com',
  );

  static const FirebaseOptions ios = FirebaseOptions(
    apiKey: 'AIzaSyB-r8KCrKVI0A7Dj6RWhrjH2dVZH_j7mek',
    appId: '1:4343602446:ios:a9114575886ea1bd648b5f',
    messagingSenderId: '4343602446',
    projectId: 'agrohub-8b592',
    storageBucket: 'agrohub-8b592.appspot.com',
    iosBundleId: 'com.firstlogicmetalab.agrohub.agrohub',
  );
}
