import 'package:flutter/material.dart';
import 'package:recipy_frontend/models/recipe.dart';
import 'package:recipy_frontend/pages/add_recipe_page.dart';
import 'package:recipy_frontend/repositories/recipe_repository.dart';
import 'package:recipy_frontend/widgets/recipe_widget.dart';

class MyHomePage extends StatefulWidget {
  const MyHomePage({Key? key}) : super(key: key);

  final String title = "Recipy";

  @override
  State<MyHomePage> createState() => _MyHomePageState();
}

class _MyHomePageState extends State<MyHomePage> {
  @override
  void initState() {
    super.initState();
  }

  Future<List<Recipe>> _fetchRecipeList() {
    return RecipeRepository.fetchRecipes();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text(widget.title),
      ),
      body: Center(
        child: ListView(
          children: [
            FutureBuilder<List<Recipe>>(
              future: _fetchRecipeList(),
              builder: (context, snapshot) {
                if (snapshot.connectionState != ConnectionState.done) {
                  return const CircularProgressIndicator();
                } else if (snapshot.hasData) {
                  var recipeWidgets = snapshot.data!
                      .map((recipe) => RecipeWidget(recipe: recipe))
                      .toList();
                  return Column(children: recipeWidgets);
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
          MaterialPageRoute(builder: (context) => const AddRecipePage()),
        ).then((addedNewRecipe) {
          if (addedNewRecipe == true) {
            setState(() {});
          }
        }),
        tooltip: 'Add new recipe',
        child: const Icon(Icons.add),
      ),
    );
  }
}
