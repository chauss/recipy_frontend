class DeleteIngredientRequest {
  final String ingredientId;
  final String userToken;

  DeleteIngredientRequest({
    required this.ingredientId,
    required this.userToken,
  });
}
