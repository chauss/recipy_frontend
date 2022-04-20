import 'package:flutter/material.dart';
import 'package:flutter/scheduler.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:recipy_frontend/helpers/providers.dart';
import 'package:recipy_frontend/models/ingredient_usage.dart';
import 'package:recipy_frontend/pages/recipe_detail/parts/delete_ingredient_usage_request.dart';
import 'package:recipy_frontend/pages/recipe_detail/parts/delete_recipe_request.dart';
import 'package:recipy_frontend/pages/recipe_detail/parts/edit_ingredient_usage_widget.dart';
import 'package:recipy_frontend/pages/recipe_detail/parts/editable_ingredient_usage.dart';
import 'package:recipy_frontend/pages/recipe_detail/recipe_detail_model.dart';
import 'package:recipy_frontend/pages/recipe_detail/parts/ingredient_usage_widget.dart';
import 'package:recipy_frontend/widgets/info_dialog.dart';
import 'package:recipy_frontend/widgets/process_indicator.dart';
import 'package:recipy_frontend/widgets/yes_no_dialog.dart';

class RecipeDetailPage extends ConsumerWidget {
  final String recipeId;

  const RecipeDetailPage({Key? key, required this.recipeId}) : super(key: key);

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    RecipeDetailController controller =
        ref.read(recipeDetailControllerProvider(recipeId).notifier);

    RecipeDetailModel model =
        ref.watch(recipeDetailControllerProvider(recipeId));

    return Scaffold(
      appBar: AppBar(
        title: Text(model.recipe?.name ?? ""),
        actions: buildAppBarActions(controller, model),
      ),
      body: buildBody(controller, model, context),
    );
  }

  Widget buildBody(RecipeDetailController controller, RecipeDetailModel model,
      BuildContext context) {
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

    return ListView(
      padding: const EdgeInsets.only(left: 24, right: 24, top: 32),
      children: [
        ...buildIngredientUsages(controller, model),
        model.isEditMode
            ? ElevatedButton(
                onPressed: controller.addNewIngredientUsage,
                child: const Icon(Icons.add),
                style: ButtonStyle(
                  fixedSize: MaterialStateProperty.all(const Size.square(50)),
                  backgroundColor: MaterialStateProperty.all(Colors.blue),
                  foregroundColor: MaterialStateProperty.all(Colors.white),
                  shape: MaterialStateProperty.all<CircleBorder>(
                    const CircleBorder(
                        side: BorderSide(color: Colors.blueGrey)),
                  ),
                ),
              )
            : Container(),
      ],
    );
  }

  List<Widget> buildIngredientUsages(
      RecipeDetailController controller, RecipeDetailModel model) {
    if (model.recipe == null) {
      return [Container()];
    }

    if (model.isEditMode) {
      return model.editableUsages
          .map((editableUsage) =>
              buildEditableIngredientUsage(controller, model, editableUsage))
          .toList();
    }
    return model.recipe!.ingredientUsages
        .map((usage) => buildIngredientUsage(model, usage))
        .toList();
  }

  Widget buildEditableIngredientUsage(
    RecipeDetailController controller,
    RecipeDetailModel model,
    EditableIngredientUsage usage,
  ) {
    return Container(
        margin: const EdgeInsets.only(bottom: 12),
        child: EditIngredientUsageWidget(
          usage: usage,
          onAmountChanged: (amount) =>
              controller.updateUsageAmount(usage, amount),
          onIngredientChanged: (ingredientId) =>
              controller.updateUsageIngredient(usage, ingredientId),
          onIngredientUnitChanged: (ingredientUsageId) =>
              controller.updateUsageIngredientUnit(usage, ingredientUsageId),
          onDeleteIngredientUsageCallback: () =>
              controller.deleteIngredientUsage(DeleteIngredientUsageRequest(
            ingredientUsage: usage,
          )),
        ));
  }

  Widget buildIngredientUsage(RecipeDetailModel model, IngredientUsage usage) {
    return Container(
      margin: const EdgeInsets.only(bottom: 12),
      child: IngredientUsageWidget(usage: usage),
    );
  }

  List<Widget> buildAppBarActions(
    RecipeDetailController controller,
    RecipeDetailModel model,
  ) {
    if (model.isEditMode) {
      return [
        Padding(
          padding: const EdgeInsets.only(right: 8),
          child: IconButton(
            onPressed: controller.saveChanges,
            icon: const Icon(Icons.check),
          ),
        )
      ];
    }
    return [
      PopupMenuButton(
        icon: const Icon(Icons.more_vert),
        // color: Colors.blue,
        itemBuilder: (context) => [
          PopupMenuItem<Function>(
            value: controller.enterEditMode,
            child: Row(
              children: const [
                Icon(Icons.edit, color: Colors.black),
                SizedBox(width: 12),
                Text(
                  "Bearbeiten",
                ),
              ],
            ),
          ),
          PopupMenuItem<Function>(
            value: () => showDeleteRecipeDialog(context, controller),
            child: Row(
              children: [
                Image.asset(
                  "assets/icons/trash.png",
                  width: 24,
                ),
                const SizedBox(width: 12),
                const Text(
                  "Löschen",
                ),
              ],
            ),
          ),
        ],
        onSelected: (Function action) => action(),
      ),
    ];
  }

  void showDeleteRecipeDialog(
    BuildContext context,
    RecipeDetailController controller,
  ) {
    var dialog = YesNoDialog(
        context: context,
        title: "Rezept löschen",
        info:
            "Bist du dir sicher, dass du das Rezept komplett löschen möchtest?",
        onYesCallback: () async {
          var success = await controller
              .deleteRecipe(DeleteRecipeRequest(recipeId: recipeId));
          if (success) {
            Navigator.pop(context);
          }
        });
    dialog.show();
  }
}

abstract class RecipeDetailController extends StateNotifier<RecipeDetailModel> {
  RecipeDetailController(RecipeDetailModel state) : super(state);

  void addNewIngredientUsage();
  void enterEditMode();
  Future<void> saveChanges();

  void updateUsageAmount(EditableIngredientUsage usage, double amount);
  void updateUsageIngredient(
      EditableIngredientUsage usage, String? ingredientId);
  void updateUsageIngredientUnit(
      EditableIngredientUsage usage, String? ingredientUnitId);
  void deleteIngredientUsage(DeleteIngredientUsageRequest request);
  Future<bool> deleteRecipe(DeleteRecipeRequest request);

  void dismissError();
}
