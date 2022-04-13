import 'package:recipy_frontend/models/ingredient.dart';
import 'package:recipy_frontend/models/ingredient_unit.dart';
import 'package:recipy_frontend/repositories/ingredient_repository.dart';
import 'package:recipy_frontend/repositories/ingredient_unit_repository.dart';

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
    _ingredients = await IngredientRepository.fetchIngredients();
  }

  // Ingredient Units
  List<IngredientUnit> _ingredientUnits = [];

  List<IngredientUnit> getIngredientUnits() => _ingredientUnits;

  Future<void> refetchIngredientUnits() async {
    _ingredientUnits = await IngredientUnitRepository.fetchIngredientUnits();
  }
}