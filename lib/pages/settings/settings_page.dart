import 'package:beamer/beamer.dart';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:recipy_frontend/config/routes_config.dart';
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
          _buildGoToPageTile(context, "IngredientUnits",
              RecipyRoute.ingredientUnits), // TODO Label translation
          _buildGoToPageTile(context, "Ingredients",
              RecipyRoute.ingredients), // TODO Label translation
        ],
      ),
    );
  }

  Widget _buildGoToPageTile(BuildContext context, String title, String route) {
    return InkWell(
      onTap: () => Beamer.of(context).beamToNamed(route),
      child: Padding(
        padding: const EdgeInsets.symmetric(horizontal: 24),
        child: Container(
          height: 50,
          width: double.infinity,
          decoration: BoxDecoration(
            border: Border(
              top: BorderSide(color: Colors.white.withOpacity(0.4), width: 1),
            ),
          ),
          child: Row(
            crossAxisAlignment: CrossAxisAlignment.center,
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              Text(
                title,
                style: Theme.of(context).textTheme.bodyMedium,
              ),
              const Icon(Icons.arrow_forward_ios),
            ],
          ),
        ),
      ),
    );
  }

  Widget _buildLoginTile() {
    return const SizedBox(
      height: 60,
      width: double.infinity,
      child: Text("Login"), // TODO Label translation
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
