class Recipe {
  final String id;
  final String name;
  final DateTime created;

  const Recipe({
    required this.id,
    required this.name,
    required this.created,
  });

  factory Recipe.fromJson(Map<String, dynamic> json) {
    return Recipe(
      id: json['recipeId'],
      name: json['name'],
      created: DateTime.fromMillisecondsSinceEpoch(json['created']),
    );
  }
}
