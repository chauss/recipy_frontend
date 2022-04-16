import 'package:recipy_frontend/models/recipe.dart';

class RecipeOverviewModel {
  List<Recipe> recipes;
  bool isLoading;
  String? error;

  RecipeOverviewModel({
    this.recipes = const [],
    this.isLoading = false,
    this.error,
  });
}
