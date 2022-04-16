import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:recipy_frontend/helpers/providers.dart';
import 'package:recipy_frontend/models/ingredient.dart';
import 'package:recipy_frontend/models/ingredient_unit.dart';

class RecipyInMemoryStorage {
  static final RecipyInMemoryStorage _instance =
      RecipyInMemoryStorage._internal();

  RecipyInMemoryStorage._internal();

  factory RecipyInMemoryStorage() {
    return _instance;
  }

  // Ingredients
  List<Ingredient> _ingredients = [];

  List<Ingredient> getIngredients() => _ingredients;

  Future<void> refetchIngredients() async {
    final container = ProviderContainer();
    final repository = container.read(ingredientRepositoryProvider);
    _ingredients = await repository.fetchIngredients();
  }

  // Ingredient Units
  List<IngredientUnit> _ingredientUnits = [];

  List<IngredientUnit> getIngredientUnits() => _ingredientUnits;

  Future<void> refetchIngredientUnits() async {
    final container = ProviderContainer();
    final repository = container.read(ingredientUnitRepositoryProvider);
    _ingredientUnits = await repository.fetchIngredientUnits();
  }
}
