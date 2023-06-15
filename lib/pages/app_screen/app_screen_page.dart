import 'package:beamer/beamer.dart';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:recipy_frontend/config/routes_config.dart';
import 'package:recipy_frontend/helpers/providers.dart';
import 'package:recipy_frontend/pages/app_screen/app_screen_model.dart';
import 'package:easy_localization/easy_localization.dart';

class AppScreenPage extends ConsumerWidget {
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
          Beamer(routerDelegate: recipyBeamerLocations[0]),
          Beamer(routerDelegate: recipyBeamerLocations[1])
        ],
      ),
      bottomNavigationBar: BottomNavigationBar(
        currentIndex: model.currentPageIndex,
        items: [
          BottomNavigationBarItem(
            icon: const Icon(Icons.home),
            label: "bottom_navigation.home".tr(),
          ),
          BottomNavigationBarItem(
            icon: const Icon(Icons.person),
            label: "bottom_navigation.profile".tr(),
          ),
        ],
        onTap: (idx) {
          recipyBeamerLocations[idx].update(rebuild: false);
          controller.setCurrentIndexPage(idx);
        },
      ),
    );
  }
}

abstract class AppScreenController extends StateNotifier<AppScreenModel> {
  AppScreenController(super.state);

  void setCurrentIndexPage(int pageIndex);
}
