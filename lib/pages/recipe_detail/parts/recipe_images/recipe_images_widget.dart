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

class RecipeImagesWidget extends ConsumerStatefulWidget {
  final String recipeId;
  final bool onlyDisplayTitleImage;
  final DeleteImageController? deleteController;
  final AddImageController? addController;

  const RecipeImagesWidget({
    Key? key,
    required this.recipeId,
    this.onlyDisplayTitleImage = false,
    this.deleteController,
    this.addController,
  }) : super(key: key);

  @override
  ConsumerState<RecipeImagesWidget> createState() => _RecipeImagesWidgetState();
}

class _RecipeImagesWidgetState extends ConsumerState<RecipeImagesWidget> {
  @override
  void initState() {
    widget.deleteController?.addListener(deleteCurrentImage);
    widget.addController?.addListener(addImage);
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    RecipeImagesController controller =
        ref.read(recipeImagesControllerProvider(widget.recipeId).notifier);

    RecipeImagesModel model =
        ref.watch(recipeImagesControllerProvider(widget.recipeId));

    return widget.onlyDisplayTitleImage
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
    return Stack(
      children: [
        CarouselSlider(
          options: CarouselOptions(
              disableCenter: true,
              enableInfiniteScroll: false,
              onPageChanged: (page, reason) =>
                  controller.changeCurrentImageIndex(page)),
          items: _buildImages(model.loadableRecipeImages, withBorder: true),
        ),
      ],
    );
  }

  void deleteCurrentImage() {
    RecipeImagesController controller =
        ref.read(recipeImagesControllerProvider(widget.recipeId).notifier);
    RecipeImagesModel model =
        ref.watch(recipeImagesControllerProvider(widget.recipeId));
    var imageId =
        model.loadableRecipeImages[model.currentImageIndex].recipeImage.imageId;
    controller.deleteRecipeImage(imageId);
  }

  void addImage() {
    RecipeImagesController controller =
        ref.read(recipeImagesControllerProvider(widget.recipeId).notifier);
    RecipeImagesModel model =
        ref.watch(recipeImagesControllerProvider(widget.recipeId));
    _pickImage(model, controller);
  }

  List<Widget> _buildImages(List<LoadableRecipeImage> loadableImages,
      {bool withBorder = false}) {
    List<Widget> images = [];
    if (loadableImages.isEmpty) {
      images.add(const Icon(Icons.image_not_supported_outlined));
    } else {
      images.addAll(loadableImages.map((loadableImage) {
        if (loadableImage.isLoading) {
          return const ProcessIndicator();
        } else if (loadableImage.loadingFailed) {
          return const Icon(Icons.broken_image);
        }
        return Image.memory(
          loadableImage.imageBytes!,
          alignment: Alignment.center,
          width: double.infinity,
          height: double.infinity,
          fit: BoxFit.cover,
        );
      }).toList());
    }

    if (withBorder) {
      images = images
          .map((image) => Container(
                decoration: BoxDecoration(
                    border: Border.all(
                  color: Colors.transparent,
                  width: 6,
                )),
                child: Container(
                  decoration: BoxDecoration(
                      border: Border.all(
                    color: Theme.of(context)
                        .colorScheme
                        .secondary
                        .withOpacity(0.2),
                    width: 0.5,
                  )),
                  child: image,
                ),
              ))
          .toList();
    }

    return images;
  }

  void _pickImage(
    RecipeImagesModel model,
    RecipeImagesController controller,
  ) async {
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
  void changeCurrentImageIndex(int newIndex);
}

class DeleteImageController extends ChangeNotifier {
  void deleteCurrentImage() => notifyListeners();
}

class AddImageController extends ChangeNotifier {
  void addImage() => notifyListeners();
}
