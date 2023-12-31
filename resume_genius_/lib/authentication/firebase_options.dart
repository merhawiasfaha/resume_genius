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
    apiKey: 'AIzaSyAGw5XflQ6bh1kvaHu4fUbZEaqvtel6Lfo',
    appId: '1:490882955764:web:bfcb2407b6e77191cb61a1',
    messagingSenderId: '490882955764',
    projectId: 'resumegenius-b6fe2',
    authDomain: 'resumegenius-b6fe2.firebaseapp.com',
    storageBucket: 'resumegenius-b6fe2.appspot.com',
    measurementId: 'G-PT5J766S15',
  );

  static const FirebaseOptions android = FirebaseOptions(
    apiKey: 'AIzaSyAF-FUIUwV_1l-_POFR8Kyr-rM0um_K2bM',
    appId: '1:490882955764:android:bb0107f18175811ccb61a1',
    messagingSenderId: '490882955764',
    projectId: 'resumegenius-b6fe2',
    storageBucket: 'resumegenius-b6fe2.appspot.com',
  );

  static const FirebaseOptions ios = FirebaseOptions(
    apiKey: 'AIzaSyA2maVLLD1dMmQ9wW3jmiocBLLwd7dW_as',
    appId: '1:490882955764:ios:37650cda9d6fee91cb61a1',
    messagingSenderId: '490882955764',
    projectId: 'resumegenius-b6fe2',
    storageBucket: 'resumegenius-b6fe2.appspot.com',
    iosBundleId: 'com.example.resumeGenius',
  );

  static const FirebaseOptions macos = FirebaseOptions(
    apiKey: 'AIzaSyA2maVLLD1dMmQ9wW3jmiocBLLwd7dW_as',
    appId: '1:490882955764:ios:abf3d81ab362ea23cb61a1',
    messagingSenderId: '490882955764',
    projectId: 'resumegenius-b6fe2',
    storageBucket: 'resumegenius-b6fe2.appspot.com',
    iosBundleId: 'com.example.resumeGenius.RunnerTests',
  );
}
