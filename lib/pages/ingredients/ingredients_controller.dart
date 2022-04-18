import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:recipy_frontend/helpers/error_mapping.dart';
import 'package:recipy_frontend/helpers/providers.dart';
import 'package:recipy_frontend/models/ingredient.dart';
import 'package:recipy_frontend/pages/ingredients/parts/add_ingredient_request.dart';
import 'package:recipy_frontend/pages/ingredients/ingredients_model.dart';
import 'package:recipy_frontend/pages/ingredients/ingredients_page.dart';
import 'package:recipy_frontend/repositories/http_request_result.dart';
import 'package:recipy_frontend/storage/in_memory_storage.dart';

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

  Future<void> _fetchIngredients() async {
    try {
      state = IngredientsModel(
        isLoading: true,
      );
      var storage = RecipyInMemoryStorage();
      await storage.refetchIngredients();

      state = IngredientsModel(
        ingredients: storage.getIngredients(),
        isLoading: false,
      );
    } catch (e) {
      String errorMessage = errorMessageFor(e.toString());
      state = IngredientsModel(
        error: errorMessage,
        isLoading: false,
      );
    }
  }

  @override
  Future<void> refetchIngredients() async {
    await _fetchIngredients();
  }

  @override
  Future<void> addIngredient(AddIngredientRequest request) async {
    try {
      state = IngredientsModel(
        ingredients: state.ingredients,
        isLoading: true,
      );
      var result = await _repository.addIngredient(request);
      if (result.success) {
        await _fetchIngredients();
      } else {
        state = IngredientsModel(
          ingredients: state.ingredients,
          error: result.error,
          isLoading: false,
        );
      }
    } catch (e) {
      state = IngredientsModel(
        ingredients: state.ingredients,
        error: e.toString(),
        isLoading: false,
      );
    }
  }

  @override
  void dismissError() {
    state = IngredientsModel(
      isLoading: state.isLoading,
      ingredients: state.ingredients,
      error: null,
    );
  }
}

abstract class IngredientRepository {
  Future<List<Ingredient>> fetchIngredients();
  Future<HttpPostResult> addIngredient(AddIngredientRequest request);
}
