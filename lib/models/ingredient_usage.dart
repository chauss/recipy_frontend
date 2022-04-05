class IngredientUnit {
  final String id;
  final String ingredientId;
  final String ingredientUnitId;
  final String recipeId;
  final double amount;
  final DateTime created;

  IngredientUnit({
    required this.id,
    required this.ingredientId,
    required this.ingredientUnitId,
    required this.recipeId,
    required this.amount,
    required this.created,
  });

  factory IngredientUnit.fromJson(Map<String, dynamic> json) {
    return IngredientUnit(
      id: json['ingredientUnitId'],
      ingredientId: json['ingredientId'],
      ingredientUnitId: json['ingredientUnitId'],
      recipeId: json['recipeId'],
      amount: double.parse(json['amount']),
      created: DateTime.fromMillisecondsSinceEpoch(json['created']),
    );
  }
}
