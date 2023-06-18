class Ingredient {
  final String id;
  final String name;
  final String creator;
  final DateTime created;

  Ingredient({
    required this.id,
    required this.name,
    required this.creator,
    required this.created,
  });

  factory Ingredient.fromJson(Map<String, dynamic> json) {
    return Ingredient(
      id: json['ingredientId'],
      name: json['name'],
      creator: json['creator'],
      created: DateTime.fromMillisecondsSinceEpoch(json['created']),
    );
  }

  @override
  String toString() {
    return "Ingredient(name=$name)";
  }
}
