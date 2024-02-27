/*
 * Project: Xtronic Dev Tools
 * File Name: app_themes.dart
 * File Created: Friday, 9th February 2024 11:45:32 pm
 * Author: Omegaki113r (omegaki113r@gmail.com)
 * -----
 * Last Modified: Tuesday, 27th February 2024 9:29:19 pm
 * Modified By: Omegaki113r (omegaki113r@gmail.com>)
 * -----
 * Copyright 2024 - 2024 0m3g4ki113r, Xtronic
 * -----
 * HISTORY:
 * Date      	By	Comments
 * ----------	---	---------------------------------------------------------
 */


import 'package:dev_tools/core/constants/app_colors.dart';
import 'package:flutter/material.dart';

final ThemeData lightTheme = ThemeData(
  colorScheme: ColorScheme.fromSwatch(
    primarySwatch: color1MaterialColor,
    accentColor: color1MaterialColor,
    backgroundColor: color6MaterialColor,
  ),
  textTheme: const TextTheme(
    bodyLarge: TextStyle(color: color1), //TextField
    bodyMedium: TextStyle(color: color2), //Text
    labelLarge:
        TextStyle(color: color1, fontWeight: FontWeight.normal), //TextButton
    displayLarge: TextStyle(color: Colors.amber),
    displayMedium: TextStyle(color: Colors.amber),
    displaySmall: TextStyle(color: Colors.amber),
    headlineLarge: TextStyle(color: Colors.amber),
    headlineMedium: TextStyle(color: Colors.amber),
    headlineSmall: TextStyle(color: Colors.amber),
    // titleLarge: TextStyle(color: Colors.red),
    titleMedium: TextStyle(
      color: color1,
      fontWeight: FontWeight.normal,
    ),
    titleSmall: TextStyle(color: Colors.amber),
    bodySmall: TextStyle(color: Colors.amber),
    labelMedium: TextStyle(color: Colors.amber),
    labelSmall: TextStyle(color: Colors.amber),
  ),
  inputDecorationTheme: InputDecorationTheme(
      fillColor: Colors.red,
      labelStyle: const TextStyle(color: Colors.amber),
      enabledBorder: UnderlineInputBorder(
        borderSide: BorderSide(color: color1MaterialColor.shade400),
      ),
      focusedBorder:
          const UnderlineInputBorder(borderSide: BorderSide(color: color1))),
  dividerTheme: const DividerThemeData(color: color5, space: 20),
  textButtonTheme: TextButtonThemeData(
    style: ButtonStyle(
      overlayColor:
          MaterialStateProperty.resolveWith<Color>((Set<MaterialState> states) {
        if (states.contains(MaterialState.focused)) return Colors.red;
        if (states.contains(MaterialState.hovered)) return Colors.transparent;
        if (states.contains(MaterialState.pressed)) return Colors.blue;
        return Colors.grey; // Defer to the widget's default.
      }),
      // minimumSize: const MaterialStatePropertyAll(Size.zero),
      padding: const MaterialStatePropertyAll(
        EdgeInsets.all(0),
      ),
    ),
  ),
  cardTheme: const CardTheme(
    color: color6,
  ),
  dropdownMenuTheme: const DropdownMenuThemeData(
    textStyle: TextStyle(fontSize: 12),
  ),
);

final ThemeData darkTheme = ThemeData(
  colorScheme: ColorScheme.fromSwatch(
    primarySwatch: color1MaterialColor,
    accentColor: color1MaterialColor,
    backgroundColor: color6MaterialColor,
  ),
  textTheme: const TextTheme(
    labelLarge: TextStyle(
      color: color3,
    ),
  ),
  dropdownMenuTheme: const DropdownMenuThemeData(
    textStyle: TextStyle(fontSize: 12),
  ),
);
