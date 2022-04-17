class AddIngredientUsageRequest {
  final String recipeId;
  final String ingredientId;
  final String ingredientUnitId;
  final double amount;

  AddIngredientUsageRequest({
    required this.recipeId,
    required this.ingredientId,
    required this.ingredientUnitId,
    required this.amount,
  });
}
