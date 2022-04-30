class PreparationStep {
  final String id;
  final String recipeId;
  final int stepNumber;
  final String description;

  const PreparationStep({
    required this.id,
    required this.recipeId,
    required this.stepNumber,
    required this.description,
  });

  factory PreparationStep.fromJson(Map<String, dynamic> preparationStepJson) =>
      PreparationStep(
        id: preparationStepJson['preparationStepId'],
        recipeId: preparationStepJson['recipeId'],
        stepNumber: preparationStepJson['stepNumber'],
        description: preparationStepJson['description'],
      );
}
