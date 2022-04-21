import 'package:flutter/material.dart';
import 'package:flutter/scheduler.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:recipy_frontend/helpers/providers.dart';
import 'package:recipy_frontend/pages/ingredient_units/parts/add_unit_request.dart';
import 'package:recipy_frontend/pages/ingredient_units/ingredient_units_model.dart';
import 'package:recipy_frontend/pages/ingredient_units/parts/delete_ingredient_unit_request.dart';
import 'package:recipy_frontend/widgets/info_dialog.dart';
import 'package:recipy_frontend/widgets/process_indicator.dart';
import 'package:recipy_frontend/widgets/recipy_app_bar.dart';
import 'package:recipy_frontend/widgets/executive_textfield.dart';
import 'package:recipy_frontend/pages/ingredient_units/parts/ingredient_unit_widget.dart';
import 'package:recipy_frontend/widgets/nav_drawer.dart';
import 'package:easy_localization/easy_localization.dart';

class IngredientUnitsPage extends ConsumerWidget {
  const IngredientUnitsPage({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    IngredientUnitsController controller =
        ref.read(ingredientUnitControllerProvider.notifier);
    IngredientUnitsModel model = ref.watch(ingredientUnitControllerProvider);

    return Scaffold(
      drawer: const NavDrawer(),
      appBar: RecipyAppBar(title: "ingredient_units.title".tr()),
      body: Container(
        color: Colors.grey,
        child: SafeArea(
          child: Column(
            children: [
              Expanded(
                child: Container(
                  color: Colors.white,
                  child: buildBody(context, model, controller),
                ),
              ),
              ExecutiveTextfield(
                addFunction: (name) => controller
                    .addIngredientUnit(AddIngredientUnitRequest(name: name)),
                hintText: 'ingredient_units.add.textfield.hint'.tr(),
                enabled: !model.isLoading,
              ),
            ],
          ),
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

    if (model.error != null) {
      var dialog = InfoDialog(
        context: context,
        title: "common.error".tr(),
        info: model.error!,
      );
      SchedulerBinding.instance!.addPostFrameCallback((_) {
        dialog.show().then((_) => controller.dismissError());
      });
    }

    return RefreshIndicator(
      onRefresh: controller.refetchIngredientUnits,
      child: ListView(
        children: model.units
            .map(
              (ingredientUnit) => IngredientUnitWidget(
                ingredientUnit: ingredientUnit,
                onDeleteIngredientUnitCallback: () =>
                    controller.deleteIngredientUnit(
                  DeleteIngredientUnitRequest(
                      ingredientUnitId: ingredientUnit.id),
                ),
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
  Future<void> addIngredientUnit(AddIngredientUnitRequest request);
  void deleteIngredientUnit(DeleteIngredientUnitRequest request);
  void dismissError();
}
