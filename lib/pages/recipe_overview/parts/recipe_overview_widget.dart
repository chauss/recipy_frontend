import 'package:flutter/material.dart';
import 'package:intl/intl.dart';
import 'package:recipy_frontend/models/recipe_overview.dart';
import 'package:recipy_frontend/pages/recipe_detail/parts/recipe_images/recipe_images_widget.dart';

class RecipeOverviewWidget extends StatelessWidget {
  final RecipeOverview recipeOverview;
  final Function()? onClick;

  const RecipeOverviewWidget(
      {Key? key, required this.recipeOverview, this.onClick})
      : super(key: key);

  @override
  Widget build(BuildContext context) {
    return TextButton(
      onPressed: onClick,
      child: Card(
        shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(8)),
        clipBehavior: Clip.hardEdge,
        elevation: 8,
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.stretch,
          children: [
            Expanded(
              flex: 2,
              child: RecipeImagesWidget(
                recipeId: recipeOverview.id,
                onlyDisplayTitleImage: true,
              ),
            ),
            Flexible(
              flex: 1,
              child: Padding(
                padding: const EdgeInsets.only(top: 6),
                child: Center(
                  child: Text(
                    recipeOverview.name,
                    style: Theme.of(context).textTheme.titleLarge,
                  ),
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }
}
