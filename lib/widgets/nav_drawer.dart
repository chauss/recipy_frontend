import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:recipy_frontend/pages/ingredient_units/ingredient_units_page.dart';
import 'package:recipy_frontend/pages/ingredients/ingredients_page.dart';
import 'package:recipy_frontend/pages/recipe_overview/recipe_overview_page.dart';
import 'package:easy_localization/easy_localization.dart';
import 'package:recipy_frontend/widgets/locale_switcher.dart';

class NavDrawer extends StatelessWidget {
  const NavDrawer({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Drawer(
      child: Column(
        children: <Widget>[
          buildDrawerHeader(context),
          ListTile(
            leading: const Icon(Icons.home),
            title: const Text("recipe_overview.title").tr(),
            onTap: () => Navigator.push(
              context,
              MaterialPageRoute(
                  builder: (context) => const RecipeOverviewPage()),
            ),
          ),
          ListTile(
            leading: const Icon(CupertinoIcons.barcode),
            title: const Text("ingredients.title").tr(),
            onTap: () => Navigator.push(
              context,
              MaterialPageRoute(builder: (context) => const IngredientsPage()),
            ),
          ),
          ListTile(
            leading: const Icon(CupertinoIcons.greaterthan_square),
            title: const Text("ingredient_units.title").tr(),
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
            Image.asset(
              'assets/icons/burger-smile.png',
              width: 80,
            ),
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
