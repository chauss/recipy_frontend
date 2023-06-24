import 'package:flutter/material.dart';
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
    return InkWell(
      onTap: onClick,
      child: Card(
        shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(8)),
        clipBehavior: Clip.hardEdge,
        elevation: 8,
        child: Stack(
          children: [
            RecipeImagesWidget(
              recipeId: recipeOverview.id,
              onlyDisplayTitleImage: true,
            ),
            Container(
              color: Colors.black.withOpacity(0.5),
            ),
            Center(
              child: Text(recipeOverview.name,
                  style: Theme.of(context).textTheme.titleLarge),
            ),
          ],
        ),
      ),
    );
  }
}
