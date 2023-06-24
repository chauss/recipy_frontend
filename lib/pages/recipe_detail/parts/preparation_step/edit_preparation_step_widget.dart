import 'package:flutter/material.dart';
import 'package:recipy_frontend/pages/recipe_detail/parts/preparation_step/editable_preparation_step.dart';
import 'package:recipy_frontend/widgets/recipy_text_field.dart';
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
        RecipyTextField(
          controller: descriptionController,
          isMultiline: true,
          keyboardType: TextInputType.multiline,
          onFocusLost: onDescriptionChanged,
          onChanged: onDescriptionChanged,
          onChangedDebounceMs: 0,
          hintText: "recipe_details.edit_mode.step.textfield.hint".tr(),
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
          style: Theme.of(context).textTheme.titleMedium,
        ).tr(namedArgs: {'stepNumber': step.stepNumber.toString()}),
        Expanded(child: Container()),
        InkWell(
          onTap: onDeletePreparationStepCallback,
          child: const Icon(Icons.delete_forever_outlined),
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
