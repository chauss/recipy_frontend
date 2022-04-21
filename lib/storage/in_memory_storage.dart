import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:recipy_frontend/helpers/providers.dart';
import 'package:recipy_frontend/models/ingredient.dart';
import 'package:recipy_frontend/models/ingredient_unit.dart';
import 'package:recipy_frontend/repositories/http_read_result.dart';

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

  Future<HttpReadResult<List<Ingredient>>> refetchIngredients() async {
    final container = ProviderContainer();
    final repository =
        container.read(inMemoryStorageIngredientRepositoryProvider);
    var result = await repository.fetchIngredients();
    if (result.success) {
      _ingredients = result.data!;
    }
    return result;
  }

  // Ingredient Units
  List<IngredientUnit> _ingredientUnits = [];

  List<IngredientUnit> getIngredientUnits() => _ingredientUnits;

  Future<HttpReadResult<List<IngredientUnit>>> refetchIngredientUnits() async {
    final container = ProviderContainer();
    final repository =
        container.read(inMemoryStorageIngredientUnitRepositoryProvider);
    var result = await repository.fetchIngredientUnits();
    if (result.success) {
      _ingredientUnits = result.data!;
    }
    return result;
  }
}

abstract class InMemoryStorageIngredientRepository {
  Future<HttpReadResult<List<Ingredient>>> fetchIngredients();
}

abstract class InMemoryStorageIngredientUnitRepository {
  Future<HttpReadResult<List<IngredientUnit>>> fetchIngredientUnits();
}
