import 'package:flutter/material.dart';
import 'package:intl/intl.dart';
import 'package:recipy_frontend/models/recipe_overview.dart';
import 'package:recipy_frontend/pages/recipe_detail/recipe_detail_page.dart';

class RecipeOverviewWidget extends StatelessWidget {
  final RecipeOverview recipeOverview;

  const RecipeOverviewWidget({Key? key, required this.recipeOverview})
      : super(key: key);

  @override
  Widget build(BuildContext context) {
    return TextButton(
      onPressed: () => Navigator.push(
        context,
        MaterialPageRoute(
            builder: (context) =>
                RecipeDetailPage(recipeId: recipeOverview.id)),
      ),
      child: Container(
        width: 300,
        padding: const EdgeInsets.all(20),
        decoration: BoxDecoration(
            border: Border.all(color: Colors.blueAccent),
            borderRadius: const BorderRadius.all(Radius.circular(4))),
        child: Column(
          children: [
            Text(recipeOverview.name),
            Text(DateFormat.Hm().format(recipeOverview.created)),
            Text(DateFormat.yMMMd().format(recipeOverview.created)),
          ],
        ),
      ),
    );
  }
}
