import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:recipy_frontend/pages/ingredient_units/ingredient_units_page.dart';
import 'package:recipy_frontend/pages/ingredients/ingredients_page.dart';
import 'package:recipy_frontend/pages/recipe_overview/recipe_overview_page.dart';

class NavDrawer extends StatelessWidget {
  const NavDrawer({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Drawer(
      child: ListView(
        padding: EdgeInsets.zero,
        children: <Widget>[
          const DrawerHeader(
            decoration: BoxDecoration(
              color: Colors.blue,
            ),
            child: Center(child: Text('Recipy')),
          ),
          ListTile(
            leading: const Icon(Icons.home),
            title: const Text('Rezeptübersicht'),
            onTap: () => Navigator.push(
              context,
              MaterialPageRoute(
                  builder: (context) => const RecipeOverviewPage()),
            ),
          ),
          ListTile(
            leading: const Icon(CupertinoIcons.barcode),
            title: const Text('Zutaten'),
            onTap: () => Navigator.push(
              context,
              MaterialPageRoute(builder: (context) => const IngredientsPage()),
            ),
          ),
          ListTile(
            leading: const Icon(CupertinoIcons.greaterthan_square),
            title: const Text('Einheiten'),
            onTap: () => Navigator.push(
              context,
              MaterialPageRoute(
                  builder: (context) => const IngredientUnitsPage()),
            ),
          ),
        ],
      ),
    );
  }
}
