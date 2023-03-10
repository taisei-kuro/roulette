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
    apiKey: 'AIzaSyCw8cbxnihikCdb7VVgHB4voX4sytM6YNc',
    appId: '1:266687158985:web:bac620e4c3d0f88d444b18',
    messagingSenderId: '266687158985',
    projectId: 'roulette-7f1cf',
    authDomain: 'roulette-7f1cf.firebaseapp.com',
    storageBucket: 'roulette-7f1cf.appspot.com',
    measurementId: 'G-V9XQCDF390',
  );

  static const FirebaseOptions android = FirebaseOptions(
    apiKey: 'AIzaSyACYTqtEWAmi_-6otNHMp_rPn6zAzvyWtU',
    appId: '1:266687158985:android:9ce53af311761c55444b18',
    messagingSenderId: '266687158985',
    projectId: 'roulette-7f1cf',
    storageBucket: 'roulette-7f1cf.appspot.com',
  );

  static const FirebaseOptions ios = FirebaseOptions(
    apiKey: 'AIzaSyDbO3xyYI_ZpwmYHatYfjRxEh0KFApzoLw',
    appId: '1:266687158985:ios:9235b82a1680964a444b18',
    messagingSenderId: '266687158985',
    projectId: 'roulette-7f1cf',
    storageBucket: 'roulette-7f1cf.appspot.com',
    iosClientId: '266687158985-74ii3un62coqecnv72hegpodtbekn0s1.apps.googleusercontent.com',
    iosBundleId: 'com.example.roulette',
  );
}
