class CreatePreparationStepRequest {
  final String recipeId;
  final int stepNumber;
  final String description;
  final String userToken;

  CreatePreparationStepRequest({
    required this.recipeId,
    required this.stepNumber,
    required this.description,
    required this.userToken,
  });
}
