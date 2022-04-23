import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:recipy_frontend/helpers/providers.dart';
import 'package:recipy_frontend/models/recipe_overview.dart';
import 'package:recipy_frontend/pages/recipe_overview/parts/add_recipe_request.dart';
import 'package:recipy_frontend/pages/recipe_overview/recipe_overview_model.dart';
import 'package:recipy_frontend/pages/recipe_overview/recipe_overview_page.dart';
import 'package:recipy_frontend/repositories/http_read_result.dart';
import 'package:recipy_frontend/repositories/http_write_result.dart';

class RecipeOverviewControllerImpl extends RecipeOverviewController {
  late RecipeOverviewRepository _recipeRepository;

  RecipeOverviewControllerImpl(RecipeOverviewModel state) : super(state) {
    final container = ProviderContainer();
    _recipeRepository = container.read(recipeOverviewRepositoryProvider);

    _init();
  }

  void _init() async {
    _fetchRecipes();
  }

  Future<void> _fetchRecipes() async {
    state = state.copyWith(isLoading: true);
    var result = await _recipeRepository.fetchRecipesAsOverview();
    if (result.success) {
      state = state.copyWith(recipeOverviews: result.data!, isLoading: false);
    } else {
      state = state.copyWith(errorCode: result.errorCode, isLoading: false);
    }
  }

  @override
  Future<void> refetchRecipes() async {
    await _fetchRecipes();
  }

  @override
  Future<void> addRecipe(AddRecipeRequest request) async {
    var result = await _recipeRepository.addRecipe(request);
    if (result.success) {
      await _fetchRecipes();
    } else {
      state = state.copyWith(errorCode: result.errorCode);
    }
  }

  @override
  void dismissError() => state = state.copyWith(errorCode: null);
}

abstract class RecipeOverviewRepository {
  Future<HttpReadResult<List<RecipeOverview>>> fetchRecipesAsOverview();
  Future<HttpWriteResult> addRecipe(AddRecipeRequest request);
}
