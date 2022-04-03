import 'package:flutter/material.dart';
import 'package:recipy_frontend/models/recipe.dart';
import 'package:recipy_frontend/repositories/recipe_repository.dart';
import 'package:recipy_frontend/widgets/recipe_widget.dart';

class MyHomePage extends StatefulWidget {
  const MyHomePage({Key? key}) : super(key: key);

  final String title = "Recipy";

  @override
  State<MyHomePage> createState() => _MyHomePageState();
}

class _MyHomePageState extends State<MyHomePage> {
  late Future<List<Recipe>> futureRecipes;

  @override
  void initState() {
    super.initState();
    futureRecipes = RecipeRepository.fetchRecipes();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text(widget.title),
      ),
      body: Center(
        child: FutureBuilder<List<Recipe>>(
          future: futureRecipes,
          builder: (context, snapshot) {
            print(snapshot);
            if (snapshot.hasData) {
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
      ),
      floatingActionButton: FloatingActionButton(
        onPressed: () => {},
        tooltip: 'Increment',
        child: const Icon(Icons.add),
      ), // This trailing comma makes auto-formatting nicer for build methods.
    );
  }
}
