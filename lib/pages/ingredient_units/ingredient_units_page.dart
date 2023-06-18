import 'package:easy_localization/easy_localization.dart';
import 'package:flutter/material.dart';
import 'package:flutter/scheduler.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:recipy_frontend/helpers/providers.dart';
import 'package:recipy_frontend/pages/ingredient_units/ingredient_units_model.dart';
import 'package:recipy_frontend/pages/ingredient_units/parts/ingredient_unit_widget.dart';
import 'package:recipy_frontend/widgets/executive_textfield.dart';
import 'package:recipy_frontend/widgets/info_dialog.dart';
import 'package:recipy_frontend/widgets/process_indicator.dart';
import 'package:recipy_frontend/widgets/recipy_app_bar.dart';

class IngredientUnitsPage extends ConsumerWidget {
  const IngredientUnitsPage({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    IngredientUnitsController controller =
        ref.read(ingredientUnitControllerProvider.notifier);
    IngredientUnitsModel model = ref.watch(ingredientUnitControllerProvider);

    return Scaffold(
      appBar: RecipyAppBar(title: "ingredient_units.title".tr()),
      body: SafeArea(
        child: Column(
          children: [
            Expanded(
              child: buildBody(context, model, controller),
            ),
            model.canAddIngredientUnits
                ? ExecutiveTextfield(
                    addFunction: (name) => controller.addIngredientUnit(name),
                    hintText: 'ingredient_units.add.textfield.hint'.tr(),
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
    IngredientUnitsModel model,
    IngredientUnitsController controller,
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
      onRefresh: controller.refetchIngredientUnits,
      child: ListView(
        padding: const EdgeInsets.all(24),
        children: model.units
            .map(
              (ingredientUnit) => IngredientUnitWidget(
                ingredientUnit: ingredientUnit,
                onDeleteIngredientUnitCallback: model.canDeleteIngredientUnits
                    ? () => controller.deleteIngredientUnit(ingredientUnit.id)
                    : null,
              ),
            )
            .toList(),
      ),
    );
  }
}

abstract class IngredientUnitsController
    extends StateNotifier<IngredientUnitsModel> {
  IngredientUnitsController(IngredientUnitsModel state) : super(state);

  Future<void> refetchIngredientUnits();
  Future<void> addIngredientUnit(String name);
  void deleteIngredientUnit(String ingredientUnitId);
  void dismissError();
}
