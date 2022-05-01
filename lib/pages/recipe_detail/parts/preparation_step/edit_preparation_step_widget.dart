import 'package:flutter/material.dart';
import 'package:recipy_frontend/pages/recipe_detail/parts/preparation_step/editable_preparation_step.dart';
import 'package:recipy_frontend/widgets/custom_text_field.dart';
import 'package:easy_localization/easy_localization.dart';

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
    return Column(
      children: [
        buildHeader(context),
        CustomTextField(
          controller: descriptionController,
          isMultiline: true,
          keyboardType: TextInputType.multiline,
          onFocusLost: onDescriptionChanged,
          onChanged: onDescriptionChanged,
          onChangedDebounceMs: 700,
          hintText: "recipe_details.edit_step.textfield.hint".tr(),
        ),
      ],
    );
  }

  Widget buildHeader(BuildContext context) {
    return Row(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Text(
          "recipe_details.step_number",
          style: Theme.of(context).textTheme.subtitle1,
        ).tr(namedArgs: {'stepNumber': step.stepNumber.toString()}),
        Expanded(child: Container()),
        InkWell(
          child: Image.asset(
            'assets/icons/trash.png',
            width: 20,
          ),
          onTap: onDeletePreparationStepCallback,
        ),
        const SizedBox(width: 20),
        ReorderableDragStartListener(
          index: step.stepNumber - 1,
          child: const Icon(Icons.drag_handle),
        ),
      ],
    );
  }
}
