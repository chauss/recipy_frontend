import 'package:flutter/material.dart';
import 'package:recipy_frontend/models/preparation_step.dart';
import 'package:easy_localization/easy_localization.dart';

class PreparationStepWidget extends StatelessWidget {
  final PreparationStep step;

  const PreparationStepWidget({
    Key? key,
    required this.step,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Text(
          "recipe_details.step_number",
          style: Theme.of(context).textTheme.titleMedium,
        ).tr(namedArgs: {'stepNumber': step.stepNumber.toString()}),
        Text(step.description),
        const SizedBox(height: 16),
      ],
    );
  }
}
