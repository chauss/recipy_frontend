import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:recipy_frontend/helpers/providers.dart';
import 'package:recipy_frontend/pages/settings/settings_model.dart';
import 'package:recipy_frontend/widgets/recipy_app_bar.dart';
import 'package:easy_localization/easy_localization.dart';

class SettingsPage extends ConsumerWidget {
  const SettingsPage({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    SettingsController controller =
        ref.read(settingsControllerProvider.notifier);

    SettingsModel model = ref.watch(settingsControllerProvider);

    return Scaffold(
      appBar: RecipyAppBar(title: "settings.title".tr()),
      body: buildBody(context, model, controller),
    );
  }

  Widget buildBody(
    BuildContext context,
    SettingsModel model,
    SettingsController controller,
  ) {
    return Padding(
      padding: const EdgeInsets.symmetric(vertical: 24),
      child: ListView(
        children: [
          model.username == null
              ? _buildLoginTile()
              : _buildProfileTile(model.username!),
        ],
      ),
    );
  }

  Widget _buildLoginTile() {
    return const SizedBox(
      height: 60,
      width: double.infinity,
      child: Text("Login"),
    );
  }

  Widget _buildProfileTile(String username) {
    return SizedBox(
      height: 60,
      width: double.infinity,
      child: Row(
        children: [
          Container(height: 40, width: 40, color: Colors.red),
          Text(username)
        ],
      ),
    );
  }
}

abstract class SettingsController extends StateNotifier<SettingsModel> {
  SettingsController(SettingsModel state) : super(state);
}
