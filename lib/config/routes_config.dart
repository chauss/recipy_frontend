import 'package:beamer/beamer.dart';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:logging/logging.dart';
import 'package:recipy_frontend/helpers/providers.dart';
import 'package:recipy_frontend/locations/home_location.dart';
import 'package:recipy_frontend/locations/user_location.dart';
import 'package:recipy_frontend/pages/app_screen/app_screen_page.dart';

final _log = Logger("routes_config");

class RecipyRoute {
  // home
  static const String homePrefix = "/home";
  static const String homeRecipeOverview = "/home/overview";
  static const String homeRecipeDetails = "/home/recipe/:recipeId";
  static const String homeSettings = "/home/settings";
  static const String ingredients = "/home/settings/ingredients";
  static const String ingredientUnits = "/home/settings/ingredientUnits";

  static const String login = "/login";
  static const String registration = "/login/registration";

  // user
  static const String userPrefix = "/user";
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
      if (routeInformation.location!.startsWith(RecipyRoute.homePrefix)) {
        return HomeLocation(routeInformation);
      }
      return NotFound(path: routeInformation.location!);
    },
  ),
  BeamerDelegate(
    initialPath: RecipyRoute.userProfile,
    locationBuilder: (routeInformation, _) {
      if (routeInformation.location!.startsWith(RecipyRoute.userPrefix) ||
          routeInformation.location!.startsWith(RecipyRoute.login)) {
        return UserLocation(routeInformation);
      }
      return NotFound(path: routeInformation.location!);
    },
  )
];

BeamerDelegate createDelegte(ProviderContainer container) => BeamerDelegate(
      initialPath: RecipyRoute.homeRecipeOverview,
      locationBuilder: RoutesLocationBuilder(
        routes: {
          '*': (context, state, data) => const AppScreenPage(),
        },
      ),
      guards: [
        BeamGuard(
            pathPatterns: ['${RecipyRoute.userPrefix}/**'],
            check: (_, __) => container
                .read(userManagementRepositoryProvider)
                .isUserLoggedIn(),
            beamToNamed: (origin, target) {
              try {
                _log.info(
                    "Guarding route ${target.history.first.routeInformation.location}");
              } catch (e) {
                _log.warning("Tried to log guarded route but got error: $e");
              }

              return RecipyRoute.login;
            })
      ],
    );
