import 'package:recipy_frontend/models/recipe.dart';
import 'package:recipy_frontend/pages/recipe_detail/parts/editable_ingredient_usage.dart';

class RecipeDetailModel {
  String recipeId;
  bool isLoading;
  String? error;
  Recipe? recipe;
  bool isEditMode;
  List<EditableIngredientUsage> editableUsages;

  RecipeDetailModel({
    required this.recipeId,
    this.isLoading = false,
    this.error,
    this.recipe,
    this.isEditMode = false,
    this.editableUsages = const [],
  });
}
