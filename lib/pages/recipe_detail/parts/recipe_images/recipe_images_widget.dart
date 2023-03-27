import 'dart:typed_data';

import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:recipy_frontend/models/recipe_image.dart';
import 'package:recipy_frontend/pages/recipe_detail/parts/recipe_images/recipe_images_model.dart';

class RecipeImagesWidget extends ConsumerWidget {
  final String recipeId;
  final List<RecipeImage> recipeImages;

  const RecipeImagesWidget(
      {Key? key, required this.recipeId, required this.recipeImages})
      : super(key: key);

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    return Container(color: Colors.red, height: 20, width: 20);
  }
}

abstract class RecipeImagesController extends StateNotifier<RecipeImagesModel> {
  RecipeImagesController(RecipeImagesModel state) : super(state);

  void addNewRecipeImage(
      String recipeId, Uint8List imageBytes, String fileExtension);
  Future<Uint8List> getRecipeImage(String recipeId, String imageId);
  void deleteRecipeImage(String recipeId, String imageId);
}
