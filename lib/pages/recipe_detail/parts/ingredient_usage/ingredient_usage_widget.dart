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
        buildAmountUnitDisplay(context),
        buildIngredientWidget(),
      ],
    );
  }

  Widget buildAmountUnitDisplay(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.only(right: 6),
      child: SizedBox(
        width: 100,
        child: RichText(
          textAlign: TextAlign.end,
          text: TextSpan(
            style:
                Theme.of(context).textTheme.bodyText1?.copyWith(fontSize: 18),
            children: <TextSpan>[
              TextSpan(text: getAmountAsString() + " "),
              TextSpan(
                text: ingredientUnit.name,
                style: Theme.of(context)
                    .textTheme
                    .bodyText1
                    ?.copyWith(fontSize: 16),
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

  String getAmountAsString() {
    if (usage.amount == usage.amount.roundToDouble()) {
      return usage.amount.round().toString();
    }
    return usage.amount.toString();
  }
}
