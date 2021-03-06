import 'package:recipy_frontend/models/ingredient_usage.dart';

class EditableIngredientUsage {
  String? id;
  String? ingredientId;
  String? ingredientUnitId;
  String? recipeId;
  String? amount;

  EditableIngredientUsage({
    this.id,
    this.ingredientId,
    this.ingredientUnitId,
    this.recipeId,
    this.amount,
  });

  factory EditableIngredientUsage.fromIngredientUsage(IngredientUsage usage) {
    return EditableIngredientUsage(
      id: usage.id,
      ingredientId: usage.ingredientId,
      ingredientUnitId: usage.ingredientUnitId,
      recipeId: usage.recipeId,
      amount: usage.amount.toString(),
    );
  }

  bool canBeSaved() {
    return amount != null &&
        double.tryParse(amount!) != null &&
        ingredientId != null &&
        ingredientUnitId != null;
  }
}
