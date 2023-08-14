import 'dart:async';
import 'package:flutter_gherkin/flutter_gherkin.dart';
import 'package:flutter-driver/flutter_driver.dart';
import 'package:test/test.dart';

class ClickOnViewProgressButton extends When1WithWorld<String, FlutterWorld> {
  @override
  Future<void> executeStep(String buttonLabel) async {
    final viewProgressButtonFinder = find.byValueKey('view-progress-button');
    await FlutterDriverUtils.tap(world.driver, viewProgressButtonFinder);
  }

  @override
  RegExp get pattern => RegExp(r'I click on the "View Progress" button');
}
