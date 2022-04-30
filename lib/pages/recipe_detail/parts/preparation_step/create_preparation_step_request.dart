class CreatePreparationStepRequest {
  final String recipeId;
  final int stepNumber;
  final String description;

  CreatePreparationStepRequest({
    required this.recipeId,
    required this.stepNumber,
    required this.description,
  });
}
