import 'package:easy_localization/easy_localization.dart';
import 'package:flutter/material.dart';
import 'package:flutter/scheduler.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:recipy_frontend/helpers/providers.dart';
import 'package:recipy_frontend/pages/ingredients/ingredients_model.dart';
import 'package:recipy_frontend/pages/ingredients/parts/ingredient_widget.dart';
import 'package:recipy_frontend/widgets/executive_textfield.dart';
import 'package:recipy_frontend/widgets/dialogs/info_dialog.dart';
import 'package:recipy_frontend/widgets/process_indicator.dart';
import 'package:recipy_frontend/widgets/recipy_app_bar.dart';

class IngredientsPage extends ConsumerWidget {
  const IngredientsPage({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    IngredientsController controller =
        ref.read(ingredientsControllerProvider.notifier);

    IngredientsModel model = ref.watch(ingredientsControllerProvider);

    return Scaffold(
      appBar: RecipyAppBar(title: "ingredients.title".tr()),
      body: SafeArea(
        child: Column(
          children: [
            Expanded(
              child: buildBody(context, model, controller),
            ),
            model.canAddIngredients
                ? ExecutiveTextfield(
                    addFunction: (name) => controller.addIngredient(name),
                    hintText: 'ingredients.add.textfield.hint'.tr(),
                    enabled: !model.isLoading,
                  )
                : Container(),
          ],
        ),
      ),
    );
  }

  Widget buildBody(
    BuildContext context,
    IngredientsModel model,
    IngredientsController controller,
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
      SchedulerBinding.instance.addPostFrameCallback((_) {
        dialog.show().then((_) => controller.dismissError());
      });
    }

    return RefreshIndicator(
      onRefresh: controller.refetchIngredients,
      child: ListView(
        padding: const EdgeInsets.all(24),
        children: model.ingredients
            .map(
              (ingredient) => IngredientWidget(
                ingredient: ingredient,
                onDeleteIngredientCallback: model.canDeleteIngredients
                    ? () => controller.deleteIngredient(
                          ingredient.id,
                        )
                    : null,
              ),
            )
            .toList(),
      ),
    );
  }
}

abstract class IngredientsController extends StateNotifier<IngredientsModel> {
  IngredientsController(IngredientsModel state) : super(state);

  Future<void> refetchIngredients();
  Future<void> addIngredient(String name);
  void deleteIngredient(String ingredientId);
  void dismissError();
}
