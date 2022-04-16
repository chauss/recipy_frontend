import 'package:recipy_frontend/models/ingredient_usage.dart';

class Recipe {
  final String id;
  final String name;
  final DateTime created;
  final List<IngredientUsage> ingredientUsages;

  const Recipe({
    required this.id,
    required this.name,
    required this.created,
    required this.ingredientUsages,
  });

  factory Recipe.fromJson(Map<String, dynamic> recipeJson) {
    List<dynamic> usagesJson = recipeJson['ingredientUsages'];
    List<IngredientUsage> usages = usagesJson
        .map((usageJson) => IngredientUsage.fromJson(usageJson))
        .toList();

    return Recipe(
      id: recipeJson['recipeId'],
      name: recipeJson['name'],
      created: DateTime.fromMillisecondsSinceEpoch(recipeJson['created']),
      ingredientUsages: usages,
    );
  }

  @override
  String toString() {
    return "Recipe(name=$name, usages=${ingredientUsages.length})";
  }
}
