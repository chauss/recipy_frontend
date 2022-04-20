import 'package:flutter/material.dart';
import 'package:flutter/scheduler.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:recipy_frontend/helpers/providers.dart';
import 'package:recipy_frontend/pages/recipe_detail/recipe_detail_page.dart';
import 'package:recipy_frontend/pages/recipe_overview/parts/add_recipe_request.dart';
import 'package:recipy_frontend/pages/recipe_overview/recipe_overview_model.dart';
import 'package:recipy_frontend/widgets/info_dialog.dart';
import 'package:recipy_frontend/widgets/nav_drawer.dart';
import 'package:recipy_frontend/widgets/process_indicator.dart';
import 'package:recipy_frontend/pages/recipe_overview/parts/recipe_overview_widget.dart';
import 'package:recipy_frontend/widgets/recipy_app_bar.dart';
import 'package:recipy_frontend/widgets/text_field_dialog.dart';

class RecipeOverviewPage extends ConsumerWidget {
  const RecipeOverviewPage({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    RecipeOverviewController controller =
        ref.read(recipeOverviewControllerProvider.notifier);

    RecipeOverviewModel model = ref.watch(recipeOverviewControllerProvider);

    return Scaffold(
      appBar: const RecipyAppBar(title: "Rezeptübersicht"),
      drawer: const NavDrawer(),
      body: buildBody(context, model, controller),
      floatingActionButton: FloatingActionButton(
        onPressed: () async {
          var dialog = TextfieldDialog(
              context: context,
              title: "Neues Rezept",
              textfieldHint: "Rezeptname");
          await dialog.show();
          if (!dialog.canceled && dialog.value != "") {
            controller.addRecipe(AddRecipeRequest(name: dialog.value));
          }
        },
        tooltip: 'Rezept hinzufügen',
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

    if (model.error != null) {
      var dialog = InfoDialog(
        context: context,
        title: "Fehler",
        info: model.error!,
      );
      SchedulerBinding.instance!.addPostFrameCallback((_) {
        dialog.show().then((_) => controller.dismissError());
      });
    }
    return RefreshIndicator(
      onRefresh: controller.refetchRecipes,
      child: ListView(
        children: model.recipeOverviews
            .map((recipeOverview) => RecipeOverviewWidget(
                  recipeOverview: recipeOverview,
                  onClick: () => Navigator.push(
                    context,
                    MaterialPageRoute(
                      builder: (context) =>
                          RecipeDetailPage(recipeId: recipeOverview.id),
                    ),
                  ).then((value) => controller.refetchRecipes()),
                ))
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
