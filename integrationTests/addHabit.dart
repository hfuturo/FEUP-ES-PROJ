import 'dart:async';
import 'package:flutter_gherkin/flutter_gherkin.dart';
import 'package:flutter-driver/flutter_driver.dart';
import 'package:test/test.dart';

class ClickOnAddHabitButton extends When1WithWorld<String, FlutterWorld> {
  @override
  Future<void> executeStep(String buttonLabel) async {
    final addButtonFinder = find.byValueKey('add-habit-button');
    await FlutterDriverUtils.tap(world.driver, addButtonFinder);
  }

  @override
  RegExp get pattern => RegExp(r'I click on the "Add Habit" button');
}