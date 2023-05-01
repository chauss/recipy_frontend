import 'package:beamer/beamer.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:recipy_frontend/helpers/providers.dart';
import 'package:recipy_frontend/locations/recipe_location.dart';
import 'package:recipy_frontend/locations/user_location.dart';
import 'package:recipy_frontend/pages/home/home_page.dart';
import 'package:recipy_frontend/pages/ingredient_units/ingredient_units_page.dart';
import 'package:recipy_frontend/pages/ingredients/ingredients_page.dart';
import 'package:recipy_frontend/pages/user/login/login_page.dart';
import 'package:recipy_frontend/pages/recipe_detail/recipe_detail_page.dart';
import 'package:recipy_frontend/pages/recipe_overview/recipe_overview_page.dart';
import 'package:recipy_frontend/pages/user/profile/profile_page.dart';

import '../pages/user/registration/registration_page.dart';

class RecipyRoute {
  static const String registration = "/user/registration";
  static const String login = "/user/login";
  static const String userProfile = "/user/profile";
  static const String recipes = "/recipes";
  static const String recipeDetails = "/recipes/:recipeId";
  static const String ingredients = "/ingredients";
  static const String ingredientUnits = "/ingredientUnits";

  static String recipeDetailsRouteForId(String recipeId) {
    return recipeDetails.replaceFirst(":recipeId", recipeId);
  }
}

final recipyHomeBeamerLocations = [
  BeamerDelegate(
    initialPath: RecipyRoute.recipes,
    locationBuilder: (routeInformation, _) {
      BeamLocation result = NotFound(path: routeInformation.location!);
      if (routeInformation.location!.contains('/recipes')) {
        result = RecipeLocation(routeInformation);
      }
      return result;
    },
  ),
  BeamerDelegate(
      initialPath: RecipyRoute.userProfile,
      locationBuilder: (routeInformation, _) {
        BeamLocation result = NotFound(path: routeInformation.location!);
        if (routeInformation.location!.contains('/user')) {
          result = UserLocation(routeInformation);
        }
        return result;
      },
      guards: [
        BeamGuard(
          pathPatterns: [RecipyRoute.userProfile],
          guardNonMatching: false,
          check: (context, state) {
            var signedIn = ProviderContainer()
                .read(userManagementRepositoryProvider)
                .isUserLoggedIn();

            return signedIn;
          },
          beamToNamed: (origin, target) => RecipyRoute.login,
        ),
      ])
];

var routerDelegate = BeamerDelegate(
  initialPath: "/",
  locationBuilder: RoutesLocationBuilder(
    routes: {
      '*': (context, state, data) => const HomePage(),
    },
  ),
);
