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
  primarySwatch: primaryColorSwatch,
  colorScheme: ColorScheme.fromSwatch(
    primarySwatch: primaryColorSwatch,
    accentColor: Colors.cyan,
    backgroundColor: Colors.cyan,
    cardColor: appColor,
    errorColor: Colors.red,
    brightness: Brightness.dark,
  ),
  textTheme: TextTheme(
    titleMedium: TextStyle(
      fontFamily: "Roboto",
      color: primaryColorSwatch.shade700,
    ),
    labelLarge: TextStyle(
      fontFamily: "Roboto",
      color: primaryColorSwatch.shade900,
    ),
    headlineMedium: TextStyle(
      fontFamily: "Roboto",
      color: primaryColorSwatch.shade900,
    ),
    headlineSmall: TextStyle(
      fontFamily: "Roboto",
      color: primaryColorSwatch.shade900,
    ),
    titleLarge: TextStyle(
      fontFamily: "Roboto",
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
