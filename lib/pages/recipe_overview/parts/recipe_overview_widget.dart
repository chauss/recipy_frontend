import 'package:flutter/material.dart';
import 'package:intl/intl.dart';
import 'package:recipy_frontend/models/recipe_overview.dart';

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
        child: Container(
          width: 300,
          padding: const EdgeInsets.all(20),
          decoration: BoxDecoration(
              border: Border.all(
                  color: Theme.of(context).colorScheme.primaryContainer),
              borderRadius: const BorderRadius.all(Radius.circular(4))),
          child: Column(
            children: [
              Text(recipeOverview.name,
                  style: Theme.of(context).textTheme.headlineSmall),
              Text(DateFormat.Hm().format(recipeOverview.created)),
              Text(DateFormat.yMMMd().format(recipeOverview.created)),
            ],
          ),
        ),
      ),
    );
  }
}
