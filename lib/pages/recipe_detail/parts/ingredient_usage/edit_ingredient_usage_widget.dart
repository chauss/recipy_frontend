import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:recipy_frontend/helpers/in_memory.dart';
import 'package:recipy_frontend/models/ingredient.dart';
import 'package:recipy_frontend/models/ingredient_unit.dart';
import 'package:recipy_frontend/pages/recipe_detail/parts/ingredient_usage/editable_ingredient_usage.dart';
import 'package:recipy_frontend/storage/in_memory_storage.dart';
import 'package:recipy_frontend/widgets/custom_text_field.dart';
import 'package:recipy_frontend/widgets/recipy_dropdown_widget.dart';
import 'package:easy_localization/easy_localization.dart';

class EditIngredientUsageWidget extends StatelessWidget {
  final EditableIngredientUsage usage;
  final Function(double) onAmountChanged;
  final Function(String?) onIngredientChanged;
  final Function(String?) onIngredientUnitChanged;
  final Function()? onDeleteIngredientUsageCallback;
  final List<String> ingredientIdsToExclude;

  final Ingredient? ingredient;
  final IngredientUnit? ingredientUnit;
  final TextEditingController amountController;

  EditIngredientUsageWidget({
    Key? key,
    required this.usage,
    required this.onAmountChanged,
    required this.onIngredientChanged,
    required this.onIngredientUnitChanged,
    this.onDeleteIngredientUsageCallback,
    this.ingredientIdsToExclude = const [],
  })  : ingredient = ingredientFor(usage.ingredientId ?? ""),
        ingredientUnit = ingredientUnitFor(usage.ingredientUnitId ?? ""),
        amountController = TextEditingController(text: usage.amount.toString()),
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
          child: Image.asset(
            'assets/icons/trash.png',
            width: 28,
          ),
          onTap: onDeleteIngredientUsageCallback,
        ),
      ],
    );
  }

  Widget buildEditAmountWidget() {
    return SizedBox(
      width: 80,
      child: CustomTextField(
        controller: amountController,
        inputFormatters: [
          FilteringTextInputFormatter.allow(RegExp(r'^\d*\.?\d*'))
        ],
        onChanged: (_) => onAmountChanged(double.parse(amountController.text)),
      ),
    );
  }

  Widget buildEditIngredientUsageWidget() {
    return RecipyDropdownWidget<IngredientUnit>(
      getDisplayName: (ingredientUnit) => ingredientUnit.name,
      onSelection: (ingredientUnit) =>
          onIngredientUnitChanged(ingredientUnit?.id),
      getAssortment: RecipyInMemoryStorage().getIngredientUnits,
      preselection: ingredientUnit,
      hint: "recipe_details.edit_usage.ingredient_unit.dropdown.hint".tr(),
    );
  }

  Widget buildIngredientWidget() {
    return RecipyDropdownWidget<Ingredient>(
      getDisplayName: (ingredient) => ingredient.name,
      onSelection: (ingredient) => onIngredientChanged(ingredient?.id),
      getAssortment: () => RecipyInMemoryStorage()
          .getIngredients()
          .where(
            (ing) =>
                !ingredientIdsToExclude.contains(ing.id) ||
                ing.id == ingredient?.id,
          )
          .toList(),
      preselection: ingredient,
      hint: "recipe_details.edit_usage.ingredient.dropdown.hint".tr(),
    );
  }
}
