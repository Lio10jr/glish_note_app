import 'package:flutter/material.dart';
import 'package:glish_note_app/shared/consts/colors.dart';

ThemeData darkmode = ThemeData(
  brightness: Brightness.dark,
  appBarTheme: const AppBarTheme(
    backgroundColor: Colors.transparent,
    elevation: 0,
    iconTheme: IconThemeData(color: Colors.white),
    titleTextStyle: TextStyle(color: Colors.white, fontSize: 20),
  ),
  colorScheme: const ColorScheme.dark(
    primary: Colors.black54,
    secondary: Colors.black45,
  ),
  cardTheme: const CardTheme(
    color: Colors.black26,
  ),
  primaryColor: ColorsConsts.white,
  scaffoldBackgroundColor: const Color(0xFF1A1A1A),
);
