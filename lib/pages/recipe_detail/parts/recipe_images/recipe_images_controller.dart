import 'dart:typed_data';

import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:logging/logging.dart';
import 'package:recipy_frontend/config/error_config.dart';
import 'package:recipy_frontend/helpers/providers.dart';
import 'package:recipy_frontend/models/recipe_image.dart';
import 'package:recipy_frontend/models/user.dart';
import 'package:recipy_frontend/pages/recipe_detail/parts/recipe_images/loadable_recipe_image.dart';
import 'package:recipy_frontend/pages/recipe_detail/parts/recipe_images/recipe_images_model.dart';
import 'package:recipy_frontend/pages/recipe_detail/parts/recipe_images/recipe_images_widget.dart';
import 'package:recipy_frontend/pages/user/user_management_repository.dart';
import 'package:recipy_frontend/repositories/http_read_result.dart';
import 'package:recipy_frontend/repositories/http_write_result.dart';

class RecipeImagesControllerImpl extends RecipeImagesController {
  static final log = Logger('RecipeImagesControllerImpl');

  late RecipeImagesRepository _repository;
  late UserManagementRepository _userManagementRepository;

  RecipeImagesControllerImpl(RecipeImagesModel state) : super(state) {
    final container = ProviderContainer();
    _repository = container.read(recipeImagesRepositoryProvider);

    _userManagementRepository =
        container.read(userManagementRepositoryProvider);

    _userManagementRepository.addOnUserStateChangedListener(_onUserChanged);
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

    // TODO propably will conflict with each other because this is running
    // TODO parallel for each image and every thread tries to update the state
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
    String recipeId,
    Uint8List imageBytes,
    String fileExtension,
  ) async {
    User? currentUser = await _userManagementRepository.getCurrentUser();
    if (currentUser == null) {
      state = state.copyWith(
        errorCode: ErrorCodes.couldNotFindUserToAuthorizeActionWith,
        isLoading: false,
      );
      return;
    }

    await _repository.addRecipeImage(
      recipeId,
      imageBytes,
      fileExtension,
      currentUser.authToken,
    );
    _fetchRecipeImages();
  }

  @override
  void deleteRecipeImage(String imageId) async {
    User? currentUser = await _userManagementRepository.getCurrentUser();
    if (currentUser == null) {
      state = state.copyWith(
        errorCode: ErrorCodes.couldNotFindUserToAuthorizeActionWith,
        isLoading: false,
      );
      return;
    }

    await _repository.removeRecipeImage(
      state.recipeId,
      imageId,
      currentUser.authToken,
    );
    _fetchRecipeImages();
  }

  @override
  void changeCurrentImageIndex(int newIndex) {
    state = state.copyWith(currentImageIndex: newIndex);
  }

  void _onUserChanged(User? newUser) {}
}

abstract class RecipeImagesRepository {
  Future<HttpReadResult<List<RecipeImage>>> getRecipeImagesForRecipeId(
      String recipeId);
  Future<HttpReadResult<Uint8List>> getImageForRecipe(
      String recipeId, String imageId);
  Future<HttpWriteResult> addRecipeImage(
      String recipeId, Uint8List bytes, String fileExtension, String userToken);
  Future<HttpWriteResult> removeRecipeImage(
      String recipeId, String imageId, String userToken);
}
