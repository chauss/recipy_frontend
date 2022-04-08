import 'package:flutter/material.dart';
import 'package:recipy_frontend/models/ingredient_usage.dart';
import 'package:recipy_frontend/models/recipe.dart';
import 'package:recipy_frontend/widgets/ingredient_usage_widget.dart';

class RecipeDetailPage extends StatefulWidget {
  final Recipe recipe;

  const RecipeDetailPage({Key? key, required this.recipe}) : super(key: key);

  @override
  State<StatefulWidget> createState() => _RecipeDetailPageState();
}

class _RecipeDetailPageState extends State<RecipeDetailPage> {
  bool isEditMode = false;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text(widget.recipe.name),
        actions: [
          Padding(
            padding: const EdgeInsets.only(right: 8),
            child: IconButton(
              onPressed: () => setState(() => isEditMode = !isEditMode),
              icon: isEditMode
                  ? const Icon(Icons.edit_off)
                  : const Icon(Icons.edit),
            ),
          )
        ],
      ),
      body: ListView(
        padding: const EdgeInsets.only(left: 24, right: 24, top: 32),
        children: buildIngredientUsages(),
      ),
    );
  }

  List<Widget> buildIngredientUsages() {
    return widget.recipe.ingredientUsages
        .map((usage) => buildIngredientUsage(usage))
        .toList();
  }

  Widget buildIngredientUsage(IngredientUsage usage) {
    return Container(
      margin: const EdgeInsets.only(bottom: 12),
      child: IngredientUsageWidget(
        usage: usage,
        isEditMode: isEditMode,
      ),
    );
  }
}
