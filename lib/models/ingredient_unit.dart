import 'dart:html';

class IngredientUnit {
  final String id;
  final String name;
  final DateTime created;

  IngredientUnit({required this.id, required this.name, required this.created});

  factory IngredientUnit.fromJson(Map<String, dynamic> json) {
    return IngredientUnit(
      id: json['ingredientUnitId'],
      name: json['name'],
      created: DateTime.fromMillisecondsSinceEpoch(json['created']),
    );
  }

  @override
  String toString() {
    return "IngredientUnit(name=$name)";
  }
}
