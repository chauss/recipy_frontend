import 'package:recipy_frontend/models/recipe.dart';
import 'package:recipy_frontend/pages/recipe_detail/parts/editable_ingredient_usage.dart';
import 'package:freezed_annotation/freezed_annotation.dart';

part 'recipe_detail_model.freezed.dart';

@freezed
class RecipeDetailModel with _$RecipeDetailModel {
  const factory RecipeDetailModel({
    required String recipeId,
    @Default(false) bool isLoading,
    @Default(false) bool isEditMode,
    @Default([]) List<EditableIngredientUsage> editableUsages,
    String? error,
    Recipe? recipe,
  }) = _RecipeDetailModel;
}
