import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:recipy_frontend/helpers/in_memory.dart';
import 'package:recipy_frontend/models/ingredient.dart';
import 'package:recipy_frontend/models/ingredient_unit.dart';
import 'package:recipy_frontend/models/ingredient_usage.dart';
import 'package:recipy_frontend/storage/in_memory_storage.dart';
import 'package:recipy_frontend/widgets/recipy_dropdown_widget.dart';

class IngredientUsageWidget extends StatefulWidget {
  final IngredientUsage usage;
  final Ingredient ingredient;
  final IngredientUnit ingredientUnit;
  final bool isEditMode;

  IngredientUsageWidget({
    Key? key,
    required this.usage,
    this.isEditMode = true,
  })  : ingredient = ingredientFor(usage.ingredientId),
        ingredientUnit = ingredientUnitFor(usage.ingredientUnitId),
        super(key: key);

  @override
  State<IngredientUsageWidget> createState() => _IngredientUsageWidgetState();
}

class _IngredientUsageWidgetState extends State<IngredientUsageWidget> {
  late TextEditingController amountController;

  @override
  void initState() {
    super.initState();
    amountController =
        TextEditingController(text: widget.usage.amount.toString());
  }

  @override
  Widget build(BuildContext context) {
    return Row(
      children: [
        widget.isEditMode
            ? buildEditAmountUnitWidget()
            : buildAmountUnitDisplay(),
        buildIngredientWidget(),
      ],
    );
  }

  Widget buildEditAmountUnitWidget() {
    return Row(
      children: [
        buildEditAmountWidget(),
        const SizedBox(width: 8),
        buildEditIngredientUnitWidget(),
      ],
    );
  }

  Widget buildEditAmountWidget() {
    return SizedBox(
      width: 80,
      child: TextField(
        enabled: widget.isEditMode,
        inputFormatters: [
          FilteringTextInputFormatter.allow(RegExp(r'^\d*\.?\d*'))
        ],
        controller: amountController,
        decoration: const InputDecoration(
          border: OutlineInputBorder(),
        ),
      ),
    );
  }

  Widget buildEditIngredientUnitWidget() {
    return RecipyDropdownWidget<IngredientUnit>(
      getDisplayName: (element) => element.name,
      onSelection: (element) => print(element),
      getAssortment: RecipyInMemoryStorage().getIngredientUnits,
      preselection: widget.ingredientUnit,
      hint: "Einheit auswählen",
    );
  }

  Widget buildAmountUnitDisplay() {
    Text(
      "${widget.usage.amount} ${widget.ingredientUnit.name}",
      textAlign: TextAlign.end,
    );
    return Padding(
      padding: const EdgeInsets.only(right: 6),
      child: SizedBox(
        width: 80,
        child: RichText(
          textAlign: TextAlign.end,
          text: TextSpan(
            style: const TextStyle(
              fontSize: 14.0,
              color: Colors.black,
            ),
            children: <TextSpan>[
              TextSpan(
                text: "${widget.usage.amount} ",
              ),
              TextSpan(
                text: widget.ingredientUnit.name,
                style: const TextStyle(fontSize: 13),
              ),
            ],
          ),
        ),
      ),
    );
  }

  Widget buildIngredientWidget() {
    if (widget.isEditMode) {
      return RecipyDropdownWidget<Ingredient>(
        getDisplayName: (element) => element.name,
        onSelection: (element) => print(element),
        getAssortment: RecipyInMemoryStorage().getIngredients,
        preselection: widget.ingredient,
        hint: "Zutat auswählen",
      );
    }
    return SizedBox(
      width: 120,
      child: Text(
        widget.ingredient.name,
        style: const TextStyle(fontSize: 18),
      ),
    );
  }
}
