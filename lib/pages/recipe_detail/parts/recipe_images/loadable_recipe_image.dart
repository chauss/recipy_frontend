import 'dart:typed_data';

import 'package:recipy_frontend/models/recipe_image.dart';

class LoadableRecipeImage {
  final RecipeImage recipeImage;
  final bool isLoading;
  final bool loadingFailed;
  final Uint8List? imageBytes;

  LoadableRecipeImage({
    required this.recipeImage,
    this.isLoading = true,
    this.loadingFailed = false,
    this.imageBytes,
  });
}
