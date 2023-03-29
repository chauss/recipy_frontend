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

  const RecipeImagesWidget({Key? key, required this.recipeId})
      : super(key: key);

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    RecipeImagesController controller =
        ref.read(recipeImagesControllerProvider(recipeId).notifier);

    RecipeImagesModel model =
        ref.watch(recipeImagesControllerProvider(recipeId));

    return Stack(
      children: [
        CarouselSlider(
          options: CarouselOptions(
            disableCenter: true,
            enableInfiniteScroll: false,
          ),
          items: buildImages(model.loadableRecipeImages),
        ),
        Align(
          alignment: Alignment.bottomRight,
          child: ElevatedButton(
            onPressed: () => pickImage(model, controller),
            child: const Icon(Icons.add),
          ),
        )
      ],
    );
  }

  List<Widget> buildImages(List<LoadableRecipeImage> loadableImages) {
    return loadableImages.map((loadableImage) {
      if (loadableImage.isLoading) {
        return const ProcessIndicator();
      } else if (loadableImage.loadingFailed) {
        return const Icon(Icons.broken_image);
      }
      return Image.memory(loadableImage.imageBytes!);
    }).toList();
  }

  void pickImage(
      RecipeImagesModel model, RecipeImagesController controller) async {
    final ImagePicker picker = ImagePicker();
    try {
      XFile? selectedImage = await picker.pickImage(
        source: ImageSource.camera,
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
  Future<Uint8List> getRecipeImage(String recipeId, String imageId);
  void deleteRecipeImage(String recipeId, String imageId);
}
