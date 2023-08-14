import 'dart:async';
import 'package:flutter_gherkin/flutter_gherkin.dart';
import 'package:flutter-driver/flutter_driver.dart';
import 'package:test/test.dart';

class SelectExistingHabit extends When1WithWorld<String, FlutterWorld> {
  @override
  Future<void> executeStep(String habitName) async {
    final habitFinder = find.text(habitName);
    await FlutterDriverUtils.tap(world.driver, habitFinder);
  }

  @override
  RegExp get pattern => RegExp(r'I select the existing habit');
}

class ClickOnEditButton extends When1WithWorld<String, FlutterWorld> {
  @override
  Future<void> executeStep(String buttonLabel) async {
    final editButtonFinder = find.byValueKey('edit-habit-button');
    await FlutterDriverUtils.tap(world.driver, editButtonFinder);
  }

  @override
  RegExp get pattern => RegExp(r'I click on the "Edit" button');
}

class ClickOnDeleteButton extends When1WithWorld<String, FlutterWorld> {
  @override
  Future<void> executeStep(String buttonLabel) async {
    final deleteButtonFinder = find.byValueKey('delete-habit-button');
    await FlutterDriverUtils.tap(world.driver, deleteButtonFinder);
  }

  @override
  RegExp get pattern => RegExp(r'I click on the "Delete" button');
}