import 'package:recipy_frontend/models/preparation_step.dart';

class EditablePreparationStep {
  String? id;
  String recipeId;
  int stepNumber;
  String description;

  EditablePreparationStep({
    this.id,
    required this.recipeId,
    required this.stepNumber,
    required this.description,
  });

  factory EditablePreparationStep.fromPreparationStep(PreparationStep step) {
    return EditablePreparationStep(
      id: step.id,
      recipeId: step.recipeId,
      stepNumber: step.stepNumber,
      description: step.description,
    );
  }
}
