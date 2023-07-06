import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:recipy_frontend/helpers/providers.dart';
import 'package:recipy_frontend/models/ingredient_unit.dart';

typedef BuildWithIngredientUnit = Widget Function(BuildContext context,
    List<IngredientUnit> allIngredientUnits, IngredientUnit? ingredientUnit);

class WithIngredientUnitBuilder extends ConsumerWidget {
  final String? ingredientUnitId;
  final BuildWithIngredientUnit builder;

  const WithIngredientUnitBuilder({
    super.key,
    this.ingredientUnitId,
    required this.builder,
  });

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final allIngredientUnits =
        ref.read(inMemoryStorageProvider).getIngredientUnits();
    allIngredientUnits.sort((a, b) => a.name.compareTo(b.name));
    IngredientUnit? ingredientUnit;
    if (ingredientUnitId != null) {
      try {
        ingredientUnit = allIngredientUnits
            .firstWhere((ingUnit) => ingUnit.id == ingredientUnitId);
      } on StateError catch (_) {}
    }
    return builder(context, allIngredientUnits, ingredientUnit);
  }
}
