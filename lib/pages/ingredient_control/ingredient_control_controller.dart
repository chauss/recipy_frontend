import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:recipy_frontend/models/ingredient.dart';
import 'package:recipy_frontend/pages/ingredient_control/add_ingredient_request.dart';
import 'package:recipy_frontend/pages/ingredient_control/ingredient_control_model.dart';
import 'package:recipy_frontend/pages/ingredient_control/ingredients_control_page.dart';
import 'package:recipy_frontend/repositories/ingredient_repository.dart';

class IngredintControlControllerImpl extends IngredientControlController {
  IngredintControlControllerImpl(IngredientControlModel state) : super(state) {
    _init();
  }

  void _init() async {
    await _fetchIngredients();
  }

  Future _fetchIngredients() async {
    final container = ProviderContainer();
    final repository = await container.read(repositoryProvider.future);

    try {
      state = IngredientControlModel(
        isLoading: true,
      );
      var ingredients = await repository.fetchIngredients();
      state = IngredientControlModel(
        ingredients: ingredients,
        isLoading: false,
      );
    } catch (e) {
      state = IngredientControlModel(
        error: e.toString(),
        isLoading: false,
      );
    }
  }

  @override
  Future addIngredient(AddIngredientRequest request) async {
    try {
      await IngredientRepository.addIngredient(request.name);
      await _fetchIngredients();
    } catch (e) {
      state = IngredientControlModel(
        error: e.toString(),
      );
    }
  }
}

final repositoryProvider = FutureProvider<IngredientRepository>((ref) async {
  final repository = IngredientRepository();
  ref.onDispose(repository.dispose);

  return repository;
});

abstract class IngredientControlRepository {
  Future<List<Ingredient>> fetchIngredients();
  void dispose();
}
