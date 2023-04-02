import 'package:recipy_frontend/models/ingredient_usage.dart';
import 'package:recipy_frontend/models/preparation_step.dart';
import 'package:recipy_frontend/models/recipe_image.dart';

class Recipe {
  final String id;
  final String name;
  final List<IngredientUsage> ingredientUsages;
  final List<PreparationStep> preparationSteps;
  final List<RecipeImage> recipeImages;
  final String creator;
  final DateTime created;

  const Recipe({
    required this.id,
    required this.name,
    required this.ingredientUsages,
    required this.preparationSteps,
    required this.recipeImages,
    required this.creator,
    required this.created,
  });

  factory Recipe.fromJson(Map<String, dynamic> recipeJson) {
    List<dynamic> usagesJson = recipeJson['ingredientUsages'];
    List<IngredientUsage> usages = usagesJson
        .map((usageJson) => IngredientUsage.fromJson(usageJson))
        .toList();

    List<dynamic> preparationStepsJson = recipeJson['preparationSteps'];
    List<PreparationStep> preparationSteps = preparationStepsJson
        .map((preparationStepJson) =>
            PreparationStep.fromJson(preparationStepJson))
        .toList();

    List<dynamic> recipeImagesJson = recipeJson['recipeImages'];
    List<RecipeImage> recipeImages = recipeImagesJson
        .map((recipeImageJson) => RecipeImage.fromJson(recipeImageJson))
        .toList();

    return Recipe(
      id: recipeJson['recipeId'],
      name: recipeJson['name'],
      ingredientUsages: usages,
      preparationSteps: preparationSteps,
      recipeImages: recipeImages,
      creator: recipeJson['creator'],
      created: DateTime.fromMillisecondsSinceEpoch(recipeJson['created']),
    );
  }

  @override
  String toString() {
    return "Recipe(name=$name, usages=${ingredientUsages.length}, steps=${preparationSteps.length})";
  }
}
