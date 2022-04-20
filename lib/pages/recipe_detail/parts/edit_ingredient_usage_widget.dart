import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:recipy_frontend/helpers/in_memory.dart';
import 'package:recipy_frontend/models/ingredient.dart';
import 'package:recipy_frontend/models/ingredient_unit.dart';
import 'package:recipy_frontend/pages/recipe_detail/parts/editable_ingredient_usage.dart';
import 'package:recipy_frontend/storage/in_memory_storage.dart';
import 'package:recipy_frontend/widgets/recipy_dropdown_widget.dart';

class EditIngredientUsageWidget extends StatelessWidget {
  final EditableIngredientUsage usage;
  final Function(double) onAmountChanged;
  final Function(String?) onIngredientChanged;
  final Function(String?) onIngredientUnitChanged;

  final Ingredient? ingredient;
  final IngredientUnit? ingredientUnit;
  final TextEditingController amountController;

  EditIngredientUsageWidget({
    Key? key,
    required this.usage,
    required this.onAmountChanged,
    required this.onIngredientChanged,
    required this.onIngredientUnitChanged,
  })  : ingredient = ingredientFor(usage.ingredientId ?? ""),
        ingredientUnit = ingredientUnitFor(usage.ingredientUnitId ?? ""),
        amountController = TextEditingController(text: usage.amount.toString()),
        super(key: key);

  @override
  Widget build(BuildContext context) {
    return Row(
      children: [
        buildEditAmountUnitWidget(),
        buildIngredientWidget(),
      ],
    );
  }

  Widget buildEditAmountUnitWidget() {
    return Row(
      children: [
        buildEditAmountWidget(),
        const SizedBox(width: 8),
        buildEditIngredientUsageWidget(),
      ],
    );
  }

  Widget buildEditAmountWidget() {
    return SizedBox(
      width: 80,
      child: TextField(
        controller: amountController,
        inputFormatters: [
          FilteringTextInputFormatter.allow(RegExp(r'^\d*\.?\d*'))
        ],
        onChanged: (_) => onAmountChanged(double.parse(amountController.text)),
        decoration: const InputDecoration(
          border: OutlineInputBorder(),
        ),
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
      hint: "Einheit auswählen",
    );
  }

  Widget buildIngredientWidget() {
    return RecipyDropdownWidget<Ingredient>(
      getDisplayName: (ingredient) => ingredient.name,
      onSelection: (ingredient) => onIngredientChanged(ingredient?.id),
      getAssortment: RecipyInMemoryStorage().getIngredients,
      preselection: ingredient,
      hint: "Zutat auswählen",
    );
  }
}
