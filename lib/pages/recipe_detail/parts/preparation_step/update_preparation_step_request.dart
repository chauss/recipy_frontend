class UpdatePreparationStepRequest {
  final String preparationStepId;
  final int stepNumber;
  final String description;
  final String userToken;

  UpdatePreparationStepRequest({
    required this.preparationStepId,
    required this.stepNumber,
    required this.description,
    required this.userToken,
  });
}
