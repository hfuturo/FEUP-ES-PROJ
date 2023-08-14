import 'package:flutter/material.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:habit_hero/auth_page.dart';
import 'package:habit_hero/login_page.dart';
import 'package:habit_hero/signup_page.dart';

void main() {
  late AuthPage authPage;

  setUp(() {
    authPage = const AuthPage();
  });

  group('AuthPage', () {
    testWidgets('should show LoginPage by default',
        (WidgetTester tester) async {
      // Given
      await tester.pumpWidget(MaterialApp(home: authPage));

      // Then
      expect(find.byType(LoginPage), findsOneWidget);
      expect(find.byType(SignUpPage), findsNothing);
    });
  });
}
