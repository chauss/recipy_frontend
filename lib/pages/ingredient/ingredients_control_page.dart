import 'package:flutter/material.dart';
import 'package:recipy_frontend/models/ingredient.dart';
import 'package:recipy_frontend/pages/ingredient/add_ingredient_page.dart';
import 'package:recipy_frontend/repositories/ingredient_repository.dart';
import 'package:recipy_frontend/widgets/ingredient_widget.dart';
import 'package:recipy_frontend/widgets/nav_drawer.dart';

class IngredientsControlPage extends StatefulWidget {
  const IngredientsControlPage({Key? key}) : super(key: key);

  @override
  State<StatefulWidget> createState() => _IngredientsControlPageState();
}

class _IngredientsControlPageState extends State<IngredientsControlPage> {
  Future<List<Ingredient>> _fetchAllIngredients() {
    return IngredientRepository.fetchIngredients();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text("Ingredients Control Center"),
      ),
      drawer: const NavDrawer(),
      body: Center(
        child: ListView(
          children: [
            FutureBuilder<List<Ingredient>>(
              future: _fetchAllIngredients(),
              builder: (context, snapshot) {
                if (snapshot.connectionState != ConnectionState.done) {
                  return const CircularProgressIndicator();
                } else if (snapshot.hasData) {
                  var ingredientWidgets = snapshot.data!
                      .map((ingredient) =>
                          IngredientWidget(ingredient: ingredient))
                      .toList();
                  return Column(children: ingredientWidgets);
                } else if (snapshot.hasError) {
                  return Text('${snapshot.error}');
                }
                return const CircularProgressIndicator();
              },
            ),
            const SizedBox(height: 24)
          ],
        ),
      ),
      floatingActionButton: FloatingActionButton(
        onPressed: () => Navigator.push(
          context,
          MaterialPageRoute(builder: (context) => const AddIngredientPage()),
        ).then((addedNewIngredient) {
          if (addedNewIngredient == true) {
            setState(() {});
          }
        }),
        tooltip: 'Add new ingredient',
        child: const Icon(Icons.add),
      ),
    );
  }
}
