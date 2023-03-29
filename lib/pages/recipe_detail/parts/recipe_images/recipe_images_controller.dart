import 'dart:typed_data';

import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:logging/logging.dart';
import 'package:recipy_frontend/helpers/providers.dart';
import 'package:recipy_frontend/models/recipe_image.dart';
import 'package:recipy_frontend/pages/recipe_detail/parts/recipe_images/loadable_recipe_image.dart';
import 'package:recipy_frontend/pages/recipe_detail/parts/recipe_images/recipe_images_model.dart';
import 'package:recipy_frontend/pages/recipe_detail/parts/recipe_images/recipe_images_widget.dart';
import 'package:recipy_frontend/repositories/http_read_result.dart';
import 'package:recipy_frontend/repositories/http_write_result.dart';

class RecipeImagesControllerImpl extends RecipeImagesController {
  static final log = Logger('RecipeImagesControllerImpl');

  late RecipeImagesRepository _repository;

  RecipeImagesControllerImpl(RecipeImagesModel state) : super(state) {
    final container = ProviderContainer();
    _repository = container.read(recipeImagesRepositoryProvider);
    _init();
  }

  void _init() async {
    await _fetchRecipeImages();
  }

  Future<void> _fetchRecipeImages() async {
    state = state.copyWith(isLoading: true);

    var result = await _repository.getRecipeImagesForRecipeId(state.recipeId);

    if (result.success) {
      var loadableRecipeImages = result.data!
          .map((recipeImage) =>
              LoadableRecipeImage(isLoading: true, recipeImage: recipeImage))
          .toList();

      state = state.copyWith(
        isLoading: false,
        loadableRecipeImages: loadableRecipeImages,
      );

      for (var loadableRecipeImage in loadableRecipeImages) {
        loadBytesForRecipeImage(loadableRecipeImage.recipeImage.imageId);
      }
    } else {
      state = state.copyWith(
        isLoading: false,
        errorCode: result.errorCode,
      );
    }
  }

  void loadBytesForRecipeImage(String imageId) async {
    var result = await _repository.getImageForRecipe(state.recipeId, imageId);

    // TODO propably will conflict with each other
    var newLoadableRecipeImages =
        state.loadableRecipeImages.map((loadableRecipeImage) {
      if (loadableRecipeImage.recipeImage.imageId == imageId) {
        return LoadableRecipeImage(
          recipeImage: loadableRecipeImage.recipeImage,
          isLoading: false,
          loadingFailed: !result.success,
          imageBytes: result.data,
        );
      }
      return loadableRecipeImage;
    }).toList();

    state = state.copyWith(
      loadableRecipeImages: newLoadableRecipeImages,
    );
  }

  @override
  void addNewRecipeImage(
      String recipeId, Uint8List imageBytes, String fileExtension) async {
    await _repository.addRecipeImage(recipeId, imageBytes, fileExtension);
    _fetchRecipeImages();
  }

  @override
  void deleteRecipeImage(String recipeId, String imageId) {
    // TODO: implement deleteRecipeImage
  }

  @override
  Future<Uint8List> getRecipeImage(String recipeId, String imageId) {
    // TODO: implement getRecipeImage
    throw UnimplementedError();
  }
}

abstract class RecipeImagesRepository {
  Future<HttpReadResult<List<RecipeImage>>> getRecipeImagesForRecipeId(
      String recipeId);
  Future<HttpReadResult<Uint8List>> getImageForRecipe(
      String recipeId, String imageId);
  Future<HttpWriteResult> addRecipeImage(
      String recipeId, Uint8List bytes, String fileExtension);
}
