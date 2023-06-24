import 'package:beamer/beamer.dart';
import 'package:flutter/material.dart';
import 'package:path/path.dart';
import 'package:recipy_frontend/locations/home_location.dart';
import 'package:recipy_frontend/locations/user_location.dart';
import 'package:recipy_frontend/pages/app_screen/app_screen_page.dart';

class RecipyRoute {
  // home
  static const String homePrefix = "/home";
  static const String homeRecipeOverview = "/home/overview";
  static const String homeRecipeDetails = "/home/recipe/:recipeId";
  static const String homeSettings = "/home/settings";
  static const String ingredients = "/home/settings/ingredients";
  static const String ingredientUnits = "/home/settings/ingredientUnits";

  static const String userPrefix = "/user";
  static const String userRegistration = "/user/login/registration";
  static const String userLogin = "/user/login";
  static const String userMyRecipes = "/user/myRecipes";
  static const String userRecipeDetails = "/user/myRecipes/recipe/:recipeId";
  static const String userProfile = "/user/profile";

  static String recipeDetailsRouteForId(BuildContext context, String recipeId) {
    final currentLocation =
        Beamer.of(context).currentBeamLocation.state.routeInformation.location!;
    if (currentLocation.startsWith(RecipyRoute.homePrefix)) {
      return homeRecipeDetails.replaceFirst(":recipeId", recipeId);
    } else {
      return userRecipeDetails.replaceFirst(":recipeId", recipeId);
    }
  }
}

final recipyBeamerLocations = [
  BeamerDelegate(
    initialPath: RecipyRoute.homeRecipeOverview,
    locationBuilder: (routeInformation, _) {
      BeamLocation result = NotFound(path: routeInformation.location!);
      if (routeInformation.location!.contains(RecipyRoute.homePrefix)) {
        result = HomeLocation(routeInformation);
      }
      return result;
    },
  ),
  BeamerDelegate(
    initialPath: RecipyRoute.userMyRecipes,
    locationBuilder: (routeInformation, _) {
      BeamLocation result = NotFound(path: routeInformation.location!);
      if (routeInformation.location!.contains(RecipyRoute.userPrefix)) {
        result = UserLocation(routeInformation);
      }
      return result;
    },
  )
];

var routerDelegate = BeamerDelegate(
  initialPath: RecipyRoute.homeRecipeOverview,
  locationBuilder: RoutesLocationBuilder(
    routes: {
      '*': (context, state, data) => const AppScreenPage(),
    },
  ),
);
