import 'package:beamer/beamer.dart';
import 'package:flutter/material.dart';
import 'package:recipy_frontend/config/routes_config.dart';
import 'package:recipy_frontend/pages/ingredient_units/ingredient_units_page.dart';
import 'package:recipy_frontend/pages/ingredients/ingredients_page.dart';
import 'package:recipy_frontend/pages/recipe_detail/recipe_detail_page.dart';
import 'package:recipy_frontend/pages/recipe_overview/recipe_overview_page.dart';
import 'package:recipy_frontend/pages/settings/settings_page.dart';

class HomeLocation extends BeamLocation<BeamState> {
  HomeLocation(RouteInformation routeInformation) : super(routeInformation);

  @override
  List<String> get pathPatterns => [
        RecipyRoute.homeRecipeOverview,
        RecipyRoute.homeRecipeDetails,
        RecipyRoute.homeSettings,
        RecipyRoute.ingredientUnits,
        RecipyRoute.ingredients,
      ];

  @override
  List<BeamPage> buildPages(BuildContext context, BeamState state) {
    print("Location: ${state.routeInformation.location}");
    final pages = [
      const BeamPage(
        key: ValueKey('recipe_overview'),
        title: 'RecipeOverview',
        type: BeamPageType.noTransition,
        child: RecipeOverviewPage(),
      ),
    ];
    if (state.pathParameters.containsKey('recipeId')) {
      print(
          "build recipeDetailPage for recipe: ${state.pathParameters['recipeId']}");
      pages.add(
        BeamPage(
          key: ValueKey('recipe-${state.pathParameters['recipeId']}'),
          title: "recipe-detail-${state.pathParameters['recipeId']}",
          child: RecipeDetailPage(
            recipeId: state.pathParameters['recipeId']!,
          ),
        ),
      );
    }
    if (state.routeInformation.location != null) {
      if (state.routeInformation.location!
          .startsWith(RecipyRoute.homeSettings)) {
        pages.add(const BeamPage(
          key: ValueKey('home-settings'),
          title: "Settings",
          child: SettingsPage(),
        ));
        if (state.routeInformation.location == RecipyRoute.ingredients) {
          pages.add(const BeamPage(
            key: ValueKey('home-settings-ingredients'),
            title: "Ingredients",
            child: IngredientsPage(),
          ));
        } else if (state.routeInformation.location ==
            RecipyRoute.ingredientUnits) {
          pages.add(const BeamPage(
            key: ValueKey('home-settings-ingredientUnits'),
            title: "IngredientUnits",
            child: IngredientUnitsPage(),
          ));
        }
      }
    }

    return pages;
  }
}
