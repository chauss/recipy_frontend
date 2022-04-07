import 'package:flutter/material.dart';
import 'package:recipy_frontend/models/ingredient_usage.dart';
import 'package:recipy_frontend/models/recipe.dart';
import 'package:recipy_frontend/widgets/ingredient_usage_widget.dart';

class RecipeDetailPage extends StatelessWidget {
  final Recipe recipe;

  const RecipeDetailPage({Key? key, required this.recipe}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text(recipe.name),
      ),
      body: ListView(
        padding: const EdgeInsets.only(left: 24, right: 24, top: 32),
        children: buildIngredientUsages(),
      ),
    );
  }

  List<Widget> buildIngredientUsages() {
    return recipe.ingredientUsages
        .map((usage) => buildIngredientUsage(usage))
        .toList();
  }

  Widget buildIngredientUsage(IngredientUsage usage) {
    return Container(
      margin: const EdgeInsets.only(bottom: 12),
      child: IngredientUsageWidget(usage: usage),
    );
  }
}
