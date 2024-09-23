import 'package:flutter/material.dart';
import 'package:glish_note_app/shared/consts/colors.dart';

ThemeData lightMode = ThemeData(
    brightness: Brightness.light,
    appBarTheme: const AppBarTheme(
      backgroundColor: Colors.transparent,
      elevation: 0,
      iconTheme: IconThemeData(color: Colors.black),
      titleTextStyle: TextStyle(color: Colors.black, fontSize: 20),
    ),
    colorScheme: const ColorScheme.light(
      background: Colors.white,
      primary: Colors.white70,
      secondary: Colors.white60,
    ),
    bottomNavigationBarTheme: BottomNavigationBarThemeData(
      backgroundColor: const Color(0xFF211F60),
      selectedItemColor: Colors.black,
      unselectedItemColor: ColorsConsts.endColor,
    ),
);
