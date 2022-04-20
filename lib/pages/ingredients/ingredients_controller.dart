import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:recipy_frontend/helpers/error_mapping.dart';
import 'package:recipy_frontend/helpers/providers.dart';
import 'package:recipy_frontend/models/ingredient.dart';
import 'package:recipy_frontend/pages/ingredients/parts/add_ingredient_request.dart';
import 'package:recipy_frontend/pages/ingredients/ingredients_model.dart';
import 'package:recipy_frontend/pages/ingredients/ingredients_page.dart';
import 'package:recipy_frontend/pages/ingredients/parts/delete_ingredient_request.dart';
import 'package:recipy_frontend/repositories/http_write_result.dart';
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
        ingredients: state.ingredients,
        error: state.error,
      );
      final storage = RecipyInMemoryStorage();
      await storage.refetchIngredients();

      state = IngredientsModel(
        ingredients: storage.getIngredients(),
        isLoading: false,
        error: state.error,
      );
    } catch (e) {
      String errorMessage = errorMessageFor(e.toString());
      state = IngredientsModel(
        ingredients: state.ingredients,
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
        error: state.error,
      );
      final result = await _repository.addIngredient(request);
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

  @override
  Future<void> deleteIngredient(DeleteIngredientRequest request) async {
    state = IngredientsModel(
      error: state.error,
      ingredients: state.ingredients,
      isLoading: true,
    );
    final result = await _repository.deleteIngredientById(request);
    if (result.success) {
      await _fetchIngredients();
    } else {
      state = IngredientsModel(
        ingredients: state.ingredients,
        error: result.error,
        isLoading: false,
      );
    }
  }
}

abstract class IngredientRepository {
  Future<HttpWriteResult> deleteIngredientById(DeleteIngredientRequest request);
  Future<List<Ingredient>> fetchIngredients();
  Future<HttpWriteResult> addIngredient(AddIngredientRequest request);
}
