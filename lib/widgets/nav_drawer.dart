import 'package:beamer/beamer.dart';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:recipy_frontend/config/routes_config.dart';
import 'package:easy_localization/easy_localization.dart';
import 'package:recipy_frontend/helpers/providers.dart';
import 'package:recipy_frontend/pages/user/user_management_repository.dart';
import 'package:recipy_frontend/widgets/burger_icon.dart';
import 'package:recipy_frontend/widgets/locale_switcher.dart';

class NavDrawer extends StatelessWidget {
  final BurgerIconController iconController = BurgerIconController();

  NavDrawer({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    final container = ProviderContainer();
    UserManagementRepository userManagementRepository =
        container.read(userManagementRepositoryProvider);

    return InkWell(
      onTap: iconController.showSmile,
      child: Drawer(
        child: Column(
          children: <Widget>[
            buildDrawerHeader(context),
            ListTile(
              leading: const Icon(Icons.home),
              title: Text(
                "recipe_overview.title",
                style: Theme.of(context).textTheme.headlineSmall,
              ).tr(),
              onTap: () => Beamer.of(context).beamToNamed(RecipyRoute.recipes),
            ),
            ListTile(
              leading: Image.asset("assets/icons/ingredients.png", width: 30),
              title: Text(
                "ingredients.title",
                style: Theme.of(context).textTheme.headlineSmall,
              ).tr(),
              onTap: () =>
                  Beamer.of(context).beamToNamed(RecipyRoute.ingredients),
            ),
            ListTile(
              leading: const Padding(
                padding: EdgeInsets.only(left: 4),
                child: Icon(Icons.tornado),
              ),
              title: Text(
                "ingredient_units.title",
                style: Theme.of(context).textTheme.headlineSmall,
              ).tr(),
              onTap: () =>
                  Beamer.of(context).beamToNamed(RecipyRoute.ingredientUnits),
            ),
            Expanded(child: Container()),
            buildUserTile(context, userManagementRepository),
            Expanded(child: Container()),
            const SafeArea(
              top: false,
              child: Padding(
                padding: EdgeInsets.only(left: 16, bottom: 12),
                child: LocaleSwitcher(),
              ),
            ),
          ],
        ),
      ),
    );
  }

  DrawerHeader buildDrawerHeader(BuildContext context) {
    return DrawerHeader(
      child: Center(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            BurgerIcon(controller: iconController),
            const SizedBox(height: 4),
            Padding(
              padding: const EdgeInsets.only(left: 12),
              child: Image.asset(
                'assets/logo.png',
                width: 100,
              ),
            ),
          ],
        ),
      ),
    );
  }

  Widget buildUserTile(
      BuildContext context, UserManagementRepository userManagementRepository) {
    if (userManagementRepository.isUserLoggedIn()) {
      return ListTile(
        leading: const Icon(Icons.person),
        title: Text(
          "user.profile.title",
          style: Theme.of(context).textTheme.headlineSmall,
        ).tr(),
        onTap: () => Beamer.of(context).beamToNamed(RecipyRoute.userProfile),
      );
    } else {
      return ListTile(
        leading: const Icon(Icons.login),
        title: Text(
          "user.login.title",
          style: Theme.of(context).textTheme.headlineSmall,
        ).tr(),
        onTap: () => Beamer.of(context).beamToNamed(RecipyRoute.login),
      );
    }
  }
}
