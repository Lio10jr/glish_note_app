import 'package:flutter/material.dart';
import 'package:glish_note_app/themes/dark_theme.dart';
import 'package:glish_note_app/themes/light_theme.dart';
import 'package:shared_preferences/shared_preferences.dart';

class ThemeProvider with ChangeNotifier {
  bool _isSelected = false;
  bool get isSelected => false;

  ThemeData _themeData = lightmode;
  ThemeData get themeData => _themeData;

  ThemeProvider() {
    _loadTheme(); // Cargar el tema al inicializar el provider
  }

  void toggleTheme() {
    if (_themeData == lightmode) {
      _themeData = darkmode;
    } else {
      _themeData = lightmode;
    }
    _isSelected = !_isSelected;

    SharedPreferences.getInstance().then((prefs) {
      prefs.setBool('_isSelected', _isSelected);
    });

    notifyListeners();
  }

  Future<void> _loadTheme() async {
    final prefs = await SharedPreferences.getInstance();
    _isSelected = prefs.getBool('_isSelected') ?? false;

    _themeData = _isSelected ? darkmode : lightmode;

    notifyListeners();
  }
}
