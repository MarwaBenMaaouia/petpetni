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
        return macos;
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
    apiKey: 'AIzaSyDoNg-BEOvvGj75qPHKJcu5GDPPXvbAPEk',
    appId: '1:233959231675:web:98a12d35d51ed3eeca999e',
    messagingSenderId: '233959231675',
    projectId: 'mobile-app-6fdae',
    authDomain: 'mobile-app-6fdae.firebaseapp.com',
    storageBucket: 'mobile-app-6fdae.appspot.com',
    measurementId: 'G-DN1ZG8KHWD',
  );

  static const FirebaseOptions android = FirebaseOptions(
    apiKey: 'AIzaSyCMWpyPDELDGWAJ4XbW9Ye0_T6Y3xA-lCY',
    appId: '1:233959231675:android:9b48e32a4bf1663dca999e',
    messagingSenderId: '233959231675',
    projectId: 'mobile-app-6fdae',
    storageBucket: 'mobile-app-6fdae.appspot.com',
  );

  static const FirebaseOptions ios = FirebaseOptions(
    apiKey: 'AIzaSyDPk41Nhl_FVF4Ony7jnGz1ZuL2NHmcglg',
    appId: '1:233959231675:ios:e329bca3f28d30caca999e',
    messagingSenderId: '233959231675',
    projectId: 'mobile-app-6fdae',
    storageBucket: 'mobile-app-6fdae.appspot.com',
    iosBundleId: 'com.example.astuces',
  );

  static const FirebaseOptions macos = FirebaseOptions(
    apiKey: 'AIzaSyDPk41Nhl_FVF4Ony7jnGz1ZuL2NHmcglg',
    appId: '1:233959231675:ios:b55a484d792aabc5ca999e',
    messagingSenderId: '233959231675',
    projectId: 'mobile-app-6fdae',
    storageBucket: 'mobile-app-6fdae.appspot.com',
    iosBundleId: 'com.example.astuces.RunnerTests',
  );
}
