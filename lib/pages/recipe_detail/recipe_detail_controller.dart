import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:recipy_frontend/helpers/providers.dart';
import 'package:recipy_frontend/models/recipe.dart';
import 'package:recipy_frontend/pages/recipe_detail/parts/add_ingredient_usage_request.dart';
import 'package:recipy_frontend/pages/recipe_detail/parts/delete_ingredient_usage_request.dart';
import 'package:recipy_frontend/pages/recipe_detail/parts/delete_recipe_request.dart';
import 'package:recipy_frontend/pages/recipe_detail/parts/editable_ingredient_usage.dart';
import 'package:recipy_frontend/pages/recipe_detail/recipe_detail_model.dart';
import 'package:recipy_frontend/pages/recipe_detail/recipe_detail_page.dart';
import 'package:recipy_frontend/pages/recipe_detail/parts/update_ingredient_usage_request.dart';
import 'package:recipy_frontend/repositories/http_read_result.dart';
import 'package:recipy_frontend/repositories/http_write_result.dart';
import 'package:easy_localization/easy_localization.dart';

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
    var result = await _repository.fetchRecipeById(state.recipeId);

    state = state.copyWith(
      recipe: result.data,
      error: result.error,
      isLoading: false,
      isEditMode: false,
      editableUsages: [],
    );
  }

  @override
  void enterEditMode() {
    state = state.copyWith(
      isEditMode: true,
      editableUsages: (state.recipe?.ingredientUsages ?? [])
          .map((usage) => EditableIngredientUsage.fromIngredientUsage(usage))
          .toList(),
    );
  }

  @override
  Future<void> saveChanges() async {
    bool somethingChanged = false;
    for (var editableUsage in state.editableUsages) {
      // Check if information is valid
      if (editableUsage.amount == null ||
          editableUsage.ingredientId == null ||
          editableUsage.ingredientUnitId == null) {
        state =
            state.copyWith(error: "recipe_details.edit_usage.dialog.info".tr());
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
        somethingChanged = true;
        var result = await _repository
            .updateIngredientUsage(UpdateIngredientUsageRequest(
          ingredientUsageId: existingIngredientUsage.id,
          amount: editableUsage.amount!,
          ingredientId: editableUsage.ingredientId!,
          ingredientUnitId: editableUsage.ingredientUnitId!,
        ));
        if (!result.success) {
          state = state.copyWith(error: result.error);
          return;
        }
      } on StateError catch (_) {
        // IngredientUsage is new
        somethingChanged = true;
        var result = await _repository
            .createIngredientUsage(CreateIngredientUsageRequest(
          recipeId: state.recipeId,
          amount: editableUsage.amount!,
          ingredientId: editableUsage.ingredientId!,
          ingredientUnitId: editableUsage.ingredientUnitId!,
        ));
        if (!result.success) {
          state = state.copyWith(error: result.error);
          return;
        }
      }
    }
    // Check if existing usages have been deleted
    var originalUsageCount = state.recipe?.ingredientUsages.length ?? 0;
    var currentUsageCount =
        state.editableUsages.where((usage) => usage.id != null).length;
    if (originalUsageCount != currentUsageCount) {
      somethingChanged = true;
    }
    if (somethingChanged) {
      await _fetchRecipe();
    } else {
      state = state.copyWith(isEditMode: false);
    }
  }

  @override
  void addNewIngredientUsage() {
    state = state.copyWith(editableUsages: [
      ...state.editableUsages,
      EditableIngredientUsage(amount: 1)
    ]);
  }

  @override
  void updateUsageAmount(EditableIngredientUsage usage, double amount) {
    var updatedUsages = state.editableUsages.map((editableUsage) {
      if (editableUsage == usage) {
        editableUsage.amount = amount;
      }
      return editableUsage;
    }).toList();
    state = state.copyWith(editableUsages: updatedUsages);
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
    state = state.copyWith(editableUsages: updatedUsages);
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
    state = state.copyWith(editableUsages: updatedUsages);
  }

  @override
  void dismissError() {
    state = state.copyWith(error: null);
  }

  @override
  void deleteIngredientUsage(DeleteIngredientUsageRequest request) async {
    if (request.ingredientUsage.id != null) {
      var result =
          await _repository.deleteIngredientUsage(request.ingredientUsage.id!);
      if (!result.success) {
        state = state.copyWith(error: result.error);
      }
    }

    var newUsages = [...state.editableUsages];
    newUsages.remove(request.ingredientUsage);
    state = state.copyWith(editableUsages: newUsages);
  }

  @override
  Future<bool> deleteRecipe(DeleteRecipeRequest request) async {
    state = state.copyWith(isLoading: true);
    var result = await _repository.deleteRecipeById(request);
    if (result.success) {
      state = state.copyWith(
        recipe: null,
        isLoading: false,
      );
    } else {
      state = state.copyWith(
        error: result.error,
        isLoading: false,
      );
    }
    return result.success;
  }
}

abstract class RecipeDetailRepository {
  Future<HttpReadResult<Recipe>> fetchRecipeById(String recipeId);
  Future<HttpWriteResult> updateIngredientUsage(
      UpdateIngredientUsageRequest request);
  Future<HttpWriteResult> createIngredientUsage(
      CreateIngredientUsageRequest request);
  Future<HttpWriteResult> deleteIngredientUsage(String ingredientUsageId);
  Future<HttpWriteResult> deleteRecipeById(DeleteRecipeRequest request);
}
