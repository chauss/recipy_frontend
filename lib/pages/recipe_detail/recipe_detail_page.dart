import 'package:flutter/material.dart';
import 'package:flutter/scheduler.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:recipy_frontend/helpers/providers.dart';
import 'package:recipy_frontend/models/ingredient_usage.dart';
import 'package:recipy_frontend/models/preparation_step.dart';
import 'package:recipy_frontend/pages/recipe_detail/parts/ingredient_usage/delete_ingredient_usage_request.dart';
import 'package:recipy_frontend/pages/recipe_detail/parts/preparation_step/delete_preparation_step_request.dart';
import 'package:recipy_frontend/pages/recipe_detail/parts/recipe/delete_recipe_request.dart';
import 'package:recipy_frontend/pages/recipe_detail/parts/ingredient_usage/edit_ingredient_usage_widget.dart';
import 'package:recipy_frontend/pages/recipe_detail/parts/preparation_step/edit_preparation_step_widget.dart';
import 'package:recipy_frontend/pages/recipe_detail/parts/ingredient_usage/editable_ingredient_usage.dart';
import 'package:recipy_frontend/pages/recipe_detail/parts/preparation_step/editable_preparation_step.dart';
import 'package:recipy_frontend/pages/recipe_detail/parts/preparation_step/preparation_step_widget.dart';
import 'package:recipy_frontend/pages/recipe_detail/recipe_detail_model.dart';
import 'package:recipy_frontend/pages/recipe_detail/parts/ingredient_usage/ingredient_usage_widget.dart';
import 'package:recipy_frontend/widgets/info_dialog.dart';
import 'package:recipy_frontend/widgets/process_indicator.dart';
import 'package:recipy_frontend/widgets/yes_no_dialog.dart';
import 'package:easy_localization/easy_localization.dart';

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
        actions: buildAppBarActions(context, controller, model),
      ),
      body: buildBody(controller, model, context),
    );
  }

  Widget buildBody(RecipeDetailController controller, RecipeDetailModel model,
      BuildContext context) {
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

    return ListView(
      padding: const EdgeInsets.only(left: 24, right: 24, top: 32),
      children: [
        Text(
          "recipe_details.heading.ingredients",
          style: Theme.of(context).textTheme.headline5,
        ).tr(),
        ...buildIngredientUsages(controller, model),
        model.isEditMode
            ? Padding(
                padding: const EdgeInsets.only(bottom: 50),
                child: buildAddUsageButton(controller, context),
              )
            : Container(),
        Text(
          "recipe_details.heading.preparation",
          style: Theme.of(context).textTheme.headline5,
        ).tr(),
        ...buildPreparationSteps(controller, model),
        model.isEditMode
            ? Padding(
                padding: const EdgeInsets.only(bottom: 50),
                child: buildAddStepButton(controller, context),
              )
            : Container(),
      ],
    );
  }

  ElevatedButton buildAddUsageButton(
      RecipeDetailController controller, BuildContext context) {
    return ElevatedButton(
      onPressed: controller.addNewIngredientUsage,
      child: const Icon(Icons.add),
      style: ButtonStyle(
        fixedSize: MaterialStateProperty.all(const Size.square(50)),
        shape: MaterialStateProperty.all<CircleBorder>(
          const CircleBorder(
            side: BorderSide(color: Colors.transparent),
          ),
        ),
      ),
    );
  }

  ElevatedButton buildAddStepButton(
      RecipeDetailController controller, BuildContext context) {
    return ElevatedButton(
      onPressed: controller.addNewPreparationStep,
      child: const Icon(Icons.add),
      style: ButtonStyle(
        fixedSize: MaterialStateProperty.all(const Size.square(50)),
        shape: MaterialStateProperty.all<CircleBorder>(
          const CircleBorder(
            side: BorderSide(color: Colors.transparent),
          ),
        ),
      ),
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
        .map((usage) => buildIngredientUsage(usage))
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
        onDeleteIngredientUsageCallback: () => controller.deleteIngredientUsage(
          DeleteIngredientUsageRequest(
            ingredientUsage: usage,
          ),
        ),
        ingredientIdsToExclude: model.editableUsages
            .where((usage) => usage.ingredientId != null)
            .map((usage) => usage.ingredientId!)
            .toList(),
      ),
    );
  }

  Widget buildIngredientUsage(IngredientUsage usage) {
    return Container(
      margin: const EdgeInsets.only(bottom: 12),
      child: IngredientUsageWidget(usage: usage),
    );
  }

  List<Widget> buildPreparationSteps(
      RecipeDetailController controller, RecipeDetailModel model) {
    if (model.recipe == null) {
      return [Container()];
    }
    if (model.isEditMode) {
      return [
        ReorderableListView(
          shrinkWrap: true,
          physics: const NeverScrollableScrollPhysics(),
          children: model.editableSteps
              .map((editableStep) =>
                  buildEditablePreparationStep(controller, model, editableStep))
              .toList(),
          onReorder: controller.reorderPreparationSteps,
        )
      ];
    }

    return model.recipe!.preparationSteps
        .map((step) => buildPreparationStep(step))
        .toList();
  }

  Widget buildEditablePreparationStep(RecipeDetailController controller,
      RecipeDetailModel model, EditablePreparationStep step) {
    return Container(
        key: Key(step.stepNumber.toString()),
        margin: const EdgeInsets.only(bottom: 12),
        child: EditPreparationStepWidget(
          step: step,
          onDescriptionChanged: (description) =>
              controller.updateStepDescription(step, description),
          onDeletePreparationStepCallback: () =>
              controller.deletePreparationStep(
            DeletePreparationStepRequest(
              preparationStep: step,
            ),
          ),
        ));
  }

  Widget buildPreparationStep(PreparationStep step) {
    return PreparationStepWidget(step: step);
  }

  List<Widget> buildAppBarActions(
    BuildContext context,
    RecipeDetailController controller,
    RecipeDetailModel model,
  ) {
    if (model.isEditMode) {
      return [
        Padding(
          padding: const EdgeInsets.only(right: 8),
          child: IconButton(
            onPressed: () {
              for (var editableUsage in model.editableUsages) {
                if (!editableUsage.canBeSaved()) {
                  var dialog = InfoDialog(
                    context: context,
                    title: "common.error".tr(),
                    info: "recipe_details.edit_usage.dialog.info".tr(),
                  );
                  dialog.show();
                  return;
                }
              }
              controller.saveChanges();
            },
            icon: const Icon(Icons.check),
          ),
        )
      ];
    }
    return [
      PopupMenuButton(
        icon: const Icon(Icons.more_vert),
        itemBuilder: (context) => [
          PopupMenuItem<Function>(
            value: controller.enterEditMode,
            child: Row(
              children: [
                Image.asset(
                  "assets/icons/edit.png",
                  width: 24,
                ),
                const SizedBox(width: 12),
                const Text("common.edit").tr(),
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
                const Text("common.delete").tr(),
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
        title: "recipe_details.delete.dialog.title".tr(),
        info: "recipe_details.delete.dialog.info".tr(),
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

  void addNewPreparationStep();
  void reorderPreparationSteps(int start, int current);
  void updateStepDescription(EditablePreparationStep step, String description);
  void deletePreparationStep(DeletePreparationStepRequest request);

  void dismissError();
}
