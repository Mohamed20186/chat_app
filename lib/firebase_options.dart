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
    apiKey: 'AIzaSyDUmvpfgkSQDfa9UZbkVDQ7jVpn67NVElw',
    appId: '1:368902574579:web:f6dd799eba07754a764286',
    messagingSenderId: '368902574579',
    projectId: 'chat-app-fed96',
    authDomain: 'chat-app-fed96.firebaseapp.com',
    storageBucket: 'chat-app-fed96.appspot.com',
    measurementId: 'G-J68V99VZKM',
  );

  static const FirebaseOptions android = FirebaseOptions(
    apiKey: 'AIzaSyDZdgHbZ-GjmlCc5Z5jF1_O1aA2lFkF5Oo',
    appId: '1:368902574579:android:25139ecf0fc693dd764286',
    messagingSenderId: '368902574579',
    projectId: 'chat-app-fed96',
    storageBucket: 'chat-app-fed96.appspot.com',
  );

  static const FirebaseOptions ios = FirebaseOptions(
    apiKey: 'AIzaSyAhwOv70ol5rWxMg0NN4v8IiFc901j5CwY',
    appId: '1:368902574579:ios:8ad10a5e6b5fc5f8764286',
    messagingSenderId: '368902574579',
    projectId: 'chat-app-fed96',
    storageBucket: 'chat-app-fed96.appspot.com',
    iosBundleId: 'com.example.chatApp',
  );

  static const FirebaseOptions macos = FirebaseOptions(
    apiKey: 'AIzaSyAhwOv70ol5rWxMg0NN4v8IiFc901j5CwY',
    appId: '1:368902574579:ios:5e89c2889467f280764286',
    messagingSenderId: '368902574579',
    projectId: 'chat-app-fed96',
    storageBucket: 'chat-app-fed96.appspot.com',
    iosBundleId: 'com.example.chatApp.RunnerTests',
  );
}
