import 'package:flutter/material.dart';
import 'package:recipy_frontend/pages/ingredient_units/ingredient_units_page.dart';
import 'package:recipy_frontend/pages/ingredients/ingredients_page.dart';
import 'package:recipy_frontend/pages/recipe_overview/recipe_overview_page.dart';
import 'package:easy_localization/easy_localization.dart';
import 'package:recipy_frontend/widgets/burger_icon.dart';
import 'package:recipy_frontend/widgets/locale_switcher.dart';

class NavDrawer extends StatelessWidget {
  final BurgerIconController iconController = BurgerIconController();

  NavDrawer({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
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
                style: Theme.of(context).textTheme.headline5,
              ).tr(),
              onTap: () => Navigator.push(
                context,
                MaterialPageRoute(
                    builder: (context) => const RecipeOverviewPage()),
              ),
            ),
            ListTile(
              leading: Image.asset("assets/icons/ingredients.png", width: 30),
              title: Text(
                "ingredients.title",
                style: Theme.of(context).textTheme.headline5,
              ).tr(),
              onTap: () => Navigator.push(
                context,
                MaterialPageRoute(
                    builder: (context) => const IngredientsPage()),
              ),
            ),
            ListTile(
              leading: Padding(
                padding: const EdgeInsets.only(left: 4),
                child: Image.asset("assets/icons/units.png", width: 24),
              ),
              title: Text(
                "ingredient_units.title",
                style: Theme.of(context).textTheme.headline5,
              ).tr(),
              onTap: () => Navigator.push(
                context,
                MaterialPageRoute(
                    builder: (context) => const IngredientUnitsPage()),
              ),
            ),
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
      decoration: BoxDecoration(
        color: Theme.of(context).backgroundColor,
      ),
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
}
