import 'package:recipy_frontend/models/recipe.dart';
import 'package:recipy_frontend/pages/recipe_detail/parts/preparation_step/editable_preparation_step.dart';
import 'package:recipy_frontend/pages/recipe_detail/parts/ingredient_usage/editable_ingredient_usage.dart';
import 'package:freezed_annotation/freezed_annotation.dart';

part 'recipe_detail_model.freezed.dart';

@freezed
class RecipeDetailModel with _$RecipeDetailModel {
  const factory RecipeDetailModel({
    required String recipeId,
    @Default(false) bool isLoading,
    @Default(false) bool isEditMode,
    @Default([]) List<EditableIngredientUsage> editableUsages,
    @Default([]) List<EditablePreparationStep> editableSteps,
    @Default(false) canDeleteRecipe,
    int? errorCode,
    Recipe? recipe,
  }) = _RecipeDetailModel;
}
