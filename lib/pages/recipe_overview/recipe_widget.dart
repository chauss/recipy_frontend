import 'package:flutter/material.dart';
import 'package:intl/intl.dart';
import 'package:recipy_frontend/models/recipe.dart';
import 'package:recipy_frontend/pages/recipe_detail/recipe_detail_page.dart';

class RecipeCardWidget extends StatelessWidget {
  final Recipe recipe;

  const RecipeCardWidget({Key? key, required this.recipe}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return TextButton(
      onPressed: () => Navigator.push(
        context,
        MaterialPageRoute(
            builder: (context) => RecipeDetailPage(recipeId: recipe.id)),
      ),
      child: Container(
        width: 300,
        margin: const EdgeInsets.all(10),
        padding: const EdgeInsets.all(20),
        decoration: BoxDecoration(
            border: Border.all(color: Colors.blueAccent),
            borderRadius: const BorderRadius.all(Radius.circular(4))),
        child: Column(
          children: [
            Text(recipe.name),
            Text(DateFormat.Hm().format(recipe.created)),
            Text(DateFormat.yMMMd().format(recipe.created)),
          ],
        ),
      ),
    );
  }
}
