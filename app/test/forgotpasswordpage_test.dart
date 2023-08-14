import 'package:flutter/material.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:habit_hero/forgotpasswordpage.dart';

void main() {
  late ForgotPasswordPage forgotPasswordPage;

  setUp(() {
    forgotPasswordPage = const ForgotPasswordPage();
  });
  group("forgotpasswordpage unit tests", () {
    testWidgets("ForgotPasswordPage should build without throwing an error",
        (WidgetTester tester) async {
      await tester.pumpWidget(MaterialApp(home: forgotPasswordPage));
      expect(find.text("Forgot Password"), findsOneWidget);
    });

    testWidgets('Find text elements', (WidgetTester tester) async {
      await tester.pumpWidget(MaterialApp(home: forgotPasswordPage));
      expect(find.text("Forgot Password"), findsOneWidget);
      expect(
          find.text('Please enter your email address to reset your password'),
          findsOneWidget);
      expect(find.byKey(const Key('form')), findsOneWidget);
      expect(find.text("Reset Password"), findsOneWidget);
    });

    testWidgets('Find all icons', (WidgetTester tester) async {
      await tester.pumpWidget(MaterialApp(home: forgotPasswordPage));
      expect(find.byIcon(Icons.email_outlined), findsOneWidget);
    });
  });
}
