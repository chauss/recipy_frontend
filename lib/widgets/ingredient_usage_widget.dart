import 'package:flutter/material.dart';
import 'package:recipy_frontend/helpers/in_memory.dart';
import 'package:recipy_frontend/models/ingredient.dart';
import 'package:recipy_frontend/models/ingredient_unit.dart';
import 'package:recipy_frontend/models/ingredient_usage.dart';
import 'package:recipy_frontend/storage/in_memory_storage.dart';

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
        widget.isEditMode ? buildAmountWidget() : Container(),
        widget.isEditMode ? const SizedBox(width: 8) : Container(),
        widget.isEditMode ? buildIngredientUnitWidget() : Container(),
        !widget.isEditMode ? buildAmountUnitDisplay() : Container(),
        buildIngredientWidget(),
      ],
    );
  }

  Widget buildAmountWidget() {
    if (!widget.isEditMode) {
      return SizedBox(
        width: 40,
        child: Text(
          widget.usage.amount.toString(),
          textAlign: TextAlign.end,
        ),
      );
    }
    return SizedBox(
      width: 80,
      child: TextField(
        enabled: widget.isEditMode,
        controller: amountController,
        decoration: const InputDecoration(
          border: OutlineInputBorder(),
        ),
      ),
    );
  }

  Widget buildIngredientWidget() {
    return SizedBox(
      width: 120,
      child: Text(
        widget.ingredient.name,
        style: const TextStyle(fontSize: 18),
      ),
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

  Widget buildIngredientUnitWidget() {
    if (!widget.isEditMode) {
      return SizedBox(
        width: 60,
        child: Text(widget.ingredientUnit.name),
      );
    }
    return DropdownButton<IngredientUnit>(
      value: widget.ingredientUnit,
      icon: const Icon(Icons.arrow_downward),
      elevation: 16,
      style: const TextStyle(color: Colors.deepPurple),
      underline: Container(
        height: 2,
        color: Colors.deepPurpleAccent,
      ),
      onChanged: (IngredientUnit? newValue) {
        print("New ingredientUnit: ${newValue?.name}");
      },
      items: RecipyInMemoryStorage()
          .getIngredientUnits()
          .map<DropdownMenuItem<IngredientUnit>>(
        (IngredientUnit value) {
          return DropdownMenuItem<IngredientUnit>(
            value: value,
            child: Text(value.name),
          );
        },
      ).toList(),
    );
  }
}
