import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:recipy_frontend/helpers/providers.dart';
import 'package:recipy_frontend/models/recipe.dart';
import 'package:recipy_frontend/pages/recipe_detail/recipe_detail_model.dart';
import 'package:recipy_frontend/pages/recipe_detail/recipe_detail_page.dart';

class RecipeDetailControllerImpl extends RecipeDetailController {
  late RecipeDetailRepository _repository;

  RecipeDetailControllerImpl(RecipeDetailModel state) : super(state) {
    final container = ProviderContainer();
    _repository = container.read(recipeDetailRepositoryProvider);
    _init();
  }

  void _init() async {
    await _fetchRecipe();
  }

  Future<void> _fetchRecipe() async {
    var recipe = await _repository.fetchRecipeById(state.recipeId);
    String? error;

    if (recipe == null) {
      error = "Rezept nicht gefunden";
    }
    state = RecipeDetailModel(
      recipeId: state.recipeId,
      recipe: recipe,
      error: error,
      isLoading: false,
      isEditMode: state.isEditMode,
    );
  }

  @override
  void toggleEditMode() {
    state = RecipeDetailModel(
      recipeId: state.recipeId,
      recipe: state.recipe,
      isEditMode: !state.isEditMode,
    );
  }
}

abstract class RecipeDetailRepository {
  Future<Recipe?> fetchRecipeById(String recipeId);
}
