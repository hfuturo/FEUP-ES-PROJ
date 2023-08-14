import 'package:flutter/material.dart';
import 'mytheme_preference.dart';

class ModelTheme extends ChangeNotifier {
  late int _color;
  late MyThemePreferences _preferences;
  int get color => _color;

  ModelTheme() {
    _color = 0;
    _preferences = MyThemePreferences();
    getPreferences();
  }
//Switching the themes
  set color(int value) {
    _color = value;
    _preferences.setTheme(value);
    notifyListeners();
  }

  getPreferences() async {
    _color = await _preferences.getTheme();
    notifyListeners();
  }
}
