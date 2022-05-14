import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:logging/logging.dart';
import 'package:recipy_frontend/config/error_config.dart';
import 'package:recipy_frontend/helpers/providers.dart';
import 'package:recipy_frontend/models/ingredient_usage.dart';
import 'package:recipy_frontend/models/preparation_step.dart';
import 'package:recipy_frontend/models/recipe.dart';
import 'package:recipy_frontend/pages/recipe_detail/parts/ingredient_usage/create_ingredient_usage_request.dart';
import 'package:recipy_frontend/pages/recipe_detail/parts/ingredient_usage/delete_ingredient_usage_request.dart';
import 'package:recipy_frontend/pages/recipe_detail/parts/preparation_step/create_preparation_step_request.dart';
import 'package:recipy_frontend/pages/recipe_detail/parts/preparation_step/delete_preparation_step_request.dart';
import 'package:recipy_frontend/pages/recipe_detail/parts/preparation_step/update_preparation_step_request.dart';
import 'package:recipy_frontend/pages/recipe_detail/parts/recipe/delete_recipe_request.dart';
import 'package:recipy_frontend/pages/recipe_detail/parts/ingredient_usage/editable_ingredient_usage.dart';
import 'package:recipy_frontend/pages/recipe_detail/parts/preparation_step/editable_preparation_step.dart';
import 'package:recipy_frontend/pages/recipe_detail/parts/save_exception.dart';
import 'package:recipy_frontend/pages/recipe_detail/recipe_detail_model.dart';
import 'package:recipy_frontend/pages/recipe_detail/recipe_detail_page.dart';
import 'package:recipy_frontend/pages/recipe_detail/parts/ingredient_usage/update_ingredient_usage_request.dart';
import 'package:recipy_frontend/repositories/http_read_result.dart';
import 'package:recipy_frontend/repositories/http_write_result.dart';

class RecipeDetailControllerImpl extends RecipeDetailController {
  static final log = Logger('RecipeDetailControllerImpl');

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

    result.data?.preparationSteps
        .sort((a, b) => a.stepNumber.compareTo(b.stepNumber));

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
    var editableSteps = state.recipe?.preparationSteps
            .map((step) => EditablePreparationStep.fromPreparationStep(step))
            .toList() ??
        [];
    editableSteps.sort((a, b) => a.stepNumber.compareTo(b.stepNumber));

