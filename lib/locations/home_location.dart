import 'package:beamer/beamer.dart';
import 'package:flutter/material.dart';
import 'package:logging/logging.dart';
import 'package:recipy_frontend/config/routes_config.dart';
import 'package:recipy_frontend/pages/ingredient_units/ingredient_units_page.dart';
import 'package:recipy_frontend/pages/ingredients/ingredients_page.dart';
import 'package:recipy_frontend/pages/recipe_detail/recipe_detail_page.dart';
import 'package:recipy_frontend/pages/recipe_overview/recipe_overview_page.dart';
import 'package:recipy_frontend/pages/settings/settings_page.dart';
import 'package:easy_localization/easy_localization.dart';

class HomeLocation extends BeamLocation<BeamState> {
  static final log = Logger("HomeLocation");

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
    log.info(
        "Switching to location=${state.routeInformation.location} with parameters=${state.pathParameters}.");
    final pages = [
      BeamPage(
        key: const ValueKey('recipe_overview'),
        title: "recipe_overview.title".tr(),
        type: BeamPageType.noTransition,
        child: const RecipeOverviewPage(),
      ),
    ];
    if (state.pathParameters.containsKey('recipeId')) {
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
        pages.add(BeamPage(
          key: const ValueKey('home-settings'),
          title: "settings.title".tr(),
          child: const SettingsPage(),
        ));
        if (state.routeInformation.location == RecipyRoute.ingredients) {
          pages.add(BeamPage(
            key: const ValueKey('home-settings-ingredients'),
            title: "ingredients.title".tr(),
            child: const IngredientsPage(),
          ));
        } else if (state.routeInformation.location ==
            RecipyRoute.ingredientUnits) {
          pages.add(BeamPage(
            key: const ValueKey('home-settings-ingredientUnits'),
            title: "ingredient_units.title".tr(),
            child: const IngredientUnitsPage(),
          ));
        }
      }
    }

    return pages;
  }
}
