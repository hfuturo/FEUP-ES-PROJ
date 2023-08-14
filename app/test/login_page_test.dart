import 'package:flutter/material.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:habit_hero/login_page.dart';

void main() {
  late LoginPage loginPage;
  late VoidCallback onClickedSignIn;

  setUp(() {
    void doNothing() {}
    onClickedSignIn = doNothing;
    loginPage = LoginPage(onClickedSignIn: onClickedSignIn);
  });

  group('login_page tests', () {
    testWidgets('login_page constructor', (WidgetTester tester) async {
      await tester.pumpWidget(MaterialApp(home: loginPage));
      expect(loginPage.onClickedSignIn, onClickedSignIn);
    });

    testWidgets('login_page loads', (WidgetTester tester) async {
      await tester.pumpWidget(MaterialApp(home: loginPage));
      expect(find.text('Forgot Password?'), findsOneWidget);
    });

    testWidgets('login_page elements', (WidgetTester tester) async {
      await tester.pumpWidget(MaterialApp(home: loginPage));
      expect(find.byKey(const Key('email_form')), findsOneWidget);
      expect(find.byKey(const Key('password_form')), findsOneWidget);
      expect(find.byKey(const Key('signInButton')), findsOneWidget);
      expect(find.text('Login'), findsOneWidget);
      expect(find.text('Forgot Password?'), findsOneWidget);
      expect(find.byKey(const Key('create_account')), findsOneWidget);
    });

    testWidgets('login_page icons', (WidgetTester tester) async {
      await tester.pumpWidget(MaterialApp(home: loginPage));
      expect(find.byIcon(Icons.email), findsOneWidget);
      expect(find.byIcon(Icons.lock), findsOneWidget);
    });

    testWidgets('login_page images', (WidgetTester tester) async {
      await tester.pumpWidget(MaterialApp(home: loginPage));
      expect(
          find.image(const AssetImage('images/hh_logo.png')), findsOneWidget);
    });
  });
}
