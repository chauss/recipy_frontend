import 'package:flutter/material.dart';
import 'package:recipy_frontend/pages/recipe_detail/parts/preparation_step/editable_preparation_step.dart';
import 'package:recipy_frontend/widgets/custom_text_field.dart';

class EditPreparationStepWidget extends StatelessWidget {
  final EditablePreparationStep step;
  final Function(String) onDescriptionChanged;
  final Function()? onDeletePreparationStepCallback;

  final TextEditingController descriptionController;

  EditPreparationStepWidget({
    Key? key,
    required this.step,
    required this.onDescriptionChanged,
    this.onDeletePreparationStepCallback,
  })  : descriptionController = TextEditingController(text: step.description),
        super(key: key);

  @override
  Widget build(BuildContext context) {
    return Row(
      children: [
        buildStep(context),
        buildActions(),
      ],
    );
  }

  Widget buildStep(BuildContext context) {
    return Expanded(
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Text(
            step.stepNumber.toString(),
            style: Theme.of(context).textTheme.headline5,
          ),
          CustomTextField(
            controller: descriptionController,
            isMultiline: true,
            keyboardType: TextInputType.multiline,
            onChanged: onDescriptionChanged,
          ),
        ],
      ),
    );
  }

  Widget buildActions() {
    return InkWell(
      child: Image.asset(
        'assets/icons/trash.png',
        width: 28,
      ),
      onTap: onDeletePreparationStepCallback,
    );
  }
}
