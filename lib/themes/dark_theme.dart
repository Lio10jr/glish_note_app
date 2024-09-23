import 'package:flutter/material.dart';
import 'package:glish_note_app/shared/consts/colors.dart';

ThemeData darkMode = ThemeData(
  brightness: Brightness.dark,
  appBarTheme: const AppBarTheme(
    backgroundColor: Colors.transparent,
    elevation: 0,
    iconTheme: IconThemeData(color: Colors.white),
    titleTextStyle: TextStyle(color: Colors.white, fontSize: 20),
  ),
  colorScheme: const ColorScheme.dark(
    background: Colors.black87,
    primary: Colors.black54,
    secondary: Colors.black45,
  ),
  bottomNavigationBarTheme: BottomNavigationBarThemeData(
    backgroundColor: const Color(0xFF211F60),
    selectedItemColor: Colors.white,
    unselectedItemColor: ColorsConsts.endColor
  ),
);
