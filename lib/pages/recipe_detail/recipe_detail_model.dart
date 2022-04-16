import 'package:recipy_frontend/models/recipe.dart';

class RecipeDetailModel {
  String recipeId;
  bool isLoading;
  String? error;
  Recipe? recipe;
  bool isEditMode;

  RecipeDetailModel({
    required this.recipeId,
    this.isLoading = false,
    this.error,
    this.recipe,
    this.isEditMode = false,
  });
}
