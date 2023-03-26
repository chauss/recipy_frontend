class RecipeImage {
  final String imageId;
  final String recipeId;
  final int index;
  final DateTime created;

  const RecipeImage({
    required this.imageId,
    required this.recipeId,
    required this.index,
    required this.created,
  });

  factory RecipeImage.fromJson(Map<String, dynamic> json) {
    return RecipeImage(
      imageId: json['imageId'],
      recipeId: json['recipeId'],
      index: json['index'],
      created: DateTime.fromMillisecondsSinceEpoch(json['created']),
    );
  }

  @override
  String toString() {
    return "RecipeImage(imageId=$imageId, recipeId=$recipeId, index=$index, created=$created)";
  }
}
