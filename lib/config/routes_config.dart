import 'package:beamer/beamer.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:recipy_frontend/helpers/providers.dart';
import 'package:recipy_frontend/locations/home_location.dart';
import 'package:recipy_frontend/locations/user_location.dart';
import 'package:recipy_frontend/pages/app_screen/app_screen_page.dart';

class RecipyRoute {
  // home
  static const String homeRecipeOverview = "/home/overview";
  static const String homeRecipeDetails = "/home/recipe/:recipeId";
  static const String homeSettings = "/home/settings";
  static const String ingredients = "/home/settings/ingredients";
  static const String ingredientUnits = "/home/settings/ingredientUnits";

  static const String registration = "/user/registration";
  static const String login = "/user/login";
  static const String userProfile = "/user/profile";

  static String recipeDetailsRouteForId(String recipeId) {
    return homeRecipeDetails.replaceFirst(":recipeId", recipeId);
  }
}

final recipyBeamerLocations = [
  BeamerDelegate(
    initialPath: RecipyRoute.homeRecipeOverview,
    locationBuilder: (routeInformation, _) {
      BeamLocation result = NotFound(path: routeInformation.location!);
      if (routeInformation.location!.contains('/home')) {
        result = HomeLocation(routeInformation);
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
  initialPath: RecipyRoute.homeRecipeOverview,
  locationBuilder: RoutesLocationBuilder(
    routes: {
      '*': (context, state, data) => const AppScreenPage(),
    },
  ),
);
