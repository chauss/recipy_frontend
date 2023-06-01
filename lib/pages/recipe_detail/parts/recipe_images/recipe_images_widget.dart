import 'dart:typed_data';
import 'package:path/path.dart' as path;
import 'package:carousel_slider/carousel_slider.dart';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:image_picker/image_picker.dart';
import 'package:recipy_frontend/helpers/providers.dart';
import 'package:recipy_frontend/pages/recipe_detail/parts/recipe_images/loadable_recipe_image.dart';
import 'package:recipy_frontend/pages/recipe_detail/parts/recipe_images/recipe_images_model.dart';
import 'package:recipy_frontend/widgets/process_indicator.dart';

class RecipeImagesWidget extends ConsumerWidget {
  final String recipeId;
  final bool onlyDisplayTitleImage;

  const RecipeImagesWidget({
    Key? key,
    required this.recipeId,
    this.onlyDisplayTitleImage = false,
  }) : super(key: key);

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    RecipeImagesController controller =
        ref.read(recipeImagesControllerProvider(recipeId).notifier);

    RecipeImagesModel model =
        ref.watch(recipeImagesControllerProvider(recipeId));

    return onlyDisplayTitleImage
        ? _buildTitleImageOnly(controller, model)
        : _buildImageCarousel(controller, model);
  }

  Widget _buildTitleImageOnly(
    RecipeImagesController controller,
    RecipeImagesModel model,
  ) {
    if (model.loadableRecipeImages.isNotEmpty) {
      return _buildImages([model.loadableRecipeImages.first]).first;
    } else {
      return const SizedBox(
        height: 60,
        width: double.infinity,
        child: Icon(Icons.image_not_supported_outlined),
      );
    }
  }

  Widget _buildImageCarousel(
    RecipeImagesController controller,
    RecipeImagesModel model,
  ) {
    var currentPage = 0;
    return Stack(
      children: [
        CarouselSlider(
          options: CarouselOptions(
              disableCenter: true,
              enableInfiniteScroll: false,
              onPageChanged: (page, reason) => currentPage = page),
          items: _buildImages(model.loadableRecipeImages),
        ),
        Align(
          alignment: Alignment.bottomRight,
          child: ElevatedButton(
            onPressed: () => _pickImage(model, controller),
            child: const Icon(Icons.add),
          ),
        ),
        Align(
          alignment: Alignment.topLeft,
          child: ElevatedButton(
            onPressed: () {
              var imageId =
                  model.loadableRecipeImages[currentPage].recipeImage.imageId;
              controller.deleteRecipeImage(imageId);
            },
            child: const Icon(Icons.delete),
          ),
        )
      ],
    );
  }

  List<Widget> _buildImages(List<LoadableRecipeImage> loadableImages) {
    if (loadableImages.isEmpty) {
      return [const Icon(Icons.image_not_supported_outlined)];
    }
    return loadableImages.map((loadableImage) {
      if (loadableImage.isLoading) {
        return const ProcessIndicator();
      } else if (loadableImage.loadingFailed) {
        return const Icon(Icons.broken_image);
      }
      return Image.memory(loadableImage.imageBytes!);
    }).toList();
  }

  void _pickImage(
      RecipeImagesModel model, RecipeImagesController controller) async {
    final ImagePicker picker = ImagePicker();
    try {
      XFile? selectedImage = await picker.pickImage(
        source: ImageSource.gallery,
        maxWidth: 1920,
        maxHeight: 1080,
        requestFullMetadata: true,
      );
      if (selectedImage != null) {
        final Uint8List bytes = await selectedImage.readAsBytes();
        var extention = path.extension(selectedImage.name);
        controller.addNewRecipeImage(model.recipeId, bytes, extention);
      }
    } catch (e) {
      print("Error: $e");
    }
  }
}

abstract class RecipeImagesController extends StateNotifier<RecipeImagesModel> {
  RecipeImagesController(RecipeImagesModel state) : super(state);

  void addNewRecipeImage(
      String recipeId, Uint8List imageBytes, String fileExtension);
  void deleteRecipeImage(String imageId);
}
