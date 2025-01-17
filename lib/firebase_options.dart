// File generated by FlutterFire CLI.
// ignore_for_file: type=lint
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
        throw UnsupportedError(
          'DefaultFirebaseOptions have not been configured for ios - '
          'you can reconfigure this by running the FlutterFire CLI again.',
        );
      case TargetPlatform.macOS:
        throw UnsupportedError(
          'DefaultFirebaseOptions have not been configured for macos - '
          'you can reconfigure this by running the FlutterFire CLI again.',
        );
      case TargetPlatform.windows:
        return windows;
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
    apiKey: 'AIzaSyCY26953zkplT-ydg3cx6fDm5lfWbFWkRM',
    appId: '1:963116536017:web:7cdc018a8e364399a175f0',
    messagingSenderId: '963116536017',
    projectId: 'fridge-manager-8d2a9',
    authDomain: 'fridge-manager-8d2a9.firebaseapp.com',
    storageBucket: 'fridge-manager-8d2a9.appspot.com',
  );

  static const FirebaseOptions android = FirebaseOptions(
    apiKey: 'AIzaSyBjYCP61faMJp-yyXVtMBDtpTvlyc8-St0',
    appId: '1:963116536017:android:75dfb5d1b0e5b580a175f0',
    messagingSenderId: '963116536017',
    projectId: 'fridge-manager-8d2a9',
    storageBucket: 'fridge-manager-8d2a9.appspot.com',
  );

  static const FirebaseOptions windows = FirebaseOptions(
    apiKey: 'AIzaSyCY26953zkplT-ydg3cx6fDm5lfWbFWkRM',
    appId: '1:963116536017:web:1abbcf82e855929ea175f0',
    messagingSenderId: '963116536017',
    projectId: 'fridge-manager-8d2a9',
    authDomain: 'fridge-manager-8d2a9.firebaseapp.com',
    storageBucket: 'fridge-manager-8d2a9.appspot.com',
  );
}
