import 'package:flutter/material.dart';
import 'package:recipy_frontend/helpers/in_memory.dart';
import 'package:recipy_frontend/models/ingredient.dart';
import 'package:recipy_frontend/models/ingredient_unit.dart';
import 'package:recipy_frontend/models/ingredient_usage.dart';

class IngredientUsageWidget extends StatelessWidget {
  final IngredientUsage usage;
  final Ingredient ingredient;
  final IngredientUnit ingredientUnit;

  IngredientUsageWidget({
    Key? key,
    required this.usage,
  })  : ingredient = ingredientFor(usage.ingredientId)!,
        ingredientUnit = ingredientUnitFor(usage.ingredientUnitId)!,
        super(key: key);

  @override
  Widget build(BuildContext context) {
    return Row(
      children: [
        buildAmountUnitDisplay(),
        buildIngredientWidget(),
      ],
    );
  }

  Widget buildAmountUnitDisplay() {
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
                text: "${usage.amount} ",
              ),
              TextSpan(
                text: ingredientUnit.name,
                style: const TextStyle(fontSize: 13),
              ),
            ],
          ),
        ),
      ),
    );
  }

  Widget buildIngredientWidget() {
    return SizedBox(
      width: 120,
      child: Text(
        ingredient.name,
        style: const TextStyle(fontSize: 18),
      ),
    );
  }
}
