import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:logging/logging.dart';
import 'package:recipy_frontend/config/error_config.dart';
import 'package:recipy_frontend/helpers/providers.dart';
import 'package:recipy_frontend/models/ingredient_usage.dart';
import 'package:recipy_frontend/models/preparation_step.dart';
import 'package:recipy_frontend/models/recipe.dart';
import 'package:recipy_frontend/models/user.dart';
import 'package:recipy_frontend/pages/recipe_detail/parts/ingredient_usage/create_ingredient_usage_request.dart';
import 'package:recipy_frontend/pages/recipe_detail/parts/ingredient_usage/delete_ingredient_usage_request.dart';
import 'package:recipy_frontend/pages/recipe_detail/parts/preparation_step/create_preparation_step_request.dart';
import 'package:recipy_frontend/pages/recipe_detail/parts/preparation_step/delete_preparation_step_request.dart';
import 'package:recipy_frontend/pages/recipe_detail/parts/preparation_step/update_preparation_step_request.dart';
import 'package:recipy_frontend/pages/recipe_detail/parts/ingredient_usage/editable_ingredient_usage.dart';
import 'package:recipy_frontend/pages/recipe_detail/parts/preparation_step/editable_preparation_step.dart';
import 'package:recipy_frontend/pages/recipe_detail/parts/save_exception.dart';
import 'package:recipy_frontend/pages/recipe_detail/recipe_detail_model.dart';
import 'package:recipy_frontend/pages/recipe_detail/recipe_detail_page.dart';
import 'package:recipy_frontend/pages/recipe_detail/parts/ingredient_usage/update_ingredient_usage_request.dart';
import 'package:recipy_frontend/pages/user/user_management_repository.dart';
import 'package:recipy_frontend/repositories/http_read_result.dart';
import 'package:recipy_frontend/repositories/http_write_result.dart';

class RecipeDetailControllerImpl extends RecipeDetailController {
  static final log = Logger('RecipeDetailControllerImpl');

  late RecipeDetailRepository _repository;
  late UserManagementRepository _userManagementRepository;

  RecipeDetailControllerImpl(RecipeDetailModel state) : super(state) {
    final container = ProviderContainer();
    _repository = container.read(recipeDetailRepositoryProvider);

    _userManagementRepository =
        container.read(userManagementRepositoryProvider);

    _userManagementRepository.addOnUserStateChangedListener(_onUserChanged);

    _init();
  }

  void _init() async {
    log.fine("Going to initialize RecipeDetailController...");
    await _fetchRecipe();
    // NOTE: must come after _fetchRecipe because we compare user with the recipe creator
    _onUserChanged(await _userManagementRepository.getCurrentUser());
    log.info("Initialized RecipeDetailController.");
  }

  Future<void> _fetchRecipe() async {
    log.fine("Going to fetch recipe with id=${state.recipeId}...");
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
    log.info(
        "Fetched recipe with id=${state.recipeId}. Success=${result.success}. ErrorCode=${result.errorCode}.");
  }

  @override
  void enterEditMode() {
    log.fine(
        "Going to enter edit mode for recipe with id=${state.recipeId}...");
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
    log.info("Entered edit mode for recipe with id=${state.recipeId}...");
  }

  @override
  void discardChanges() {
    state = state.copyWith(
      editableUsages: [],
      editableSteps: [],
      isEditMode: false,
    );
    log.info(
        "Discarded changes from editing recipe with id=${state.recipeId}.");
  }

