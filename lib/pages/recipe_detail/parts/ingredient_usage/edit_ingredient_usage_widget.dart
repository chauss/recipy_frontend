import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:recipy_frontend/models/ingredient.dart';
import 'package:recipy_frontend/models/ingredient_unit.dart';
import 'package:recipy_frontend/pages/recipe_detail/parts/ingredient_usage/editable_ingredient_usage.dart';
import 'package:recipy_frontend/pages/recipe_detail/parts/ingredient_usage/with_ingredient_builder.dart';
import 'package:recipy_frontend/pages/recipe_detail/parts/ingredient_usage/with_ingredient_unit_builder.dart';
import 'package:recipy_frontend/widgets/recipy_text_field.dart';
import 'package:recipy_frontend/widgets/recipy_dropdown_widget.dart';
import 'package:easy_localization/easy_localization.dart';

class EditIngredientUsageWidget extends StatelessWidget {
  final EditableIngredientUsage usage;
  final Function(String) onAmountChanged;
  final Function(String?) onIngredientChanged;
  final Function(String?) onIngredientUnitChanged;
  final Function()? onDeleteIngredientUsageCallback;
  final List<String> ingredientIdsToExclude;

  final TextEditingController amountController;

  EditIngredientUsageWidget({
    Key? key,
    required this.usage,
    required this.onAmountChanged,
    required this.onIngredientChanged,
    required this.onIngredientUnitChanged,
    this.onDeleteIngredientUsageCallback,
    this.ingredientIdsToExclude = const [],
  })  : amountController = TextEditingController(text: usage.amount.toString()),
        super(key: key);

  @override
  Widget build(BuildContext context) {
    return Row(
      children: [
        buildEditAmountWidget(),
        const SizedBox(width: 12),
        SizedBox(
          width: 160,
          child: Column(
            children: [
              buildEditIngredientUsageWidget(),
              buildIngredientWidget(),
            ],
          ),
        ),
        Expanded(child: Container()),
        InkWell(
          onTap: onDeleteIngredientUsageCallback,
          child: const Icon(Icons.delete_outline),
        ),
      ],
    );
  }

  Widget buildEditAmountWidget() {
    return SizedBox(
      width: 80,
      child: RecipyTextField(
        controller: amountController,
        inputFormatters: [
          FilteringTextInputFormatter.allow(RegExp(r'^\d*\.?\d*'))
        ],
        onChanged: (_) => onAmountChanged(amountController.text),
        onChangedDebounceMs: 0,
      ),
    );
  }

  Widget buildEditIngredientUsageWidget() {
    return WithIngredientUnitBuilder(
      ingredientUnitId: usage.ingredientUnitId,
      builder: (context, allIngredientUnits, ingredientUnit) {
        return RecipyDropdownWidget<IngredientUnit>(
          getDisplayName: (ingredientUnit) => ingredientUnit.name,
          onSelection: (ingredientUnit) =>
              onIngredientUnitChanged(ingredientUnit?.id),
          getAssortment: () => allIngredientUnits,
          preselection: ingredientUnit,
          hint: "recipe_details.edit_mode.usage.ingredient_unit.dropdown.hint"
              .tr(),
        );
      },
    );
  }

  Widget buildIngredientWidget() {
    return WithIngredientBuilder(
      ingredientId: usage.ingredientId,
      builder: (context, allIngredients, ingredient) {
        return RecipyDropdownWidget<Ingredient>(
          getDisplayName: (ingredient) => ingredient.name,
          onSelection: (ingredient) => onIngredientChanged(ingredient?.id),
          getAssortment: () {
            var assortment = allIngredients
                .where(
                  (ing) =>
                      !ingredientIdsToExclude.contains(ing.id) ||
                      ing.id == ingredient?.id,
                )
                .toList();

            return assortment;
          },
          preselection: ingredient,
          hint: "recipe_details.edit_mode.usage.ingredient.dropdown.hint".tr(),
        );
      },
    );
  }
}
