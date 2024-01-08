import 'package:dev_tools/const/app_colors.dart';
import 'package:flutter/material.dart';

final ThemeData lightTheme = ThemeData(
  colorScheme: ColorScheme.fromSwatch(
    primarySwatch: color1MaterialColor,
    accentColor: color1MaterialColor,
    backgroundColor: color6MaterialColor,
  ),
  textTheme: const TextTheme(
    labelLarge: TextStyle(
      color: color1,
      fontWeight: FontWeight.normal,
    ),
  ),
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
  cardTheme: CardTheme(
    color: color5,
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
