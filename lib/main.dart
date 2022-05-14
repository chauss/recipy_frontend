import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:recipy_frontend/config/locale_config.dart';
import 'package:recipy_frontend/config/routes_config.dart';
import 'package:recipy_frontend/config/theme_config.dart';
import 'package:recipy_frontend/helpers/logging_helper.dart';
import 'package:recipy_frontend/storage/in_memory_storage.dart';
import 'package:easy_localization/easy_localization.dart';
import 'package:beamer/beamer.dart';

void main() async {
  WidgetsFlutterBinding.ensureInitialized();
  await EasyLocalization.ensureInitialized();

  runApp(
    EasyLocalization(
        supportedLocales: supportedLocales,
        path: 'assets/translations',
        useOnlyLangCode: true,
        fallbackLocale: fallbackLocale,
        child: const MyApp()),
  );
}

class MyApp extends StatelessWidget {
  const MyApp({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    configureLogging();

    RecipyInMemoryStorage().refetchIngredients();
    RecipyInMemoryStorage().refetchIngredientUnits();

    return ProviderScope(
      child: MaterialApp.router(
        debugShowCheckedModeBanner: false,
        localizationsDelegates: context.localizationDelegates,
        supportedLocales: context.supportedLocales,
        locale: context.locale,
        theme: appTheme,
        routeInformationParser: BeamerParser(),
        routerDelegate: recipyRouterDelegate,
      ),
    );
  }
}
