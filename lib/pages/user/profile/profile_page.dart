import 'package:beamer/beamer.dart';
import 'package:flutter/material.dart';
import 'package:flutter/scheduler.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:recipy_frontend/config/routes_config.dart';
import 'package:recipy_frontend/helpers/providers.dart';
import 'package:recipy_frontend/widgets/process_indicator.dart';
import 'package:recipy_frontend/widgets/recipy_app_bar.dart';
import 'profile_model.dart';
import 'package:easy_localization/easy_localization.dart';

class ProfilePage extends ConsumerWidget {
  const ProfilePage({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    ProfileController controller = ref.read(profileControllerProvider.notifier);

    ProfileModel model = ref.watch(profileControllerProvider);

    return Scaffold(
      appBar: RecipyAppBar(title: "user.profile.title".tr()),
      body: buildBody(controller, model, context),
    );
  }

  Widget buildBody(
      ProfileController controller, ProfileModel model, BuildContext context) {
    if (model.successfullyLoggedOut) {
      SchedulerBinding.instance.addPostFrameCallback((_) {
        context.beamToNamed(RecipyRoute.login);
      });
    }
    return Container(
      margin: const EdgeInsets.only(top: 30, left: 24, right: 24),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.stretch,
        children: [
          const Text("user.profile.display_name").tr(),
          Text(
            model.displayName,
            textAlign: TextAlign.center,
          ),
          const SizedBox(height: 20),
          const Text("user.profile.email").tr(),
          Text(
            model.email,
            textAlign: TextAlign.center,
          ),
          const SizedBox(height: 20),
          const Text("user.profile.user_id").tr(),
          Text(
            model.userId,
            textAlign: TextAlign.center,
          ),
          const SizedBox(height: 40),
          TextButton(
            onPressed: () =>
                model.logoutInProgress ? null : controller.logoutUser(),
            child: Row(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                Text(
                  "user.profile.logout",
                  style: Theme.of(context)
                      .textTheme
                      .titleMedium
                      ?.copyWith(color: Theme.of(context).colorScheme.error),
                ).tr(),
                model.logoutInProgress
                    ? const Padding(
                        padding: EdgeInsets.only(left: 10),
                        child: ProcessIndicator(color: Colors.white, size: 20),
                      )
                    : Container()
              ],
            ),
          )
        ],
      ),
    );
  }
}

abstract class ProfileController extends StateNotifier<ProfileModel> {
  ProfileController(ProfileModel state) : super(state);

  Future<void> logoutUser();
}
