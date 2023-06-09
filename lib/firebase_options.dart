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
    apiKey: 'AIzaSyBQ4y0hnNMkMMyCLDxy40fO_nBOqkS3X2k',
    appId: '1:788264178175:web:e6e3278697f19de6d6d7ca',
    messagingSenderId: '788264178175',
    projectId: 'food-panddu',
    authDomain: 'food-panddu.firebaseapp.com',
    storageBucket: 'food-panddu.appspot.com',
    measurementId: 'G-SB6MYXDM6R',
  );

  static const FirebaseOptions android = FirebaseOptions(
    apiKey: 'AIzaSyB-VXFxsLBZNpqw16wpgKjMvp4sr4ZaDSk',
    appId: '1:788264178175:android:dee9c839746764c6d6d7ca',
    messagingSenderId: '788264178175',
    projectId: 'food-panddu',
    storageBucket: 'food-panddu.appspot.com',
  );

  static const FirebaseOptions ios = FirebaseOptions(
    apiKey: 'AIzaSyD_kU27UECKJknpv5K4yAqaI6IB6hLIsZA',
    appId: '1:788264178175:ios:2805523ec11614d5d6d7ca',
    messagingSenderId: '788264178175',
    projectId: 'food-panddu',
    storageBucket: 'food-panddu.appspot.com',
    iosClientId: '788264178175-m7ocm2ah7ns45i9ij670sinjols25ui6.apps.googleusercontent.com',
    iosBundleId: 'com.example.foodShop',
  );

  static const FirebaseOptions macos = FirebaseOptions(
    apiKey: 'AIzaSyD_kU27UECKJknpv5K4yAqaI6IB6hLIsZA',
    appId: '1:788264178175:ios:2805523ec11614d5d6d7ca',
    messagingSenderId: '788264178175',
    projectId: 'food-panddu',
    storageBucket: 'food-panddu.appspot.com',
    iosClientId: '788264178175-m7ocm2ah7ns45i9ij670sinjols25ui6.apps.googleusercontent.com',
    iosBundleId: 'com.example.foodShop',
  );
}
