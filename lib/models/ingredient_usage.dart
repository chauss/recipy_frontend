class IngredientUsage {
  final String id;
  final String ingredientId;
  final String ingredientUnitId;
  final String recipeId;
  final double amount;
  final DateTime created;

  IngredientUsage({
    required this.id,
    required this.ingredientId,
    required this.ingredientUnitId,
    required this.recipeId,
    required this.amount,
    required this.created,
  });

  factory IngredientUsage.fromJson(Map<String, dynamic> json) {
    return IngredientUsage(
      id: json['ingredientUsageId'],
      ingredientId: json['ingredientId'],
      ingredientUnitId: json['ingredientUnitId'],
      recipeId: json['recipeId'],
      amount: json['amount'],
      created: DateTime.fromMillisecondsSinceEpoch(json['created']),
    );
  }

  @override
  String toString() {
    return "IngredientUsage(id=$id, amount=$amount)";
  }
}
