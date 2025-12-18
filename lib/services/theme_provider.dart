import 'package:flutter/material.dart';
import 'package:shared_preferences/shared_preferences.dart';

class ThemeProvider with ChangeNotifier {
  ThemeMode _themeMode = ThemeMode.system;

  ThemeMode get currentTheme => _themeMode;

  ThemeProvider() {
    _loadThemeFromPrefs();
  }

  void changeTheme(ThemeMode mode) async {
    _themeMode = mode;
    notifyListeners();
    _saveThemeToPrefs();
  }

  void _loadThemeFromPrefs() async {
    final prefs = await SharedPreferences.getInstance();
    final themeString = prefs.getString('themeMode') ?? 'system';

    if (themeString == 'dark') {
      _themeMode = ThemeMode.dark;
    } else if (themeString == 'light') {
      _themeMode = ThemeMode.light;
    } else {
      _themeMode = ThemeMode.system;
    }
    notifyListeners();
  }

  void _saveThemeToPrefs() async {
    final prefs = await SharedPreferences.getInstance();
    String themeString;
    if (_themeMode == ThemeMode.dark) {
      themeString = 'dark';
    } else if (_themeMode == ThemeMode.light) {
      themeString = 'light';
    } else {
      themeString = 'system';
    }
    prefs.setString('themeMode', themeString);
  }
}
