import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:recipy_frontend/pages/ingredient_units/ingredient_units_controller.dart';
import 'package:recipy_frontend/pages/ingredient_units/ingredient_units_model.dart';
import 'package:recipy_frontend/pages/ingredient_units/ingredient_units_page.dart';
import 'package:recipy_frontend/pages/ingredients/ingredients_controller.dart';
import 'package:recipy_frontend/pages/ingredients/ingredients_model.dart';
import 'package:recipy_frontend/pages/ingredients/ingredients_page.dart';
import 'package:recipy_frontend/repositories/ingredient_repository.dart';
import 'package:recipy_frontend/repositories/ingredient_unit_repository.dart';

// #############################################################################
// # Ingredients
// #############################################################################
final ingredientRepositoryProvider = Provider<IngredientRepository>((ref) {
  final repository = RecipyIngredientRepository();
  ref.onDispose(repository.dispose);

  return repository;
});

final StateNotifierProvider<IngredientsController, IngredientsModel>
    ingredientsControllerProvider =
    StateNotifierProvider<IngredientsController, IngredientsModel>(
  (ref) => IngredintsControllerImpl(IngredientsModel()),
);

// #############################################################################
// # Ingredient Units
// #############################################################################
final ingredientUnitRepositoryProvider =
    Provider<IngredientUnitRepository>((ref) {
  final repository = RecipyIngredientUnitRepository();
  ref.onDispose(repository.dispose);

  return repository;
});

final StateNotifierProvider<IngredientUnitsController, IngredientUnitsModel>
    ingredientUnitControllerProvider =
    StateNotifierProvider<IngredientUnitsController, IngredientUnitsModel>(
  (ref) => IngredientUnitsControllerImpl(IngredientUnitsModel()),
);
