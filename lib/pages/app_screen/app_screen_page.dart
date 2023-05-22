import 'package:beamer/beamer.dart';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:recipy_frontend/config/routes_config.dart';
import 'package:recipy_frontend/helpers/providers.dart';
import 'package:recipy_frontend/pages/app_screen/app_screen_model.dart';

class AppScreenPage extends ConsumerWidget {
  static GlobalKey<NavigatorState> homeNavigatorKey =
      GlobalKey(debugLabel: "home-location-beamer-key");
  static GlobalKey<NavigatorState> userNavigatorKey =
      GlobalKey(debugLabel: "user-location-beamer-key");
  const AppScreenPage({super.key});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    AppScreenController controller =
        ref.read(recipyAppScreenControllerProvider.notifier);
    AppScreenModel model = ref.watch(recipyAppScreenControllerProvider);

    return Scaffold(
      body: IndexedStack(
        index: model.currentPageIndex,
        children: [
          Beamer(
            key: GlobalKey(debugLabel: "home-location-beamer-key"),
            routerDelegate: recipyBeamerLocations[0],
          ),
          Beamer(
            key: GlobalKey(debugLabel: "user-location-beamer-key"),
            routerDelegate: recipyBeamerLocations[1],
          )
        ],
      ),
      bottomNavigationBar: BottomNavigationBar(
        currentIndex: model.currentPageIndex,
        items: const [
          BottomNavigationBarItem(
              icon: Icon(Icons.home), label: "Home"), // TODO Label translation
          // BottomNavigationBarItem(icon: Icon(Icons.search), label: "Search"),
          BottomNavigationBarItem(
            icon: Icon(Icons.person),
            label: "Profile",
          ), // TODO Label translation
        ],
        onTap: controller.setCurrentIndexPage,
      ),
    );
  }
}

abstract class AppScreenController extends StateNotifier<AppScreenModel> {
  AppScreenController(super.state);

  void setCurrentIndexPage(int pageIndex);
}
