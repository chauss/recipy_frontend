import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:recipy_frontend/models/recipe.dart';
import 'package:recipy_frontend/pages/ingredient_units/ingredient_units_controller.dart';
import 'package:recipy_frontend/pages/ingredient_units/ingredient_units_model.dart';
import 'package:recipy_frontend/pages/ingredient_units/ingredient_units_page.dart';
import 'package:recipy_frontend/pages/ingredients/ingredients_controller.dart';
import 'package:recipy_frontend/pages/ingredients/ingredients_model.dart';
import 'package:recipy_frontend/pages/ingredients/ingredients_page.dart';
import 'package:recipy_frontend/pages/recipe_detail/recipe_detail_controller.dart';
import 'package:recipy_frontend/pages/recipe_detail/recipe_detail_model.dart';
import 'package:recipy_frontend/pages/recipe_detail/recipe_detail_page.dart';
import 'package:recipy_frontend/pages/recipe_overview/recipe_overview_controller.dart';
import 'package:recipy_frontend/pages/recipe_overview/recipe_overview_model.dart';
import 'package:recipy_frontend/pages/recipe_overview/recipe_overview_page.dart';
import 'package:recipy_frontend/repositories/ingredient_repository.dart';
import 'package:recipy_frontend/repositories/ingredient_unit_repository.dart';
import 'package:recipy_frontend/repositories/recipe_repository.dart';

// #############################################################################
// # Ingredients
// #############################################################################
final ingredientRepositoryProvider = Provider<IngredientRepository>((ref) {
  final repository = RecipyIngredientRepository();

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

  return repository;
});

final StateNotifierProvider<IngredientUnitsController, IngredientUnitsModel>
    ingredientUnitControllerProvider =
    StateNotifierProvider<IngredientUnitsController, IngredientUnitsModel>(
  (ref) => IngredientUnitsControllerImpl(IngredientUnitsModel()),
);

// #############################################################################
// # Recipe Overview
// #############################################################################
final recipeOverviewRepositoryProvider =
    Provider<RecipeOverviewRepository>((ref) {
  final repository = RecipyRecipeRepository();

  return repository;
});

final StateNotifierProvider<RecipeOverviewController, RecipeOverviewModel>
    recipeOverviewControllerProvider =
    StateNotifierProvider<RecipeOverviewController, RecipeOverviewModel>(
  (ref) => RecipeOverviewControllerImpl(RecipeOverviewModel()),
);

// #############################################################################
// # Recipe Detail
// #############################################################################
final recipeDetailRepositoryProvider = Provider<RecipeDetailRepository>((ref) {
  final repository = RecipyRecipeRepository();

  return repository;
});

final StateNotifierProviderFamily<RecipeDetailController, RecipeDetailModel,
        String> recipeDetailControllerProvider =
    StateNotifierProvider.family<RecipeDetailController, RecipeDetailModel,
        String>(
  (ref, recipeId) =>
      RecipeDetailControllerImpl(RecipeDetailModel(recipeId: recipeId)),
);
