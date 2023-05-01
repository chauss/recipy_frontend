import 'package:beamer/beamer.dart';
import 'package:flutter/material.dart';
import 'package:recipy_frontend/pages/recipe_detail/recipe_detail_page.dart';
import 'package:recipy_frontend/pages/recipe_overview/recipe_overview_page.dart';

class RecipeLocation extends BeamLocation<BeamState> {
  RecipeLocation(RouteInformation routeInformation) : super(routeInformation);

  @override
  List<String> get pathPatterns => ['/home/recipes/:recipeId'];

  @override
  List<BeamPage> buildPages(BuildContext context, BeamState state) {
    final pages = [
      const BeamPage(
        key: ValueKey('recipe_overview'),
        title: 'RecipeOverview',
        type: BeamPageType.noTransition,
        child: RecipeOverviewPage(),
      ),
      if (state.pathParameters.containsKey('recipeId'))
        BeamPage(
          key: ValueKey('recipe-${state.pathParameters['recipeId']}'),
          title: "recipe-detail-${state.pathParameters['recipeId']}",
          child: RecipeDetailPage(
            recipeId: state.pathParameters['recipeId']!,
          ),
        ),
    ];

    return pages;
  }
}
