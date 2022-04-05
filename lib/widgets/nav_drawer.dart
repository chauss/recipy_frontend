import 'package:flutter/material.dart';
import 'package:recipy_frontend/pages/ingredient/ingredients_control_page.dart';
import 'package:recipy_frontend/pages/recipe/recipe_overview_page.dart';

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
            title: const Text('Recipe Overview'),
            onTap: () => Navigator.push(
              context,
              MaterialPageRoute(
                  builder: (context) => const RecipeOverviewPage()),
            ),
          ),
          ListTile(
            leading: const Icon(Icons.settings),
            title: const Text('Ingredients Control Center'),
            onTap: () => Navigator.push(
              context,
              MaterialPageRoute(
                  builder: (context) => const IngredientsControlPage()),
            ),
          ),
        ],
      ),
    );
  }
}
