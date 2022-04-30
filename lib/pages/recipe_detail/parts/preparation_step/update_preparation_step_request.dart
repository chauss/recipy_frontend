class UpdatePreparationStepRequest {
  final String preparationStepId;
  final int stepNumber;
  final String description;

  UpdatePreparationStepRequest({
    required this.preparationStepId,
    required this.stepNumber,
    required this.description,
  });
}
