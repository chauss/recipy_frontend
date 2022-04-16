import 'package:recipy_frontend/models/ingredient.dart';

class IngredientsModel {
  List<Ingredient> ingredients;
  bool isLoading;
  String? error;

  IngredientsModel({
    this.ingredients = const [],
    this.isLoading = false,
    this.error,
  });
}
