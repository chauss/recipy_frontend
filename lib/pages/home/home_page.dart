import 'package:beamer/beamer.dart';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:recipy_frontend/config/routes_config.dart';
import 'package:recipy_frontend/helpers/providers.dart';
import 'package:recipy_frontend/pages/home/home_model.dart';

class HomePage extends ConsumerWidget {
  const HomePage({super.key});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    HomeController controller =
        ref.read(recipyBottomNavigationBarProvider.notifier);
    HomeModel model = ref.watch(recipyBottomNavigationBarProvider);

    return Scaffold(
      body: IndexedStack(
        index: model.currentPageIndex,
        children: recipyHomeBeamerLocations
            .map((location) => Beamer(routerDelegate: location))
            .toList(),
      ),
      bottomNavigationBar: BottomNavigationBar(
        currentIndex: model.currentPageIndex,
        items: const [
          BottomNavigationBarItem(icon: Icon(Icons.home), label: "Home"),
          // BottomNavigationBarItem(icon: Icon(Icons.search), label: "Search"),
          BottomNavigationBarItem(icon: Icon(Icons.person), label: "Profile"),
        ],
        onTap: (idx) => _onCurrentIndexChanged(context, idx, model, controller),
      ),
    );
  }

  void _onCurrentIndexChanged(
    BuildContext context,
    int index,
    HomeModel model,
    HomeController controller,
  ) {
    controller.setCurrentIndexPage(index);
    // This causes an error, lets see if we can just dump it
    // switch (index) {
    //   case 0:
    //     context.beamToNamed(RecipyRoute.recipes);
    //     break;
    //   case 1:
    //     break;
    //   case 2:
    //     if (model.isUserLoggedIn) {
    //       context.beamToNamed(RecipyRoute.userProfile);
    //     } else {
    //       context.beamToNamed(RecipyRoute.login);
    //     }
    //     break;
    //   default:
    // }
  }
}

abstract class HomeController extends StateNotifier<HomeModel> {
  HomeController(super.state);

  void setCurrentIndexPage(int pageIndex);
}
