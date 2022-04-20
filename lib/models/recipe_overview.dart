class RecipeOverview {
  final String id;
  final String name;
  final DateTime created;

  const RecipeOverview({
    required this.id,
    required this.name,
    required this.created,
  });

  factory RecipeOverview.fromJson(Map<String, dynamic> recipeOverviewJson) {
    return RecipeOverview(
      id: recipeOverviewJson['recipeId'],
      name: recipeOverviewJson['name'],
      created:
          DateTime.fromMillisecondsSinceEpoch(recipeOverviewJson['created']),
    );
  }

  @override
  String toString() {
    return "RecipeOverview(name=$name)";
  }
}
