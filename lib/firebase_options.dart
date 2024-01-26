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
    apiKey: 'AIzaSyBLMaPkFts7BXuj_5x7I_zLuccotzFpL2o',
    appId: '1:738488489308:web:00f91f5ed0bbf92bec9d99',
    messagingSenderId: '738488489308',
    projectId: 'eredzone-bd711',
    authDomain: 'eredzone-bd711.firebaseapp.com',
    storageBucket: 'eredzone-bd711.appspot.com',
  );

  static const FirebaseOptions android = FirebaseOptions(
    apiKey: 'AIzaSyApXuEmRDtZpZXPD_wfq1HG40AdlFc0tfQ',
    appId: '1:738488489308:android:812f91b4c8401a6eec9d99',
    messagingSenderId: '738488489308',
    projectId: 'eredzone-bd711',
    storageBucket: 'eredzone-bd711.appspot.com',
  );

  static const FirebaseOptions ios = FirebaseOptions(
    apiKey: 'AIzaSyBwikf7RgbH9kGglGitIQlK9-FLfNYI5Hc',
    appId: '1:738488489308:ios:7557108d82ff3601ec9d99',
    messagingSenderId: '738488489308',
    projectId: 'eredzone-bd711',
    storageBucket: 'eredzone-bd711.appspot.com',
    iosClientId: '738488489308-7gsajt4dpmbestcsfm8rl70dh7jsg114.apps.googleusercontent.com',
    iosBundleId: 'com.example.redZone',
  );
}
