class Ingredient {
  final String id;
  final String name;
  final DateTime created;

  Ingredient({required this.id, required this.name, required this.created});

  factory Ingredient.fromJson(Map<String, dynamic> json) {
    return Ingredient(
      id: json['ingredientId'],
      name: json['name'],
      created: DateTime.fromMillisecondsSinceEpoch(
        (json['created'] * 1000).round(),
      ),
    );
  }
}
