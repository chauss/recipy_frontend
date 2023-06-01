class RecipeOverview {
  final String id;
  final String name;
  final String creator;
  final DateTime created;

  const RecipeOverview({
    required this.id,
    required this.name,
    required this.creator,
    required this.created,
  });

  factory RecipeOverview.fromJson(Map<String, dynamic> recipeOverviewJson) {
    return RecipeOverview(
      id: recipeOverviewJson['recipeId'],
      name: recipeOverviewJson['name'],
      creator: recipeOverviewJson['creator'],
      created:
          DateTime.fromMillisecondsSinceEpoch(recipeOverviewJson['created']),
    );
  }

  @override
  String toString() {
    return "RecipeOverview(name=$name)";
  }
}
