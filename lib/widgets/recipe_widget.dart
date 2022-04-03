import 'package:flutter/material.dart';
import 'package:recipy_frontend/models/recipe.dart';

class RecipeWidget extends StatelessWidget {
  final Recipe recipe;

  const RecipeWidget({Key? key, required this.recipe}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Container(
        width: 200,
        margin: const EdgeInsets.all(10),
        padding: const EdgeInsets.all(20),
        decoration: BoxDecoration(
            border: Border.all(color: Colors.blueAccent),
            borderRadius: const BorderRadius.all(Radius.circular(4))),
        child: Text(recipe.name));
  }
}
