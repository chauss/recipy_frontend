import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:recipy_frontend/helpers/providers.dart';
import 'package:recipy_frontend/pages/recipe_overview/add_recipe_request.dart';
import 'package:recipy_frontend/pages/recipe_overview/recipe_overview_model.dart';
import 'package:recipy_frontend/widgets/nav_drawer.dart';
import 'package:recipy_frontend/widgets/process_indicator.dart';
import 'package:recipy_frontend/pages/recipe_overview/recipe_widget.dart';
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
      body: getBody(model),
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

  Widget getBody(RecipeOverviewModel model) {
    if (model.isLoading) {
      return const ProcessIndicator();
    } else if (model.error != null) {
      return Text(model.error!);
    } else {
      return ListView(
        children: model.recipes
            .map((recipe) => RecipeCardWidget(recipe: recipe))
            .toList(),
      );
    }
  }
}

abstract class RecipeOverviewController
    extends StateNotifier<RecipeOverviewModel> {
  RecipeOverviewController(RecipeOverviewModel state) : super(state);

  Future<void> addRecipe(AddRecipeRequest request);
}
