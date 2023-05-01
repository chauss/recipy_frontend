import 'package:flutter/material.dart';

const appColor = Color(0xFF43A047);

var primaryColorSwatch = MaterialColor(
  appColor.value,
  <int, Color>{
    50: appColor.withOpacity(.1),
    100: appColor.withOpacity(.2),
    200: appColor.withOpacity(.3),
    300: appColor.withOpacity(.4),
    400: appColor.withOpacity(.5),
    500: appColor.withOpacity(.6),
    600: appColor.withOpacity(.7),
    700: appColor.withOpacity(.8),
    800: appColor.withOpacity(.9),
    900: appColor,
  },
);

ThemeData appTheme = ThemeData(
  fontFamily: "Roboto",
  primaryColor: appColor,
  primarySwatch: primaryColorSwatch,
  colorScheme: ColorScheme.fromSwatch(
    primarySwatch: primaryColorSwatch,
    brightness: Brightness.dark,
  ),
  appBarTheme: const AppBarTheme(backgroundColor: Colors.transparent),
  textTheme: TextTheme(
    titleMedium: TextStyle(
      color: primaryColorSwatch.shade700,
    ),
    labelLarge: TextStyle(
      color: primaryColorSwatch.shade900,
    ),
    headlineMedium: TextStyle(
      color: primaryColorSwatch.shade900,
    ),
    headlineSmall: TextStyle(
      color: primaryColorSwatch.shade900,
    ),
    titleLarge: TextStyle(
      color: primaryColorSwatch.shade900,
      fontSize: 20,
    ),
  ),
);
