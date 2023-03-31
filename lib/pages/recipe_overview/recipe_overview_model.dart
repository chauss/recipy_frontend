import 'package:recipy_frontend/models/recipe_overview.dart';
import 'package:freezed_annotation/freezed_annotation.dart';

part 'recipe_overview_model.freezed.dart';

@freezed
class RecipeOverviewModel with _$RecipeOverviewModel {
  const factory RecipeOverviewModel({
    @Default([]) List<RecipeOverview> recipeOverviews,
    @Default(false) bool isLoading,
    @Default(false) bool canAddNewRecipe,
    int? errorCode,
  }) = _RecipeOverviewModel;
}
