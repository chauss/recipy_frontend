import 'dart:io';

import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:recipy_frontend/helpers/providers.dart';
import 'package:recipy_frontend/models/recipe.dart';
import 'package:recipy_frontend/pages/recipe_detail/parts/ingredient_usage/create_ingredient_usage_request.dart';
import 'package:recipy_frontend/pages/recipe_detail/parts/ingredient_usage/delete_ingredient_usage_request.dart';
import 'package:recipy_frontend/pages/recipe_detail/parts/preparation_step/create_preparation_step_request.dart';
import 'package:recipy_frontend/pages/recipe_detail/parts/preparation_step/delete_preparation_step_request.dart';
import 'package:recipy_frontend/pages/recipe_detail/parts/preparation_step/update_preparation_step_request.dart';
import 'package:recipy_frontend/pages/recipe_detail/parts/recipe/delete_recipe_request.dart';
import 'package:recipy_frontend/pages/recipe_detail/parts/ingredient_usage/editable_ingredient_usage.dart';
import 'package:recipy_frontend/pages/recipe_detail/parts/preparation_step/editable_preparation_step.dart';
import 'package:recipy_frontend/pages/recipe_detail/recipe_detail_model.dart';
import 'package:recipy_frontend/pages/recipe_detail/recipe_detail_page.dart';
import 'package:recipy_frontend/pages/recipe_detail/parts/ingredient_usage/update_ingredient_usage_request.dart';
import 'package:recipy_frontend/repositories/http_read_result.dart';
import 'package:recipy_frontend/repositories/http_write_result.dart';

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

    print(result.data);

    state = state.copyWith(
      recipe: result.data,
      errorCode: result.errorCode,
      isLoading: false,
      isEditMode: false,
      editableUsages: [],
      editableSteps: [],
    );
  }

  @override
  void enterEditMode() {
    state = state.copyWith(
      isEditMode: true,
      editableUsages: (state.recipe?.ingredientUsages ?? [])
          .map((usage) => EditableIngredientUsage.fromIngredientUsage(usage))
          .toList(),
      editableSteps: (state.recipe?.preparationSteps ?? [])
          .map((step) => EditablePreparationStep.fromPreparationStep(step))
          .toList(),
    );
  }

  @override
  Future<void> saveChanges() async {
    bool somethingChanged = false;

    try {
      somethingChanged |= await _saveIngredientUsages();
      somethingChanged |= await _savePreparationSteps();
    } on HttpException catch (_) {
      // ErrorCode has been set
      return;
    }

    if (somethingChanged) {
      await _fetchRecipe();
    } else {
      state = state.copyWith(
        isEditMode: false,
        editableUsages: [],
        editableSteps: [],
      );
    }
  }

  Future<bool> _saveIngredientUsages() async {
    bool somethingChanged = false;

    for (var editableUsage in state.editableUsages) {
      if (!editableUsage.canBeSaved()) continue;

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
          state = state.copyWith(errorCode: result.errorCode);
          throw HttpException(result.message ?? "");
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
          state = state.copyWith(errorCode: result.errorCode);
          throw HttpException(result.message ?? "");
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

    return somethingChanged;
  }

  Future<bool> _savePreparationSteps() async {
    bool somethingChanged = false;

    for (var editableStep in state.editableSteps) {
      try {
        var existingPreparationStep = state.recipe!.preparationSteps.firstWhere(
            (preparationStep) => preparationStep.id == editableStep.id);
        // Check if information changed
        if (editableStep.stepNumber == existingPreparationStep.stepNumber &&
            editableStep.description == existingPreparationStep.description) {
          continue;
        }
        somethingChanged = true;
        var result = await _repository
            .updatePreparationStep(UpdatePreparationStepRequest(
          preparationStepId: existingPreparationStep.id,
          stepNumber: editableStep.stepNumber,
          description: editableStep.description,
        ));
        if (!result.success) {
          state = state.copyWith(errorCode: result.errorCode);
          throw HttpException(result.message ?? "");
        }
      } on StateError catch (_) {
        // IngredientUsage is new
        somethingChanged = true;
        var result = await _repository
            .createPreparationStep(CreatePreparationStepRequest(
          recipeId: state.recipeId,
          stepNumber: editableStep.stepNumber,
          description: editableStep.description,
        ));
        if (!result.success) {
          state = state.copyWith(errorCode: result.errorCode);
          throw HttpException(result.message ?? "");
        }
      }
    }
    // Check if existing steps have been deleted
    var originalStepCount = state.recipe?.preparationSteps.length ?? 0;
    var currentStepCount =
        state.editableUsages.where((step) => step.id != null).length;
    if (originalStepCount != currentStepCount) {
      somethingChanged = true;
    }

    return somethingChanged;
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
  void dismissError() => state = state.copyWith(errorCode: null);

  @override
  void deleteIngredientUsage(DeleteIngredientUsageRequest request) async {
    // TODO Move remote deletion to save
    if (request.ingredientUsage.id != null) {
      var result =
          await _repository.deleteIngredientUsage(request.ingredientUsage.id!);
      if (!result.success) {
        state = state.copyWith(errorCode: result.errorCode);
        return;
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
        errorCode: result.errorCode,
        isLoading: false,
      );
    }
    return result.success;
  }

  @override
  void addNewPreparationStep() {
    state = state.copyWith(editableSteps: [
      ...state.editableSteps,
      EditablePreparationStep(
        recipeId: state.recipeId,
        stepNumber: state.editableSteps.length + 1,
        description: "",
      )
    ]);
  }

  @override
  void updateStepDescription(EditablePreparationStep step, String description) {
    var updatedSteps = state.editableSteps.map((editableStep) {
      if (editableStep == step) {
        editableStep.description = description;
      }
      return editableStep;
    }).toList();
    state = state.copyWith(editableSteps: updatedSteps);
  }

  @override
  void deletePreparationStep(DeletePreparationStepRequest request) async {
    // TODO Move remote deletion to save
    if (request.preparationStep.id != null) {
      var result =
          await _repository.deletePreparationStep(request.preparationStep.id!);
      if (!result.success) {
        state = state.copyWith(errorCode: result.errorCode);
        return;
      }
    }

    var newEditableSteps = [...state.editableSteps];
    newEditableSteps.remove(request.preparationStep);
    state = state.copyWith(editableSteps: newEditableSteps);
  }
}

abstract class RecipeDetailRepository {
  Future<HttpReadResult<Recipe>> fetchRecipeById(String recipeId);
  Future<HttpWriteResult> deleteRecipeById(DeleteRecipeRequest request);

  Future<HttpWriteResult> createIngredientUsage(
      CreateIngredientUsageRequest request);
  Future<HttpWriteResult> updateIngredientUsage(
      UpdateIngredientUsageRequest request);
  Future<HttpWriteResult> deleteIngredientUsage(String ingredientUsageId);

  Future<HttpWriteResult> createPreparationStep(
      CreatePreparationStepRequest request);
  Future<HttpWriteResult> updatePreparationStep(
      UpdatePreparationStepRequest request);
  Future<HttpWriteResult> deletePreparationStep(String preparationStepId);
}
