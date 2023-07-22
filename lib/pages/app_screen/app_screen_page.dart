import 'package:beamer/beamer.dart';
import 'package:flutter/material.dart';
import 'package:flutter/scheduler.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:logging/logging.dart';
import 'package:recipy_frontend/config/routes_config.dart';
import 'package:recipy_frontend/helpers/providers.dart';
import 'package:recipy_frontend/pages/app_screen/app_screen_model.dart';
import 'package:easy_localization/easy_localization.dart';

class AppScreenPage extends ConsumerWidget {
  static final log = Logger('AppScreenControllerImpl');

  final List<BeamerDelegate> beamerLocationDelegates;

  const AppScreenPage({super.key, required this.beamerLocationDelegates});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    AppScreenController controller =
        ref.read(recipyAppScreenControllerProvider.notifier);
    AppScreenModel model = ref.watch(recipyAppScreenControllerProvider);

    react(controller, context);

    return Scaffold(
      body: IndexedStack(
        index: model.currentPageIndex,
        children: [
          Beamer(routerDelegate: beamerLocationDelegates[0]),
          Beamer(routerDelegate: beamerLocationDelegates[1])
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
          beamerLocationDelegates[idx].update(rebuild: false);
          controller.setCurrentIndexPage(idx);
        },
      ),
    );
  }

  void react(AppScreenController controller, BuildContext context) {
    final uriString = Beamer.of(context).configuration.location!;
    final currentPage = uriString.startsWith(RecipyRoute.homePrefix) ? 0 : 1;
    log.info("CurrentPage is $currentPage because uriString is $uriString");
    SchedulerBinding.instance.addPostFrameCallback(
        (_) => controller.setCurrentIndexPage(currentPage));
  }
}

abstract class AppScreenController extends StateNotifier<AppScreenModel> {
  AppScreenController(super.state);

  void setCurrentIndexPage(int pageIndex);
}
