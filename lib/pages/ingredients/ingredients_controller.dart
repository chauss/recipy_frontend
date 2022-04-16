import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:recipy_frontend/helpers/providers.dart';
import 'package:recipy_frontend/models/ingredient.dart';
import 'package:recipy_frontend/pages/ingredients/add_ingredient_request.dart';
import 'package:recipy_frontend/pages/ingredients/ingredients_model.dart';
import 'package:recipy_frontend/pages/ingredients/ingredients_page.dart';
import 'package:recipy_frontend/repositories/http_request_result.dart';

class IngredintsControllerImpl extends IngredientsController {
  late IngredientRepository _repository;

  IngredintsControllerImpl(IngredientsModel state) : super(state) {
    final container = ProviderContainer();
    _repository = container.read(ingredientRepositoryProvider);
    _init();
  }

  void _init() async {
    await _fetchIngredients();
  }

  Future _fetchIngredients() async {
    try {
      state = IngredientsModel(
        isLoading: true,
      );
      var ingredients = await _repository.fetchIngredients();
      state = IngredientsModel(
        ingredients: ingredients,
        isLoading: false,
      );
    } catch (e) {
      state = IngredientsModel(
        error: e.toString(),
        isLoading: false,
      );
    }
  }

  @override
  Future addIngredient(AddIngredientRequest request) async {
    try {
      await _repository.addIngredient(request);
      await _fetchIngredients();
    } catch (e) {
      state = IngredientsModel(
        error: e.toString(),
      );
    }
  }
}

abstract class IngredientRepository {
  Future<List<Ingredient>> fetchIngredients();
  Future<HttpPostResult> addIngredient(AddIngredientRequest request);
  void dispose();
}
