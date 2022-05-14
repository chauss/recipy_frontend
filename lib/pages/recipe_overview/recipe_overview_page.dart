import 'package:beamer/beamer.dart';
import 'package:flutter/material.dart';
import 'package:flutter/scheduler.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:recipy_frontend/config/routes_config.dart';
import 'package:recipy_frontend/helpers/providers.dart';
import 'package:recipy_frontend/pages/recipe_overview/parts/add_recipe_request.dart';
import 'package:recipy_frontend/pages/recipe_overview/recipe_overview_model.dart';
import 'package:recipy_frontend/widgets/info_dialog.dart';
import 'package:recipy_frontend/widgets/nav_drawer.dart';
import 'package:recipy_frontend/widgets/process_indicator.dart';
import 'package:recipy_frontend/pages/recipe_overview/parts/recipe_overview_widget.dart';
import 'package:recipy_frontend/widgets/recipy_app_bar.dart';
import 'package:recipy_frontend/widgets/text_field_dialog.dart';
import 'package:easy_localization/easy_localization.dart';

class RecipeOverviewPage extends ConsumerWidget {
  const RecipeOverviewPage({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    RecipeOverviewController controller =
        ref.read(recipeOverviewControllerProvider.notifier);

    RecipeOverviewModel model = ref.watch(recipeOverviewControllerProvider);

    return Scaffold(
      appBar: RecipyAppBar(title: "recipe_overview.title".tr()),
      drawer: NavDrawer(),
      body: buildBody(context, model, controller),
      floatingActionButton: FloatingActionButton(
        onPressed: () async {
          var dialog = TextfieldDialog(
              context: context,
              title: "recipe_overview.add.dialog.title".tr(),
              textfieldHint: "recipe_overview.add.dialog.textfield.hint".tr());
          await dialog.show();
          if (!dialog.canceled && dialog.value != "") {
            controller.addRecipe(AddRecipeRequest(name: dialog.value));
          }
        },
        tooltip: "recipe_overview.add.button.hint".tr(),
        child: const Icon(Icons.add),
      ),
    );
  }

  Widget buildBody(
    BuildContext context,
    RecipeOverviewModel model,
    RecipeOverviewController controller,
  ) {
    if (model.isLoading) {
      return const ProcessIndicator();
    }

    if (model.errorCode != null) {
      var dialog = InfoDialog(
        context: context,
        title: "common.error".tr(),
        info: "error_codes.${model.errorCode}".tr(),
      );
      SchedulerBinding.instance!.addPostFrameCallback((_) {
        dialog.show().then((_) => controller.dismissError());
      });
    }
    return RefreshIndicator(
      onRefresh: controller.refetchRecipes,
      child: ListView(
        children: model.recipeOverviews
            .map(
              (recipeOverview) => RecipeOverviewWidget(
                recipeOverview: recipeOverview,
                onClick: () => Beamer.of(context).beamToNamed(
                    RecipyRoute.recipeDetailsRouteForId(recipeOverview.id)),
              ),
            )
            .toList(),
      ),
    );
  }
}

abstract class RecipeOverviewController
    extends StateNotifier<RecipeOverviewModel> {
  RecipeOverviewController(RecipeOverviewModel state) : super(state);

  Future<void> refetchRecipes();
  Future<void> addRecipe(AddRecipeRequest request);
  void dismissError();
}
