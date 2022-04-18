import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:recipy_frontend/helpers/providers.dart';
import 'package:recipy_frontend/models/recipe.dart';
import 'package:recipy_frontend/pages/recipe_detail/add_ingredient_usage_request.dart';
import 'package:recipy_frontend/pages/recipe_detail/editable_ingredient_usage.dart';
import 'package:recipy_frontend/pages/recipe_detail/recipe_detail_model.dart';
import 'package:recipy_frontend/pages/recipe_detail/recipe_detail_page.dart';
import 'package:recipy_frontend/pages/recipe_detail/update_ingredient_usage_request.dart';
import 'package:recipy_frontend/repositories/http_request_result.dart';

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
      isEditMode: false,
      editableUsages: [],
    );
  }

  @override
  void enterEditMode() {
    state = RecipeDetailModel(
        recipeId: state.recipeId,
        recipe: state.recipe,
        isEditMode: true,
        editableUsages: (state.recipe?.ingredientUsages ?? [])
            .map((usage) => EditableIngredientUsage.fromIngredientUsage(usage))
            .toList());
  }

  @override
  Future<void> saveChanges() async {
    for (var editableUsage in state.editableUsages) {
      // Check if information is valid
      if (editableUsage.amount == null ||
          editableUsage.ingredientId == null ||
          editableUsage.ingredientUnitId == null) {
        state = RecipeDetailModel(
          recipeId: state.recipeId,
          recipe: state.recipe,
          isEditMode: true,
          editableUsages: state.editableUsages,
          isLoading: state.isLoading,
          error: "Manche Felder sind nicht ausgefüllt!",
        );
        return;
      }

      try {
        var existingIngredientUsage = state.recipe!.ingredientUsages.firstWhere(
            (ingredientUsage) => ingredientUsage.id == editableUsage.id);
        // Check if information changed
        if (editableUsage.amount == existingIngredientUsage.amount &&
            editableUsage.ingredientId ==
                existingIngredientUsage.ingredientId &&
            editableUsage.ingredientUnitId ==
                existingIngredientUsage.ingredientUnitId) {
          continue;
        }
        var result = await _repository
            .updateIngredientUsage(UpdateIngredientUsageRequest(
          ingredientUsageId: existingIngredientUsage.id,
          amount: editableUsage.amount!,
          ingredientId: editableUsage.ingredientId!,
          ingredientUnitId: editableUsage.ingredientUnitId!,
        ));
        if (!result.success) {
          state = RecipeDetailModel(
            recipeId: state.recipeId,
            recipe: state.recipe,
            isEditMode: true,
            editableUsages: state.editableUsages,
            isLoading: state.isLoading,
            error: result.error,
          );
          return;
        }
      } on StateError catch (_) {
        var result = await _repository
            .createIngredientUsage(CreateIngredientUsageRequest(
          recipeId: state.recipeId,
          amount: editableUsage.amount!,
          ingredientId: editableUsage.ingredientId!,
          ingredientUnitId: editableUsage.ingredientUnitId!,
        ));
        if (!result.success) {
          state = RecipeDetailModel(
            recipeId: state.recipeId,
            recipe: state.recipe,
            isEditMode: true,
            editableUsages: state.editableUsages,
            isLoading: state.isLoading,
            error: result.error,
          );
          return;
        }
      }
    }
    await _fetchRecipe();
  }

  @override
  void addNewIngredientUsage() {
    state = RecipeDetailModel(
      recipeId: state.recipeId,
      recipe: state.recipe,
      isEditMode: state.isEditMode,
      editableUsages: [
        ...state.editableUsages,
        EditableIngredientUsage(amount: 1)
      ],
      error: state.error,
      isLoading: state.isLoading,
    );
  }

  @override
  void updateUsageAmount(EditableIngredientUsage usage, double amount) {
    var updatedUsages = state.editableUsages.map((editableUsage) {
      if (editableUsage == usage) {
        editableUsage.amount = amount;
      }
      return editableUsage;
    }).toList();
    state = RecipeDetailModel(
      recipeId: state.recipeId,
      recipe: state.recipe,
      isEditMode: state.isEditMode,
      editableUsages: updatedUsages,
      error: state.error,
      isLoading: state.isLoading,
    );
  }

  @override
  void updateUsageIngredient(
      EditableIngredientUsage usage, String? ingredientId) {
    var updatedUsages = state.editableUsages.map((editableUsage) {
      if (editableUsage == usage) {
        editableUsage.ingredientId = ingredientId;
      }
      return editableUsage;
    }).toList();
    state = RecipeDetailModel(
      recipeId: state.recipeId,
      recipe: state.recipe,
      isEditMode: state.isEditMode,
      editableUsages: updatedUsages,
      error: state.error,
      isLoading: state.isLoading,
    );
  }

  @override
  void updateUsageIngredientUnit(
      EditableIngredientUsage usage, String? ingredientUnitId) {
    var updatedUsages = state.editableUsages.map((editableUsage) {
      if (editableUsage == usage) {
        editableUsage.ingredientUnitId = ingredientUnitId;
      }
      return editableUsage;
    }).toList();
    state = RecipeDetailModel(
      recipeId: state.recipeId,
      recipe: state.recipe,
      isEditMode: state.isEditMode,
      editableUsages: updatedUsages,
      error: state.error,
      isLoading: state.isLoading,
    );
  }

  @override
  void dismissError() {
    state = RecipeDetailModel(
      recipeId: state.recipeId,
      recipe: state.recipe,
      isEditMode: state.isEditMode,
      editableUsages: state.editableUsages,
      isLoading: state.isLoading,
      error: null,
    );
  }
}

abstract class RecipeDetailRepository {
  Future<Recipe?> fetchRecipeById(String recipeId);
  Future<HttpPostResult> updateIngredientUsage(
      UpdateIngredientUsageRequest request);
  Future<HttpPostResult> createIngredientUsage(
      CreateIngredientUsageRequest request);
}
