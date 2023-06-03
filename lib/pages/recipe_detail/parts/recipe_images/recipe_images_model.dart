import 'package:freezed_annotation/freezed_annotation.dart';
import 'package:recipy_frontend/pages/recipe_detail/parts/recipe_images/loadable_recipe_image.dart';

part 'recipe_images_model.freezed.dart';

@freezed
class RecipeImagesModel with _$RecipeImagesModel {
  const factory RecipeImagesModel({
    required String recipeId,
    @Default(true) bool isLoading,
    @Default([]) List<LoadableRecipeImage> loadableRecipeImages,
    @Default(0) int currentImageIndex,
    int? errorCode,
  }) = _RecipeImagesModel;
}
