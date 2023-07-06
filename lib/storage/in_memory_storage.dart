import 'package:recipy_frontend/models/ingredient.dart';
import 'package:recipy_frontend/models/ingredient_unit.dart';
import 'package:recipy_frontend/repositories/http_read_result.dart';

class RecipyInMemoryStorage {
  late InMemoryStorageIngredientRepository _ingredientRepository;
  late InMemoryStorageIngredientUnitRepository _ingredientUnitRepository;

  RecipyInMemoryStorage(
    InMemoryStorageIngredientRepository ingredientRepository,
    InMemoryStorageIngredientUnitRepository ingredientUnitRepository,
  ) {
    _ingredientRepository = ingredientRepository;
    _ingredientUnitRepository = ingredientUnitRepository;
  }

  // Ingredients
  List<Ingredient> _ingredients = [];

  List<Ingredient> getIngredients() => _ingredients;

  Future<HttpReadResult<List<Ingredient>>> refetchIngredients() async {
    var result = await _ingredientRepository.fetchIngredients();
    if (result.success) {
      _ingredients = result.data!;
    }
    return result;
  }

  // Ingredient Units
  List<IngredientUnit> _ingredientUnits = [];

  List<IngredientUnit> getIngredientUnits() => _ingredientUnits;

  Future<HttpReadResult<List<IngredientUnit>>> refetchIngredientUnits() async {
    var result = await _ingredientUnitRepository.fetchIngredientUnits();
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
