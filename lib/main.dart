import 'package:flutter/material.dart';
import 'package:intl/intl.dart';
import 'package:intl/date_symbol_data_local.dart' as intl_initializer;
import 'package:recipy_frontend/helpers/logging_helper.dart';
import 'package:recipy_frontend/pages/recipe/recipe_overview_page.dart';
import 'package:recipy_frontend/storage/in_memory_storage.dart';

void main() {
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({Key? key}) : super(key: key);

  // This widget is the root of your application.
  @override
  Widget build(BuildContext context) {
    Intl.defaultLocale = 'de';
    intl_initializer.initializeDateFormatting();

    configureLogging();

    RecipyInMemoryStorage().refetchIngredients();
    RecipyInMemoryStorage().refetchIngredientUnits();

    return MaterialApp(
      title: 'Recipy',
      debugShowCheckedModeBanner: false,
      theme: ThemeData(
        // This is the theme of your application.
        //
        // Try running your application with "flutter run". You'll see the
        // application has a blue toolbar. Then, without quitting the app, try
        // changing the primarySwatch below to Colors.green and then invoke
        // "hot reload" (press "r" in the console where you ran "flutter run",
        // or simply save your changes to "hot reload" in a Flutter IDE).
        // Notice that the counter didn't reset back to zero; the application
        // is not restarted.
        primarySwatch: Colors.blue,
      ),
      // home: const IngredientsControlPage(),
      home: const RecipeOverviewPage(),
    );
  }
}
