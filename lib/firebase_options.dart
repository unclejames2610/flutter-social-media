// File generated by FlutterFire CLI.
// ignore_for_file: lines_longer_than_80_chars, avoid_classes_with_only_static_members
import 'package:firebase_core/firebase_core.dart' show FirebaseOptions;
import 'package:flutter/foundation.dart'
    show defaultTargetPlatform, kIsWeb, TargetPlatform;
import 'package:flutter_dotenv/flutter_dotenv.dart';

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
      throw UnsupportedError(
        'DefaultFirebaseOptions have not been configured for web - '
        'you can reconfigure this by running the FlutterFire CLI again.',
      );
    }
    switch (defaultTargetPlatform) {
      case TargetPlatform.android:
        return FirebaseOptions(
          apiKey: dotenv.env['FIREBASE_ANDROID_API_KEY'] ?? "",
          appId: '1:1045863495888:android:bea8af82154a6d62e5c6d5',
          messagingSenderId: '1045863495888',
          projectId: 'flutter-auth-7bfa6',
          storageBucket: 'flutter-auth-7bfa6.appspot.com',
        );
      case TargetPlatform.iOS:
        return FirebaseOptions(
          apiKey: dotenv.env['FIREBASE_IOS_API_KEY'] ?? "",
          appId: '1:1045863495888:ios:81bc02bee46469fae5c6d5',
          messagingSenderId: '1045863495888',
          projectId: 'flutter-auth-7bfa6',
          storageBucket: 'flutter-auth-7bfa6.appspot.com',
          iosBundleId: 'com.example.socialMedia',
        );
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

  static const FirebaseOptions android = FirebaseOptions(
    apiKey: 'AIzaSyD4nUixnnxHQIene9AbYn2yHj-XFVow08Y',
    appId: '1:1045863495888:android:bea8af82154a6d62e5c6d5',
    messagingSenderId: '1045863495888',
    projectId: 'flutter-auth-7bfa6',
    storageBucket: 'flutter-auth-7bfa6.appspot.com',
  );

  static const FirebaseOptions ios = FirebaseOptions(
    apiKey: 'AIzaSyCvqF-YR7GUTXnBPUy6FMGM9y-HfpSPBe4',
    appId: '1:1045863495888:ios:81bc02bee46469fae5c6d5',
    messagingSenderId: '1045863495888',
    projectId: 'flutter-auth-7bfa6',
    storageBucket: 'flutter-auth-7bfa6.appspot.com',
    iosBundleId: 'com.example.socialMedia',
  );
}
