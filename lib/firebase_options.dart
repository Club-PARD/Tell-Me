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
    apiKey: 'AIzaSyBouu8XXhlj09umiyM8tTpJl-YacS8HA_4',
    appId: '1:401451695303:web:4baaeabdeac58dfbb712e2',
    messagingSenderId: '401451695303',
    projectId: 'pard-dlive-b27d9',
    authDomain: 'pard-dlive-b27d9.firebaseapp.com',
    storageBucket: 'pard-dlive-b27d9.appspot.com',
  );

  static const FirebaseOptions android = FirebaseOptions(
    apiKey: 'AIzaSyAvd5GT9bgakpG89C7_ln54JMMjDOaLygY',
    appId: '1:401451695303:android:f87ddccc71ef0367b712e2',
    messagingSenderId: '401451695303',
    projectId: 'pard-dlive-b27d9',
    storageBucket: 'pard-dlive-b27d9.appspot.com',
  );

  static const FirebaseOptions ios = FirebaseOptions(
    apiKey: 'AIzaSyAVWKHFykEVJUZh8B0utevRb8JxlJX0MUI',
    appId: '1:401451695303:ios:ed87e4c9ec5ed622b712e2',
    messagingSenderId: '401451695303',
    projectId: 'pard-dlive-b27d9',
    storageBucket: 'pard-dlive-b27d9.appspot.com',
    iosClientId: '401451695303-kjklp471adk0ctksik6utm5jhho8oo0n.apps.googleusercontent.com',
    iosBundleId: 'com.example.middleUi',
  );

  static const FirebaseOptions macos = FirebaseOptions(
    apiKey: 'AIzaSyAVWKHFykEVJUZh8B0utevRb8JxlJX0MUI',
    appId: '1:401451695303:ios:ef0c8701cd75d326b712e2',
    messagingSenderId: '401451695303',
    projectId: 'pard-dlive-b27d9',
    storageBucket: 'pard-dlive-b27d9.appspot.com',
    iosClientId: '401451695303-1e55do4ombj2hp6qj19qbkr5mu7r8ufg.apps.googleusercontent.com',
    iosBundleId: 'com.example.middleUi.RunnerTests',
  );
}