import 'dart:async';
import 'package:flutter_gherkin/flutter_gherkin.dart';
import 'package:flutter-driver/flutter_driver.dart';
import 'package:test/test.dart';

class SelectExistingHabit extends Given1WithWorld<String, FlutterWorld> {
  @override
  Future<void> executeStep(String habitName) async {
    final habitFinder = find.text(habitName);
    await FlutterDriverUtils.tap(world.driver, habitFinder);
  }

  @override
  RegExp get pattern => RegExp(r'I have selected the existing habit "([^"]*)"');
}

class ClickOnEditButton extends When1WithWorld<String, FlutterWorld> {
  @override
  Future<void> executeStep(String buttonLabel) async {
    final editButtonFinder = find.byValueKey('edit-habit-button');
    await FlutterDriverUtils.tap(world.driver, editButtonFinder);
  }

  @override
  RegExp get pattern => RegExp(r'I click on the "([^"]*)" button');
}

class ClickOnAddReminderButton extends When1WithWorld<String, FlutterWorld> {
  @override
  Future<void> executeStep(String buttonLabel) async {
    final addReminderButtonFinder = find.byValueKey('add-reminder-button');
    await FlutterDriverUtils.tap(world.driver, addReminderButtonFinder);
  }

  @override
  RegExp get pattern => RegExp(r'I click on the "([^"]*)" button');
}

class SelectTimeForReminder extends When1WithWorld<String, FlutterWorld> {
  @override
  Future<void> executeStep(String time) async {
    final timePickerFinder = find.byValueKey('time-picker');
    final saveButtonFinder = find.text('Save');

    await FlutterDriverUtils.tap(world.driver, timePickerFinder);
    await FlutterDriverUtils.enterText(world.driver, time);
    await FlutterDriverUtils.tap(world.driver, saveButtonFinder);
  }

  @override
  RegExp get pattern => RegExp(r'I select the time "([^"]*)"');
}

class VerifyReminderIsSet extends Then2WithWorld<String, String, FlutterWorld> {
  @override
  Future<void> executeStep(String habitName, String reminderTime) async {
    final habitFinder = find.text(habitName);
    final reminderFinder = find.text(reminderTime);

    expect(await FlutterDriverUtils.isPresent(world.driver, habitFinder), isTrue);
    expect(await FlutterDriverUtils.isPresent(world.driver, reminderFinder), isTrue);
  }

  @override
  RegExp get pattern => RegExp(r'the habit "([^"]*)" should have a reminder set for "([^"]*)"');
}