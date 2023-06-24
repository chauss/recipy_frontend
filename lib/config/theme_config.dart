import 'package:flutter/material.dart';

const appColor = Color(0xFF43A047);

var appColorSwatch = createMaterialColor(appColor);

ThemeData appTheme = ThemeData(
  fontFamily: "Roboto",
  primaryColor: appColor,
  primarySwatch: appColorSwatch,
  brightness: Brightness.dark,
  floatingActionButtonTheme: FloatingActionButtonThemeData(
    backgroundColor: appColorSwatch.shade100,
  ),
  bottomNavigationBarTheme: BottomNavigationBarThemeData(
    selectedItemColor: appColorSwatch.shade300,
  ),
  appBarTheme: const AppBarTheme(backgroundColor: Colors.transparent),
  textTheme: TextTheme(
    titleMedium: const TextStyle(
      color: Colors.white,
    ),
    headlineMedium: TextStyle(
      color: appColorSwatch,
      fontSize: 24,
    ),
    headlineSmall: TextStyle(
      color: appColorSwatch.shade400,
      fontSize: 20,
    ),
    titleLarge: TextStyle(
      color: Colors.white.withOpacity(.8),
      fontSize: 20,
    ),
    bodyMedium: const TextStyle(
      color: Colors.white,
      fontSize: 18,
    ),
  ),
);

MaterialColor createMaterialColor(Color color) {
  List strengths = <double>[.05];
  Map<int, Color> swatch = {};
  final int r = color.red, g = color.green, b = color.blue;

  for (int i = 1; i < 10; i++) {
    strengths.add(0.1 * i);
  }
  for (var strength in strengths) {
    final double ds = 0.5 - strength;
    swatch[(strength * 1000).round()] = Color.fromRGBO(
      r + ((ds < 0 ? r : (255 - r)) * ds).round(),
      g + ((ds < 0 ? g : (255 - g)) * ds).round(),
      b + ((ds < 0 ? b : (255 - b)) * ds).round(),
      1,
    );
  }
  return MaterialColor(color.value, swatch);
}
