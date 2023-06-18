import 'package:firebase_core/firebase_core.dart';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:logging/logging.dart';
import 'package:recipy_frontend/config/locale_config.dart';
import 'package:recipy_frontend/config/routes_config.dart';
import 'package:recipy_frontend/config/theme_config.dart';
import 'package:recipy_frontend/helpers/logging_helper.dart';
import 'package:recipy_frontend/storage/in_memory_storage.dart';
import 'package:easy_localization/easy_localization.dart';
import 'package:beamer/beamer.dart';
import 'firebase_options.dart';

Future<void> main() async {
  WidgetsFlutterBinding.ensureInitialized();
  await Firebase.initializeApp(
    options: DefaultFirebaseOptions.currentPlatform,
  );
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
    Logger.root.level = Level.ALL;

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
        routerDelegate: routerDelegate,
        backButtonDispatcher: BeamerBackButtonDispatcher(
          delegate: routerDelegate,
        ),
      ),
    );
  }
}
