import 'package:flutter/material.dart';
import 'package:glish_note_app/shared/consts/colors.dart';

ThemeData lightmode = ThemeData(
    brightness: Brightness.light,
    appBarTheme: const AppBarTheme(
      backgroundColor: Colors.transparent,
      elevation: 0,
      iconTheme: IconThemeData(color: Colors.black),
      titleTextStyle: TextStyle(color: Colors.black, fontSize: 20),
    ),
    colorScheme: const ColorScheme.light(
      primary: Colors.white70,
      secondary: Colors.white60,
    ),
    cardTheme: const CardTheme(
    color: Colors.white,
  ),
  primaryColor: ColorsConsts.black,  
  scaffoldBackgroundColor: Colors.white,  
);
