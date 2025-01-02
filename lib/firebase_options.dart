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
    apiKey: 'AIzaSyCEJg-WVg7mLS7vLnySFV1bHGkFuDe6cug',
    appId: '1:739575227520:web:b1dfd8e8e297e651677265',
    messagingSenderId: '739575227520',
    projectId: 'renuka-travels',
    authDomain: 'renuka-travels.firebaseapp.com',
    storageBucket: 'renuka-travels.appspot.com',
  );

  static const FirebaseOptions android = FirebaseOptions(
    apiKey: 'AIzaSyCdZFfl-NLajScxGcUCSPybw8QMijagNl4',
    appId: '1:739575227520:android:43fb40e0b2f8e289677265',
    messagingSenderId: '739575227520',
    projectId: 'renuka-travels',
    storageBucket: 'renuka-travels.appspot.com',
  );

  static const FirebaseOptions ios = FirebaseOptions(
    apiKey: 'AIzaSyCX_TnpQfS56V8ZOjfpHvV_htnxQMMbcwQ',
    appId: '1:739575227520:ios:6c361e6189834b99677265',
    messagingSenderId: '739575227520',
    projectId: 'renuka-travels',
    storageBucket: 'renuka-travels.appspot.com',
    iosClientId: '739575227520-rt7h5153atioqoc20qbeb2kucb4kc08a.apps.googleusercontent.com',
    iosBundleId: 'com.example.renukaTravels',
  );
}