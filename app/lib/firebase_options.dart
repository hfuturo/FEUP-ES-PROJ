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
    apiKey: 'AIzaSyAMqp0eEIX7BHY1kKgHmr6D4HruqtbBcc0',
    appId: '1:698705199845:web:590cde97833681bd9aca0c',
    messagingSenderId: '698705199845',
    projectId: 'habit-hero-4d680',
    authDomain: 'habit-hero-4d680.firebaseapp.com',
    storageBucket: 'habit-hero-4d680.appspot.com',
    measurementId: 'G-8C7E9KRSFB',
  );

  static const FirebaseOptions android = FirebaseOptions(
    apiKey: 'AIzaSyAfg3KwP9mFQW6X0tqh8UANY4OM7iTMhbU',
    appId: '1:698705199845:android:a8e17f7ffc3c0a489aca0c',
    messagingSenderId: '698705199845',
    projectId: 'habit-hero-4d680',
    storageBucket: 'habit-hero-4d680.appspot.com',
  );

  static const FirebaseOptions ios = FirebaseOptions(
    apiKey: 'AIzaSyBaaNfz8vyzNd6M423WctFE0R2frfXy2Rk',
    appId: '1:698705199845:ios:11c8167931e46c829aca0c',
    messagingSenderId: '698705199845',
    projectId: 'habit-hero-4d680',
    storageBucket: 'habit-hero-4d680.appspot.com',
    iosClientId: '698705199845-7fm28uct1hk11ljcmnvsca1k98cd28tj.apps.googleusercontent.com',
    iosBundleId: 'com.example.habitHero',
  );

  static const FirebaseOptions macos = FirebaseOptions(
    apiKey: 'AIzaSyBaaNfz8vyzNd6M423WctFE0R2frfXy2Rk',
    appId: '1:698705199845:ios:11c8167931e46c829aca0c',
    messagingSenderId: '698705199845',
    projectId: 'habit-hero-4d680',
    storageBucket: 'habit-hero-4d680.appspot.com',
    iosClientId: '698705199845-7fm28uct1hk11ljcmnvsca1k98cd28tj.apps.googleusercontent.com',
    iosBundleId: 'com.example.habitHero',
  );
}
