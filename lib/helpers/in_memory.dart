import 'package:recipy_frontend/models/ingredient.dart';
import 'package:recipy_frontend/models/ingredient_unit.dart';
import 'package:recipy_frontend/storage/in_memory_storage.dart';

Ingredient? ingredientFor(String ingredientId) {
  try {
    return RecipyInMemoryStorage()
        .getIngredients()
        .firstWhere((ingredient) => ingredient.id == ingredientId);
  } on StateError catch (_) {
    return null;
  }
}

IngredientUnit? ingredientUnitFor(String ingredientUnitId) {
  try {
    return RecipyInMemoryStorage()
        .getIngredientUnits()
        .firstWhere((ingredientUnit) => ingredientUnit.id == ingredientUnitId);
  } on StateError catch (_) {
    return null;
  }
}
