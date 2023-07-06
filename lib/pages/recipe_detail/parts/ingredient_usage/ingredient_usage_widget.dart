import 'package:flutter/material.dart';
import 'package:recipy_frontend/models/ingredient_usage.dart';
import 'package:recipy_frontend/pages/recipe_detail/parts/ingredient_usage/with_ingredient_builder.dart';
import 'package:recipy_frontend/pages/recipe_detail/parts/ingredient_usage/with_ingredient_unit_builder.dart';

class IngredientUsageWidget extends StatelessWidget {
  final IngredientUsage usage;

  const IngredientUsageWidget({
    Key? key,
    required this.usage,
  }) : super(key: key);

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
        child: WithIngredientUnitBuilder(
          ingredientUnitId: usage.ingredientUnitId,
          builder: (context, allIngredientUnits, ingredientUnit) => RichText(
            textAlign: TextAlign.end,
            text: TextSpan(
              style:
                  Theme.of(context).textTheme.bodyLarge?.copyWith(fontSize: 18),
              children: <TextSpan>[
                TextSpan(text: "${getAmountAsString()} "),
                TextSpan(
                  text: ingredientUnit?.name ?? "",
                  style: Theme.of(context)
                      .textTheme
                      .bodyLarge
                      ?.copyWith(fontSize: 16),
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }

  Widget buildIngredientWidget() {
    return WithIngredientBuilder(
      ingredientId: usage.ingredientId,
      builder: (context, allIngredients, ingredient) {
        return SizedBox(
          width: 120,
          child: Text(
            ingredient?.name ?? "",
            style: const TextStyle(fontSize: 18),
          ),
        );
      },
    );
  }

  String getAmountAsString() {
    if (usage.amount == usage.amount.roundToDouble()) {
      return usage.amount.round().toString();
    }
    return usage.amount.toString();
  }
}
