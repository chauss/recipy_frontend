import 'package:beamer/beamer.dart';
import 'package:flutter/material.dart';
import 'package:recipy_frontend/config/routes_config.dart';
import 'package:recipy_frontend/pages/user/login/login_page.dart';
import 'package:recipy_frontend/pages/user/profile/profile_page.dart';
import 'package:recipy_frontend/pages/user/registration/registration_page.dart';

class UserLocation extends BeamLocation<BeamState> {
  UserLocation(RouteInformation routeInformation) : super(routeInformation);

  @override
  List<String> get pathPatterns => [
        RecipyRoute.login,
        RecipyRoute.userProfile,
        RecipyRoute.registration,
      ];

  @override
  List<BeamPage> buildPages(BuildContext context, BeamState state) {
    List<BeamPage> beamPages = [];
    if (state.routeInformation.location!.contains("login")) {
      beamPages.add(BeamPage(
        key: const ValueKey('user-login'),
        title: 'User Login',
        type: BeamPageType.noTransition,
        child: LoginPage(),
      ));
      if (state.routeInformation.location!.contains("registration")) {
        beamPages.add(BeamPage(
          key: const ValueKey('user-registration'),
          title: 'User Registration',
          type: BeamPageType.noTransition,
          child: RegistrationPage(),
        ));
      }
    } else {
      beamPages.add(
        const BeamPage(
          key: ValueKey('user-profile'),
          title: 'UserProfile',
          type: BeamPageType.noTransition,
          child: ProfilePage(),
        ),
      );
    }
    return beamPages;
  }
}
