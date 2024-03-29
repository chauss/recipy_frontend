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
    apiKey: 'AIzaSyAqQexvkT7BV49ImKQJZzl89oIvYhp8_ig',
    appId: '1:1089021017346:web:e152e32e7a4fa09519561b',
    messagingSenderId: '1089021017346',
    projectId: 'recipy-9b8ad',
    authDomain: 'recipy-9b8ad.firebaseapp.com',
    storageBucket: 'recipy-9b8ad.appspot.com',
    measurementId: 'G-HH1X3L1TKL',
  );

  static const FirebaseOptions android = FirebaseOptions(
    apiKey: 'AIzaSyB3VjEhdUDKLGcHlaD76uW4TkV8Nm3lvK8',
    appId: '1:1089021017346:android:2bb9bef9c3d45b9d19561b',
    messagingSenderId: '1089021017346',
    projectId: 'recipy-9b8ad',
    storageBucket: 'recipy-9b8ad.appspot.com',
  );

  static const FirebaseOptions ios = FirebaseOptions(
    apiKey: 'AIzaSyDsVlEbEdAf6yLTc2qsPF7vhyrsk3oiCGM',
    appId: '1:1089021017346:ios:11afc51d828a94bc19561b',
    messagingSenderId: '1089021017346',
    projectId: 'recipy-9b8ad',
    storageBucket: 'recipy-9b8ad.appspot.com',
    iosClientId:
        '1089021017346-mpi811mchv24ps0ngvc2uu6ssrgecbci.apps.googleusercontent.com',
    iosBundleId: 'de.chauss.recipyFrontend',
  );
}
