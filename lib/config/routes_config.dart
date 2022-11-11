import 'package:beamer/beamer.dart';
import 'package:recipy_frontend/pages/ingredient_units/ingredient_units_page.dart';
import 'package:recipy_frontend/pages/ingredients/ingredients_page.dart';
import 'package:recipy_frontend/pages/user/login/login_page.dart';
import 'package:recipy_frontend/pages/recipe_detail/recipe_detail_page.dart';
import 'package:recipy_frontend/pages/recipe_overview/recipe_overview_page.dart';

import '../pages/user/registration/registration_page.dart';

class RecipyRoute {
  static const String registration = "/registration";
  static const String login = "/login";
  static const String recipes = "/recipes";
  static const String recipeDetails = "/recipes/:recipeId";
  static const String ingredients = "/ingredients";
  static const String ingredientUnits = "/ingredientUnits";

  static String recipeDetailsRouteForId(String recipeId) {
    return recipeDetails.replaceFirst(":recipeId", recipeId);
  }
}

final recipyRouterDelegate = BeamerDelegate(
  initialPath: RecipyRoute.recipes,
  locationBuilder: RoutesLocationBuilder(
    routes: {
      RecipyRoute.registration: (context, state, data) => RegistrationPage(),
      RecipyRoute.login: (context, state, data) => LoginPage(),
      RecipyRoute.recipes: (context, state, data) => const RecipeOverviewPage(),
      RecipyRoute.recipeDetails: (context, state, data) {
        final recipeId = state.pathParameters['recipeId']!;
        return RecipeDetailPage(recipeId: recipeId);
      },
      RecipyRoute.ingredients: (context, state, data) =>
          const IngredientsPage(),
      RecipyRoute.ingredientUnits: (context, state, data) =>
          const IngredientUnitsPage()
    },
  ),
);
