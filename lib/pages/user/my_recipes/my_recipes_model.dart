import 'package:freezed_annotation/freezed_annotation.dart';
import 'package:recipy_frontend/models/recipe_overview.dart';

part 'my_recipes_model.freezed.dart';

@freezed
class MyRecipesModel with _$MyRecipesModel {
  const factory MyRecipesModel({
    @Default([]) List<RecipeOverview> recipeOverviews,
    @Default(true) bool hasValidUserLoggedIn,
    @Default(false) bool isLoading,
    int? errorCode,
  }) = _MyRecipesModel;
}
