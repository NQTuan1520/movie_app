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
        return ios;
      case TargetPlatform.macOS:
        return macos;
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
    apiKey: 'AIzaSyBhBSplQ10MP-CBp2hAqJ9tdxZtcuMKCJs',
    appId: '1:615280931893:web:2d769610209964a8baad7c',
    messagingSenderId: '615280931893',
    projectId: 'assignment-endpart',
    authDomain: 'assignment-endpart.firebaseapp.com',
    storageBucket: 'assignment-endpart.appspot.com',
    measurementId: 'G-HBN11L9WXZ',
  );

  static const FirebaseOptions android = FirebaseOptions(
    apiKey: 'AIzaSyAYQdNdHeKkEJGCqvQDQ17qXv5rmHv-li0',
    appId: '1:615280931893:android:171deaeeece39a1cbaad7c',
    messagingSenderId: '615280931893',
    projectId: 'assignment-endpart',
    storageBucket: 'assignment-endpart.appspot.com',
  );

  static const FirebaseOptions ios = FirebaseOptions(
    apiKey: 'AIzaSyADt7yKRto1knGVaSj8Dm7d8MQp4fr9kks',
    appId: '1:615280931893:ios:ae066d7ff76ec0e1baad7c',
    messagingSenderId: '615280931893',
    projectId: 'assignment-endpart',
    storageBucket: 'assignment-endpart.appspot.com',
    iosClientId: '615280931893-9grlq49pjvd8kja6qbpmg60rsf1hqjna.apps.googleusercontent.com',
    iosBundleId: 'com.example.huynd2Assignment',
  );

  static const FirebaseOptions macos = FirebaseOptions(
    apiKey: 'AIzaSyADt7yKRto1knGVaSj8Dm7d8MQp4fr9kks',
    appId: '1:615280931893:ios:ae066d7ff76ec0e1baad7c',
    messagingSenderId: '615280931893',
    projectId: 'assignment-endpart',
    storageBucket: 'assignment-endpart.appspot.com',
    iosClientId: '615280931893-9grlq49pjvd8kja6qbpmg60rsf1hqjna.apps.googleusercontent.com',
    iosBundleId: 'com.example.huynd2Assignment',
  );

  static const FirebaseOptions windows = FirebaseOptions(
    apiKey: 'AIzaSyBhBSplQ10MP-CBp2hAqJ9tdxZtcuMKCJs',
    appId: '1:615280931893:web:74534ab386a0651ebaad7c',
    messagingSenderId: '615280931893',
    projectId: 'assignment-endpart',
    authDomain: 'assignment-endpart.firebaseapp.com',
    storageBucket: 'assignment-endpart.appspot.com',
    measurementId: 'G-TWMDES65JL',
  );
}