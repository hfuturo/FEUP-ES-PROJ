import 'package:flutter/material.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:habit_hero/habits_page.dart';

void main() {
  late HabitsPage habitsPage;

  setUp(() {
    habitsPage = const HabitsPage();
  });

  group('habits_page tests', () {
    testWidgets('habit_page displays', (WidgetTester tester) async {
      await tester.pumpWidget(MaterialApp(home: habitsPage));
      expect(find.byType(AppBar), findsOneWidget);
      expect(find.text('Habits'), findsOneWidget);
    });
  });
}
