class IngredientUnit {
  final String id;
  final String name;
  final String creator;
  final DateTime created;

  IngredientUnit({
    required this.id,
    required this.name,
    required this.creator,
    required this.created,
  });

  factory IngredientUnit.fromJson(Map<String, dynamic> json) {
    return IngredientUnit(
      id: json['ingredientUnitId'],
      name: json['name'],
      creator: json['creator'],
      created: DateTime.fromMillisecondsSinceEpoch(json['created']),
    );
  }

  @override
  String toString() {
    return "IngredientUnit(name=$name)";
  }
}
