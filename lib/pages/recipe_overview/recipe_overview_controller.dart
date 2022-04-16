import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:recipy_frontend/helpers/providers.dart';
import 'package:recipy_frontend/models/ingredient.dart';
import 'package:recipy_frontend/models/ingredient_unit.dart';
import 'package:recipy_frontend/models/recipe.dart';
import 'package:recipy_frontend/pages/recipe_overview/add_recipe_request.dart';
import 'package:recipy_frontend/pages/recipe_overview/recipe_overview_model.dart';
import 'package:recipy_frontend/pages/recipe_overview/recipe_overview_page.dart';
import 'package:recipy_frontend/repositories/http_request_result.dart';

class RecipeOverviewControllerImpl extends RecipeOverviewController {
  late RecipeOverviewRepository _recipeRepository;
  late List<Ingredient> _allIngredients;
  late List<IngredientUnit> _allIngredientUnits;

  RecipeOverviewControllerImpl(RecipeOverviewModel state) : super(state) {
    final container = ProviderContainer();
    _recipeRepository = container.read(recipeOverviewRepositoryProvider);

    _init();
  }

  void _init() async {
    state = RecipeOverviewModel(
      isLoading: true,
    );
    try {
      final container = ProviderContainer();
      var ingredientRepository = container.read(ingredientRepositoryProvider);
      _allIngredients = await ingredientRepository.fetchIngredients();

      var ingredientUnitRepository =
          container.read(ingredientUnitRepositoryProvider);
      _allIngredientUnits =
          await ingredientUnitRepository.fetchIngredientUnits();

      _fetchRecipes();
    } catch (e) {
      state = RecipeOverviewModel(
        error: e.toString(),
        isLoading: false,
      );
    }
  }

  Future<void> _fetchRecipes() async {
    try {
      state = RecipeOverviewModel(
        isLoading: true,
      );
      var recipes = await _recipeRepository.fetchRecipes();
      state = RecipeOverviewModel(
        recipes: recipes,
        isLoading: false,
      );
    } catch (e) {
      state = RecipeOverviewModel(
        error: e.toString(),
        isLoading: false,
      );
    }
  }

  @override
  Future<void> addRecipe(AddRecipeRequest request) async {
    try {
      await _recipeRepository.addRecipe(request);
      await _fetchRecipes();
    } catch (e) {
      state = RecipeOverviewModel(
        error: e.toString(),
      );
    }
  }
}

abstract class RecipeOverviewRepository {
  Future<List<Recipe>> fetchRecipes();
  Future<HttpPostResult> addRecipe(AddRecipeRequest request);
}
