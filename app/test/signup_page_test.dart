import 'package:flutter/material.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:habit_hero/signup_page.dart';

void main() {
  late SignUpPage signUpPage;
  late Function() onClickedSignup;
  late UserModel userModel;
  late String id;
  late String email;
  late int points;
  late List<Map<String, dynamic>> unlockedColors;

  setUp(() {
    void doNothing() {}
    onClickedSignup = doNothing;
    signUpPage = SignUpPage(onClickedSignUp: doNothing);
    id = '2';
    email = 'teste@gmail.com';
    points = 100;
    List<String> stringList = ['one', 'two', 'three'];
    unlockedColors = stringList.map((e) => {'name': e}).toList();
    userModel = UserModel(
        id: id, email: email, points: points, unlockedColors: unlockedColors);
  });

  group('signup_page tests', () {
    testWidgets('default constructor', (WidgetTester tester) async {
      await tester.pumpWidget(MaterialApp(home: signUpPage));
      expect(signUpPage.onClickedSignUp, onClickedSignup);
    });

    testWidgets('page loads', (WidgetTester tester) async {
      await tester.pumpWidget(MaterialApp(home: signUpPage));
      expect(find.text('Register'), findsOneWidget);
    });

    testWidgets('Find text elements', (WidgetTester tester) async {
      await tester.pumpWidget(MaterialApp(home: signUpPage));
      expect(find.byKey(const Key('email_form')), findsOneWidget);
      expect(find.byKey(const Key('password_form')), findsOneWidget);
      expect(find.byKey(const Key('SignUpButton')), findsOneWidget);
      expect(find.text('Register'), findsOneWidget);
      expect(find.byKey(const Key('login')), findsOneWidget);
    });

    testWidgets('Find Icons', (WidgetTester tester) async {
      await tester.pumpWidget(MaterialApp(home: signUpPage));
      expect(find.byIcon(Icons.email), findsOneWidget);
      expect(find.byIcon(Icons.lock), findsOneWidget);
    });

    testWidgets('Find images', (WidgetTester tester) async {
      await tester.pumpWidget(MaterialApp(home: signUpPage));
      expect(
          find.image(const AssetImage('images/hh_logo.png')), findsOneWidget);
    });
  });

  group('UserModel tests', () {
    testWidgets('default constructor', (WidgetTester tester) async {
      expect(userModel.id, id);
      expect(userModel.email, email);
      expect(userModel.points, points);
      expect(userModel.unlockedColors, unlockedColors);
    });
  });
}
