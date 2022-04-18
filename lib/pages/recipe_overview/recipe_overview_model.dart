import 'package:recipy_frontend/models/recipe_overview.dart';

class RecipeOverviewModel {
  List<RecipeOverview> recipeOverviews;
  bool isLoading;
  String? error;

  RecipeOverviewModel({
    this.recipeOverviews = const [],
    this.isLoading = false,
    this.error,
  });
}
