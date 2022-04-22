import 'package:flutter/material.dart';

var accentColorSwatch = MaterialColor(
  const Color(0xffdcd3aa).value,
  const <int, Color>{
    50: Color(0xFFf2eede),
    100: Color(0xFFede9d4),
    200: Color(0xFFe9e3c9),
    300: Color(0xFFe4ddbe),
    400: Color(0xffe0d8b3),
    500: Color(0xffdcd3aa),
    600: Color(0xffd0c38b),
    700: Color(0xffc4b46e),
    800: Color(0xffb8a551),
    900: Color(0xff9f8e41),
  },
);

var primaryColorSwatch = MaterialColor(
  const Color(0xffdcd3aa).value,
  const <int, Color>{
    50: Color(0xFFcbc3b4),
    100: Color(0xFFc0b8a5),
    200: Color(0xFFb6ac96),
    300: Color(0xFFaba087),
    400: Color(0xffa19478),
    500: Color(0xff968869),
    600: Color(0xff877a5e),
    700: Color(0xff786d54),
    800: Color(0xff695f49),
    900: Color(0xff5a523f),
  },
);

ThemeData appTheme = ThemeData(
  fontFamily: "IndieFlower",
  primarySwatch: primaryColorSwatch,
  backgroundColor: accentColorSwatch,
  colorScheme: ColorScheme.fromSwatch(
    primarySwatch: primaryColorSwatch,
    accentColor: accentColorSwatch,
    backgroundColor: Colors.purple,
    cardColor: Colors.cyan,
    errorColor: Colors.red,
    brightness: Brightness.light,
  ),
  textTheme: TextTheme(
    subtitle1: TextStyle(
      fontFamily: "IndieFlower",
      color: primaryColorSwatch.shade700,
    ),
    button: TextStyle(
      fontFamily: "IndieFlower",
      color: primaryColorSwatch.shade900,
    ),
    headline4: TextStyle(
      fontFamily: "IndieFlower",
      color: primaryColorSwatch.shade900,
    ),
    headline5: TextStyle(
      fontFamily: "IndieFlower",
      color: primaryColorSwatch.shade900,
    ),
    headline6: TextStyle(
      fontFamily: "IndieFlower",
      color: primaryColorSwatch.shade900,
      fontSize: 20,
    ),
  ),
);

// ColorScheme _customColorScheme = ColorScheme(
//   primary: customMagenta50,
//   primaryContainer: customMagenta600,
//   secondary: Colors.amber,
//   secondaryContainer: customMagenta400,
//   surface: Colors.purpleAccent,
//   background: customSurfaceWhite,
//   error: customMagenta900,
//   onPrimary: Colors.red,
//   onSecondary: Colors.deepOrange,
//   onSurface: customMagenta300,
//   onBackground: customMagenta100,
//   onError: Colors.redAccent,
//   brightness: Brightness.light,
// );
