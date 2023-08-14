import 'package:flutter/material.dart';
import 'package:flutter_test/flutter_test.dart';

void main() {
  testWidgets('Test the behavior of the IconButton widget',
      (WidgetTester tester) async {
    const addButtonKey = Key('mainPageAddHabit');
    bool addHabitPressed = false;

    await tester.pumpWidget(
      MaterialApp(
        home: Scaffold(
          body: IconButton(
            key: addButtonKey,
            icon: const Icon(Icons.add),
            onPressed: () {
              addHabitPressed = true;
            },
          ),
        ),
      ),
    );

    // Verify that the IconButton is rendered
    expect(find.byIcon(Icons.add), findsOneWidget);

    // Verify that the IconButton is not pressed initially
    expect(addHabitPressed, false);

    // Tap on the IconButton
    await tester.tap(find.byKey(addButtonKey));
    await tester.pump();

    // Verify that the IconButton is pressed after tapping it
    expect(addHabitPressed, true);
  });
}