    state = state.copyWith(
      isEditMode: true,
      editableUsages: (state.recipe?.ingredientUsages ?? [])
          .map((usage) => EditableIngredientUsage.fromIngredientUsage(usage))
          .toList(),
      editableSteps: editableSteps,
    );
  }

  @override
  void discardChanges() {
    state = state.copyWith(
      editableUsages: [],
      editableSteps: [],
      isEditMode: false,
    );
  }

  @override
  Future<void> saveChanges() async {
    bool somethingChanged = false;

    try {
      somethingChanged |= await _saveIngredientUsages();
      somethingChanged |= await _savePreparationSteps();
    } on SaveException catch (e) {
      log.warning(
          "Error occured while saving recipe changes: ErrorCode(${e.errorCode}) => ${e.message}");
      state = state.copyWith(errorCode: e.errorCode);
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

    for (EditableIngredientUsage editableUsage in state.editableUsages) {
      if (!editableUsage.canBeSaved()) {
        throw SaveException(
            message: "EditableUsage $editableUsage can not be saved",
            errorCode: ErrorCodes.ingredientUsageCanNotBeSaved);
      }
    }

    for (IngredientUsage existingUsage
        in state.recipe?.ingredientUsages ?? []) {
      try {
        // Throws StateError when no item is found
        var correspondingEditableUsage = state.editableUsages.firstWhere(
            (editableUsage) => editableUsage.id == existingUsage.id);
        // UPDATE: EditableUsage still exists and might has changed
        // Check if information changed
        var newAmount = double.parse(correspondingEditableUsage.amount!);
        if (existingUsage.amount == newAmount &&
            existingUsage.ingredientId ==
                correspondingEditableUsage.ingredientId &&
            existingUsage.ingredientUnitId ==
                correspondingEditableUsage.ingredientUnitId) {
          continue;
        }
        somethingChanged = true;
        var result = await _repository
            .updateIngredientUsage(UpdateIngredientUsageRequest(
          ingredientUsageId: existingUsage.id,
          amount: newAmount,
          ingredientId: correspondingEditableUsage.ingredientId!,
          ingredientUnitId: correspondingEditableUsage.ingredientUnitId!,
        ));
        if (!result.success) {
          throw SaveException(
              message: result.message ?? "", errorCode: result.errorCode ?? -1);
        }
      } on StateError catch (_) {
        // DELETE: EditableUsage has been deleted by user so delete existing on remote
        somethingChanged = true;
        var result = await _repository.deleteIngredientUsage(existingUsage.id);
        if (!result.success) {
          throw SaveException(
              message: result.message ?? "", errorCode: result.errorCode ?? -1);
        }
      }
    }

    // CREATE: All editableUsages without id are new and need to be created on remote
    for (var editableUsage in state.editableUsages) {
      if (editableUsage.id == null) {
        if (!editableUsage.canBeSaved()) {
          throw SaveException(
              message: "EditableUsage $editableUsage can not be saved",
              errorCode: ErrorCodes.ingredientUsageCanNotBeSaved);
        }
        somethingChanged = true;
        var result = await _repository
            .createIngredientUsage(CreateIngredientUsageRequest(
          recipeId: state.recipeId,
          amount: double.parse(editableUsage.amount!),
          ingredientId: editableUsage.ingredientId!,
          ingredientUnitId: editableUsage.ingredientUnitId!,
        ));
        if (!result.success) {
          throw SaveException(
              message: result.message ?? "", errorCode: result.errorCode ?? -1);
        }
      }
    }

    return somethingChanged;
  }

  Future<bool> _savePreparationSteps() async {
    bool somethingChanged = false;

    for (PreparationStep existingStep in state.recipe?.preparationSteps ?? []) {
      try {
        // Throws state error if none was found
        var correspondingEditableStep = state.editableSteps
            .firstWhere((editableStep) => editableStep.id == existingStep.id);
        // UPDATE: Existing step still exists and might need an update
        // Check if information changed
        if (existingStep.stepNumber == correspondingEditableStep.stepNumber &&
            existingStep.description == correspondingEditableStep.description) {
          continue;
        }
        somethingChanged = true;
        var result = await _repository
            .updatePreparationStep(UpdatePreparationStepRequest(
          preparationStepId: existingStep.id,
          stepNumber: correspondingEditableStep.stepNumber,
          description: correspondingEditableStep.description,
        ));
        if (!result.success) {
          throw SaveException(
              message: result.message ?? "", errorCode: result.errorCode ?? -1);
        }
      } on StateError catch (_) {
        // DELETE: Existing step does not exist anymore and needs to be deleted on remote
        somethingChanged = true;
        var result = await _repository.deletePreparationStep(existingStep.id);
        if (!result.success) {
          throw SaveException(
              message: result.message ?? "", errorCode: result.errorCode ?? -1);
        }
      }
    }

    // CREATE: All editable steps without id are new and need to be created on remote
    for (var editableStep in state.editableSteps) {
      if (editableStep.id == null) {
        somethingChanged = true;

        var result = await _repository
            .createPreparationStep(CreatePreparationStepRequest(
          recipeId: state.recipeId,
          stepNumber: editableStep.stepNumber,
          description: editableStep.description,
        ));
        if (!result.success) {
          throw SaveException(
              message: result.message ?? "", errorCode: result.errorCode ?? -1);
        }
      }
    }

    return somethingChanged;
  }

  @override
  void addNewIngredientUsage() {
    state = state.copyWith(editableUsages: [
      ...state.editableUsages,
      EditableIngredientUsage(amount: "1")
    ]);
  }

  @override
  void updateUsageAmount(EditableIngredientUsage usage, String amount) {
    for (var editableUsage in state.editableUsages) {
      if (editableUsage == usage) {
        editableUsage.amount = amount;
        break;
      }
    }
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
  void reorderPreparationSteps(int start, int current) {
    var newEditableSteps = [...state.editableSteps];

    // e.g. start(4) > current(1)
    // 1     1
    // 2  x  5
    // 3  |  2
    // 4  |  3
    // 5  |  4
    if (start > current) {
      var startStepNumber = newEditableSteps[current].stepNumber;
      for (int i = current; i < start; i++) {
        newEditableSteps[i].stepNumber = newEditableSteps[i + 1].stepNumber;
      }
      newEditableSteps[start].stepNumber = startStepNumber;
    }
    // e.g. start(1) < current(4)
    // 1     1
    // 2  |  3
    // 3  |  4
    // 4  x  2
    // 5     5
    else if (start < current) {
      var end = current - 1;
      var endStepNumber = newEditableSteps[end].stepNumber;
      for (int i = end - 1; i >= start; i--) {
        newEditableSteps[i + 1].stepNumber = newEditableSteps[i].stepNumber;
      }
      newEditableSteps[start].stepNumber = endStepNumber;
    }

    newEditableSteps.sort((a, b) => a.stepNumber.compareTo(b.stepNumber));
    state = state.copyWith(editableSteps: newEditableSteps);
  }

  @override
  void updateStepDescription(EditablePreparationStep step, String description) {
    for (var editableStep in state.editableSteps) {
      if (editableStep == step) {
        editableStep.description = description;
        break;
      }
    }
  }

  @override
  void deletePreparationStep(DeletePreparationStepRequest request) {
    var newEditableSteps = [...state.editableSteps];
    var deletedIndex = newEditableSteps.indexOf(request.preparationStep);
    newEditableSteps.remove(request.preparationStep);
    for (int i = deletedIndex; i < newEditableSteps.length; i++) {
      newEditableSteps[i].stepNumber = newEditableSteps[i].stepNumber - 1;
    }
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