  @override
  Future<void> saveChanges() async {
    log.fine(
        "Going to save changes from editing recipe with id=${state.recipeId}...");
    bool somethingChanged = false;

    User? currentUser = await _userManagementRepository.getCurrentUser();
    if (currentUser == null) {
      state = state.copyWith(
        errorCode: ErrorCodes.couldNotFindUserToAuthorizeActionWith,
        isLoading: false,
      );
      log.info("Could not save changes. CurrentUser is null.");
      return;
    }

    try {
      somethingChanged |= await _saveIngredientUsages(currentUser.authToken);
      somethingChanged |= await _savePreparationSteps(currentUser.authToken);
    } on SaveException catch (e) {
      log.warning(
          "Error occured while saving recipe changes: ErrorCode(${e.errorCode}) => ${e.message}");
      state = state.copyWith(errorCode: e.errorCode);
      return;
    }

    if (somethingChanged) {
      log.fine(
          "Going to refetch recipe because something changed during editing...");
      await _fetchRecipe();
    } else {
      state = state.copyWith(
        isEditMode: false,
        editableUsages: [],
        editableSteps: [],
      );
    }
  }

  Future<bool> _saveIngredientUsages(String userToken) async {
    log.fine("Going to save ingredient usages for recipe ${state.recipeId}...");
    bool somethingChanged = false;

    for (EditableIngredientUsage editableUsage in state.editableUsages) {
      if (!editableUsage.canBeSaved()) {
        throw SaveException(
            message: "EditableUsage $editableUsage can not be saved",
            errorCode: ErrorCodes.ingredientUsageCanNotBeSaved);
      }
    }

    log.fine("Going to update all existing and changed ingredientUsages...");
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
          userToken: userToken,
        ));
        log.fine(
            "Tried to update ingredientUsageId=${existingUsage.id}. Success=${result.success}");
        if (!result.success) {
          throw SaveException(
              message: result.message ?? "", errorCode: result.errorCode ?? -1);
        }
      } on StateError catch (_) {
        // DELETE: EditableUsage has been deleted by user so delete existing on remote
        log.fine("Going to delete ingredientUsageId=${existingUsage.id}...");
        somethingChanged = true;
        var result = await _repository.deleteIngredientUsage(
          existingUsage.id,
          userToken,
        );
        if (!result.success) {
          throw SaveException(
              message: result.message ?? "", errorCode: result.errorCode ?? -1);
        }
      }
    }

    // CREATE: All editableUsages without id are new and need to be created on remote
    log.fine("Going to create all new ingredientUsages...");
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
          userToken: userToken,
        ));
        if (!result.success) {
          throw SaveException(
              message: result.message ?? "", errorCode: result.errorCode ?? -1);
        }
      }
    }

    log.info(
        "Successfully updated ingredient usages for recipeId=${state.recipeId}. SomethingChanged=$somethingChanged");

    return somethingChanged;
  }

  Future<bool> _savePreparationSteps(String userToken) async {
    log.fine("Going to save preparation steps for recipe ${state.recipeId}...");
    bool somethingChanged = false;

    log.fine("Going to update existing preparation steps that changed...");
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
          userToken: userToken,
        ));
        if (!result.success) {
          throw SaveException(
              message: result.message ?? "", errorCode: result.errorCode ?? -1);
        }
      } on StateError catch (_) {
        // DELETE: Existing step does not exist anymore and needs to be deleted on remote
        log.fine("Going to delete preparationStepId=${existingStep.id}...");
        somethingChanged = true;
        var result = await _repository.deletePreparationStep(
          existingStep.id,
          userToken,
        );
        if (!result.success) {
          throw SaveException(
              message: result.message ?? "", errorCode: result.errorCode ?? -1);
        }
      }
    }

    // CREATE: All editable steps without id are new and need to be created on remote
    log.fine("Going to create all new prepration steps...");
    for (var editableStep in state.editableSteps) {
      if (editableStep.id == null) {
        somethingChanged = true;

        var result = await _repository
            .createPreparationStep(CreatePreparationStepRequest(
          recipeId: state.recipeId,
          stepNumber: editableStep.stepNumber,
          description: editableStep.description,
          userToken: userToken,
        ));
        if (!result.success) {
          throw SaveException(
              message: result.message ?? "", errorCode: result.errorCode ?? -1);
        }
      }
    }

    log.info(
        "Successfully updated prepration steps for recipeId=${state.recipeId}. SomethingChanged=$somethingChanged");

    return somethingChanged;
  }

  @override
  void addNewIngredientUsage() {
    log.fine("Adding new ingredient usage...");
    state = state.copyWith(editableUsages: [
      ...state.editableUsages,
      EditableIngredientUsage(amount: "1")
    ]);
  }

  @override
  void updateUsageAmount(EditableIngredientUsage usage, String amount) {
    log.fine(
        "Updating ingredient usage amount. IngredientUsageId=${usage.id}. Amount=$amount...");
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
    log.fine(
        "Updating ingredient usage ingredientId. IngredientUsageId=${usage.id}. IngredientId=$ingredientId...");
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
    log.fine(
        "Updating ingredient usage ingredientUnitId. IngredientUsageId=${usage.id}. IngredientUnitId=$ingredientUnitId...");
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
    log.fine(
        "Removing ingredient usage. IngredientUsageId=${request.ingredientUsage.id}...");
    var newUsages = [...state.editableUsages];
    newUsages.remove(request.ingredientUsage);
    state = state.copyWith(editableUsages: newUsages);
  }

  @override
  Future<bool> deleteRecipe() async {
    log.fine("Going to delete recipe with id=${state.recipeId}...");
    state = state.copyWith(isLoading: true);
    User? currentUser = await _userManagementRepository.getCurrentUser();
    if (currentUser == null) {
      state = state.copyWith(
        errorCode: ErrorCodes.couldNotFindUserToAuthorizeActionWith,
        isLoading: false,
      );
      log.fine("Could not delete recipe. CurrentUser is null.");
      return false;
    }
    var result = await _repository.deleteRecipeById(
        state.recipeId, currentUser.authToken);
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

    log.fine(
        "Done deleting recipe with id=${state.recipeId}. Success=${result.success}. ErrorCode=${result.errorCode}");
    return result.success;
  }

  @override
  void addNewPreparationStep() {
    log.fine("Going to add new preparation step...");
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
    log.fine(
        "Going to reorder preparation step. State=$start. Current=$current...");
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
    log.fine(
        "Updating prepration step description for prepartionStepId=${step.id}...");
    for (var editableStep in state.editableSteps) {
      if (editableStep == step) {
        editableStep.description = description;
        break;
      }
    }
  }

  @override
  void deletePreparationStep(DeletePreparationStepRequest request) {
    log.fine(
        "Removing prepration step with prepartionStepId=${request.preparationStep.id}...");
    var newEditableSteps = [...state.editableSteps];
    var deletedIndex = newEditableSteps.indexOf(request.preparationStep);
    newEditableSteps.remove(request.preparationStep);
    for (int i = deletedIndex; i < newEditableSteps.length; i++) {
      newEditableSteps[i].stepNumber = newEditableSteps[i].stepNumber - 1;
    }
    state = state.copyWith(editableSteps: newEditableSteps);
  }

  void _onUserChanged(User? newUser) {
    log.info("Logged in user changed. NewUserId=${newUser?.userId}");
    var canDeleteRecipe =
        newUser != null && newUser.userId == state.recipe?.creator;
    state = state.copyWith(
      canDeleteRecipe: canDeleteRecipe,
      canEditRecipe: canDeleteRecipe,
    );
  }
}

abstract class RecipeDetailRepository {
  Future<HttpReadResult<Recipe>> fetchRecipeById(String recipeId);
  Future<HttpWriteResult> deleteRecipeById(String recipeId, String userToken);

  Future<HttpWriteResult> createIngredientUsage(
      CreateIngredientUsageRequest request);
  Future<HttpWriteResult> updateIngredientUsage(
      UpdateIngredientUsageRequest request);
  Future<HttpWriteResult> deleteIngredientUsage(
    String ingredientUsageId,
    String userToken,
  );

  Future<HttpWriteResult> createPreparationStep(
      CreatePreparationStepRequest request);
  Future<HttpWriteResult> updatePreparationStep(
      UpdatePreparationStepRequest request);
  Future<HttpWriteResult> deletePreparationStep(
    String preparationStepId,
    String userToken,
  );
}
