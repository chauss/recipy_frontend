import 'package:recipy_frontend/models/ingredient_usage.dart';
import 'package:recipy_frontend/models/preparation_step.dart';

class Recipe {
  final String id;
  final String name;
  final DateTime created;
  final List<IngredientUsage> ingredientUsages;
  final List<PreparationStep> preparationSteps;

  const Recipe({
    required this.id,
    required this.name,
    required this.created,
    required this.ingredientUsages,
    required this.preparationSteps,
  });

  factory Recipe.fromJson(Map<String, dynamic> recipeJson) {
    List<dynamic> usagesJson = recipeJson['ingredientUsages'];
    List<IngredientUsage> usages = usagesJson
        .map((usageJson) => IngredientUsage.fromJson(usageJson))
        .toList();

    List<dynamic> preparationStepsJson = recipeJson['preparationSteps'];
    print(recipeJson);
    List<PreparationStep> preparationSteps = preparationStepsJson
        .map((preparationStepJson) =>
            PreparationStep.fromJson(preparationStepJson))
        .toList();

    return Recipe(
      id: recipeJson['recipeId'],
      name: recipeJson['name'],
      created: DateTime.fromMillisecondsSinceEpoch(recipeJson['created']),
      ingredientUsages: usages,
      preparationSteps: preparationSteps,
    );
  }

  @override
  String toString() {
    return "Recipe(name=$name, usages=${ingredientUsages.length}, steps=${preparationSteps.length})";
  }
}
