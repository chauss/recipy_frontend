import 'package:beamer/beamer.dart';
import 'package:flutter/material.dart';
import 'package:logging/logging.dart';
import 'package:recipy_frontend/config/routes_config.dart';
import 'package:recipy_frontend/pages/recipe_detail/recipe_detail_page.dart';
import 'package:recipy_frontend/pages/user/login/login_page.dart';
import 'package:recipy_frontend/pages/user/my_recipes/my_recipes_page.dart';
import 'package:recipy_frontend/pages/user/profile/profile_page.dart';
import 'package:recipy_frontend/pages/user/registration/registration_page.dart';
import 'package:easy_localization/easy_localization.dart';

class UserLocation extends BeamLocation<BeamState> {
  static final log = Logger("UserLocation");

  UserLocation(RouteInformation routeInformation) : super(routeInformation);

  @override
  List<Pattern> get pathPatterns => [
        RecipyRoute.login,
        RecipyRoute.registration,
        RecipyRoute.userMyRecipes,
        RecipyRoute.userRecipeDetails,
        RecipyRoute.userProfile,
      ];

  @override
  List<BeamPage> buildPages(BuildContext context, BeamState state) {
    log.info(
        "Switching to location=${state.routeInformation.location} with parameters=${state.pathParameters}.");
    List<BeamPage> beamPages = [];
    if (state.routeInformation.location!.contains(RecipyRoute.login)) {
      beamPages.add(BeamPage(
        key: const ValueKey('user-login'),
        title: 'user.login.title'.tr(),
        type: BeamPageType.noTransition,
        child: LoginPage(),
      ));
      if (state.routeInformation.location!.contains(RecipyRoute.registration)) {
        beamPages.add(BeamPage(
          key: const ValueKey('user-registration'),
          title: 'user.registration.title'.tr(),
          type: BeamPageType.noTransition,
          child: RegistrationPage(),
        ));
      }
    } else {
      beamPages.add(BeamPage(
        key: const ValueKey('user-my-recipes'),
        title: 'user.my_recipes.title'.tr(),
        type: BeamPageType.noTransition,
        child: const MyRecipesPage(),
      ));
      if (state.pathParameters.containsKey('recipeId')) {
        beamPages.add(BeamPage(
          key: ValueKey('recipe-${state.pathParameters['recipeId']}'),
          // TODO set nice name for tab
          title: "recipe-detail-${state.pathParameters['recipeId']}",
          child: RecipeDetailPage(
            recipeId: state.pathParameters['recipeId']!,
          ),
        ));
      }
      if (state.routeInformation.location!.contains(RecipyRoute.userProfile)) {
        beamPages.add(BeamPage(
          key: const ValueKey('user-profile'),
          title: 'user.profile.title'.tr(),
          type: BeamPageType.noTransition,
          child: const ProfilePage(),
        ));
      }
    }
    return beamPages;
  }
}
