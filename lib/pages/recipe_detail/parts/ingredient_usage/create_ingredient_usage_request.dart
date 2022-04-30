class CreateIngredientUsageRequest {
  final String recipeId;
  final String ingredientId;
  final String ingredientUnitId;
  final double amount;

  CreateIngredientUsageRequest({
    required this.recipeId,
    required this.ingredientId,
    required this.ingredientUnitId,
    required this.amount,
  });
}
