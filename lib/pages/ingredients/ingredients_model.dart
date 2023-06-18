import 'package:recipy_frontend/models/ingredient.dart';
import 'package:freezed_annotation/freezed_annotation.dart';

part 'ingredients_model.freezed.dart';

@freezed
class IngredientsModel with _$IngredientsModel {
  const factory IngredientsModel({
    @Default([]) List<Ingredient> ingredients,
    @Default(false) bool isLoading,
    @Default(false) bool canAddIngredients,
    @Default(false) bool canDeleteIngredients,
    int? errorCode,
  }) = _IngredientsModel;
}
