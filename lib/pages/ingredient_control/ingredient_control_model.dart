import 'package:recipy_frontend/models/ingredient.dart';

class IngredientControlModel {
  List<Ingredient> ingredients;
  bool isLoading;
  String? error;

  IngredientControlModel({
    this.ingredients = const [],
    this.isLoading = false,
    this.error,
  });
}
