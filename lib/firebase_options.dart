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
    apiKey: 'AIzaSyAC3QT4En36UsdWt3fHovptsYtHXarEGXE',
    appId: '1:610341200691:web:36c4f3dec1186f4807d446',
    messagingSenderId: '610341200691',
    projectId: 'eproject-aaf04',
    authDomain: 'eproject-aaf04.firebaseapp.com',
    storageBucket: 'eproject-aaf04.appspot.com',
  );

  static const FirebaseOptions android = FirebaseOptions(
    apiKey: 'AIzaSyBVuX92wQ-ZxMWgF7AAPPzzBtn7OAzwgFw',
    appId: '1:610341200691:android:8799b176e892d17407d446',
    messagingSenderId: '610341200691',
    projectId: 'eproject-aaf04',
    storageBucket: 'eproject-aaf04.appspot.com',
  );

  static const FirebaseOptions ios = FirebaseOptions(
    apiKey: 'AIzaSyDiv-6fwXHThvRxUqvWyAhDiV_31AzsfT4',
    appId: '1:610341200691:ios:066342e4b550597407d446',
    messagingSenderId: '610341200691',
    projectId: 'eproject-aaf04',
    storageBucket: 'eproject-aaf04.appspot.com',
    iosBundleId: 'com.example.eProject',
  );
}
