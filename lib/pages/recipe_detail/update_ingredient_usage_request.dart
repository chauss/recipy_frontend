class UpdateIngredientUsageRequest {
  final String ingredientUsageId;
  final double amount;
  final String ingredientId;
  final String ingredientUnitId;

  UpdateIngredientUsageRequest({
    required this.ingredientUsageId,
    required this.amount,
    required this.ingredientId,
    required this.ingredientUnitId,
  });
}
