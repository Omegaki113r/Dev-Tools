import 'package:dev_tools/const/app_colors.dart';
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
      labelStyle: TextStyle(color: Colors.amber),
      enabledBorder: UnderlineInputBorder(
        borderSide: BorderSide(color: color1MaterialColor.shade400),
      ),
      focusedBorder:
          UnderlineInputBorder(borderSide: BorderSide(color: color1))),
  dividerTheme: DividerThemeData(color: color5, space: 20),
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
);
