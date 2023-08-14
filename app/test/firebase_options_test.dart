//import 'dart:html';

import 'package:flutter_test/flutter_test.dart';
import 'package:flutter/foundation.dart';
//import 'package:flutter/rendering.dart';
import 'package:habit_hero/firebase_options.dart';

void main() {
  group('DefaultFirebaseOptions', () {
    test('should return ios options when running on ios platform', () {
      debugDefaultTargetPlatformOverride = TargetPlatform.iOS;

      final options = DefaultFirebaseOptions.currentPlatform;

      expect(options, equals(DefaultFirebaseOptions.ios));
    });

    test('return correct plataform values when running on ios', () {
      debugDefaultTargetPlatformOverride = TargetPlatform.iOS;

      final options = DefaultFirebaseOptions.currentPlatform;

      expect(options.apiKey, 'AIzaSyBaaNfz8vyzNd6M423WctFE0R2frfXy2Rk');
      expect(options.appId, '1:698705199845:ios:11c8167931e46c829aca0c');
      expect(options.messagingSenderId, '698705199845');
      expect(options.projectId, 'habit-hero-4d680');
      expect(options.storageBucket, 'habit-hero-4d680.appspot.com');
      expect(options.iosClientId,
          '698705199845-7fm28uct1hk11ljcmnvsca1k98cd28tj.apps.googleusercontent.com');
      expect(options.iosBundleId, 'com.example.habitHero');
    });

    test('should return android options when running on android platform', () {
      debugDefaultTargetPlatformOverride = TargetPlatform.android;

      final options = DefaultFirebaseOptions.currentPlatform;

      expect(options, equals(DefaultFirebaseOptions.android));
    });

    test('return correct plataform values when running on android', () {
      debugDefaultTargetPlatformOverride = TargetPlatform.android;

      final options = DefaultFirebaseOptions.currentPlatform;

      expect(options.apiKey, 'AIzaSyAfg3KwP9mFQW6X0tqh8UANY4OM7iTMhbU');
      expect(options.appId, '1:698705199845:android:a8e17f7ffc3c0a489aca0c');
      expect(options.messagingSenderId, '698705199845');
      expect(options.projectId, 'habit-hero-4d680');
      expect(options.storageBucket, 'habit-hero-4d680.appspot.com');
    });

    test('should return macOS options when running on macOS platform', () {
      debugDefaultTargetPlatformOverride = TargetPlatform.macOS;

      final options = DefaultFirebaseOptions.currentPlatform;

      expect(options, equals(DefaultFirebaseOptions.macos));
    });

    test('return correct plataform values when running on macOS', () {
      debugDefaultTargetPlatformOverride = TargetPlatform.macOS;

      final options = DefaultFirebaseOptions.currentPlatform;

      expect(options.apiKey, 'AIzaSyBaaNfz8vyzNd6M423WctFE0R2frfXy2Rk');
      expect(options.appId, '1:698705199845:ios:11c8167931e46c829aca0c');
      expect(options.messagingSenderId, '698705199845');
      expect(options.projectId, 'habit-hero-4d680');
      expect(options.storageBucket, 'habit-hero-4d680.appspot.com');
      expect(options.iosClientId,
          '698705199845-7fm28uct1hk11ljcmnvsca1k98cd28tj.apps.googleusercontent.com');
      expect(options.iosBundleId, 'com.example.habitHero');
    });

    test('return correct plataform when running on web platform', () {
      if (kIsWeb) {
        const options = DefaultFirebaseOptions.web;

        expect(options, equals(DefaultFirebaseOptions.web));
      }
    });

    test('should return web options when running on web plataform', () {
      const options = DefaultFirebaseOptions.web;

      expect(options.apiKey, 'AIzaSyAMqp0eEIX7BHY1kKgHmr6D4HruqtbBcc0');
      expect(options.appId, '1:698705199845:web:590cde97833681bd9aca0c');
      expect(options.messagingSenderId, '698705199845');
      expect(options.projectId, 'habit-hero-4d680');
      expect(options.authDomain, 'habit-hero-4d680.firebaseapp.com');
      expect(options.storageBucket, 'habit-hero-4d680.appspot.com');
      expect(options.measurementId, 'G-8C7E9KRSFB');
    });

    test('should throw error when running on linux platform', () {
      debugDefaultTargetPlatformOverride = TargetPlatform.linux;

      expect(
        () => DefaultFirebaseOptions.currentPlatform,
        throwsA(isA<UnsupportedError>()),
      );
    });

    test('should throw error when running on fuchsia platform', () {
      debugDefaultTargetPlatformOverride = TargetPlatform.fuchsia;

      expect(
        () => DefaultFirebaseOptions.currentPlatform,
        throwsA(isA<UnsupportedError>()),
      );
    });

    test('should throw error when running on windows platform', () {
      debugDefaultTargetPlatformOverride = TargetPlatform.windows;

      expect(
        () => DefaultFirebaseOptions.currentPlatform,
        throwsA(isA<UnsupportedError>()),
      );
    });
  });
}
