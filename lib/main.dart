import 'package:firebase_core/firebase_core.dart';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
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

  configureLogging();

  // removes # from path but does not work out of the box with nginx docker container
  Beamer.setPathUrlStrategy();

  final container = ProviderContainer();
  final routerDelegate = createDelegte(container);

  RecipyInMemoryStorage().refetchIngredients();
  RecipyInMemoryStorage().refetchIngredientUnits();

  runApp(
    UncontrolledProviderScope(
      container: container,
      child: EasyLocalization(
          supportedLocales: supportedLocales,
          path: 'assets/translations',
          useOnlyLangCode: true,
          fallbackLocale: fallbackLocale,
          child: MyApp(routerDelegate: routerDelegate)),
    ),
  );
}

class MyApp extends StatelessWidget {
  final BeamerDelegate routerDelegate;

  const MyApp({Key? key, required this.routerDelegate}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return MaterialApp.router(
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
    );
  }
}
