import 'package:recipy_frontend/models/ingredient.dart';
import 'package:recipy_frontend/models/ingredient_unit.dart';
import 'package:recipy_frontend/storage/in_memory_storage.dart';

Ingredient ingredientFor(String ingredientId) {
  return RecipyInMemoryStorage()
      .getIngredients()
      .firstWhere((ingredient) => ingredient.id == ingredientId);
}

IngredientUnit ingredientUnitFor(String ingredientUnitId) {
  return RecipyInMemoryStorage()
      .getIngredientUnits()
      .firstWhere((ingredientUnit) => ingredientUnit.id == ingredientUnitId);
}
