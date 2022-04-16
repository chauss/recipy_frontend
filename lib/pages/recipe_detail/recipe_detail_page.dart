import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:recipy_frontend/helpers/providers.dart';
import 'package:recipy_frontend/models/ingredient_usage.dart';
import 'package:recipy_frontend/pages/recipe_detail/recipe_detail_model.dart';
import 'package:recipy_frontend/widgets/ingredient_usage_widget.dart';

class RecipeDetailPage extends ConsumerWidget {
  final String recipeId;

  const RecipeDetailPage({Key? key, required this.recipeId}) : super(key: key);

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    RecipeDetailController controller =
        ref.read(recipeDetailControllerProvider(recipeId).notifier);

    RecipeDetailModel model =
        ref.watch(recipeDetailControllerProvider(recipeId));

    return Scaffold(
      appBar: AppBar(
        title: Text(model.recipe?.name ?? ""),
        actions: [
          Padding(
            padding: const EdgeInsets.only(right: 8),
            child: IconButton(
              onPressed: controller.toggleEditMode,
              icon: model.isEditMode
                  ? const Icon(Icons.check)
                  : const Icon(Icons.edit),
            ),
          )
        ],
      ),
      body: ListView(
        padding: const EdgeInsets.only(left: 24, right: 24, top: 32),
        children: buildIngredientUsages(model),
      ),
    );
  }

  List<Widget> buildIngredientUsages(RecipeDetailModel model) {
    if (model.recipe == null) {
      return [Container()];
    }

    return model.recipe!.ingredientUsages
        .map((usage) => buildIngredientUsage(model, usage))
        .toList();
  }

  Widget buildIngredientUsage(RecipeDetailModel model, IngredientUsage usage) {
    return Container(
      margin: const EdgeInsets.only(bottom: 12),
      child: IngredientUsageWidget(
        usage: usage,
        isEditMode: model.isEditMode,
      ),
    );
  }
}

abstract class RecipeDetailController extends StateNotifier<RecipeDetailModel> {
  RecipeDetailController(RecipeDetailModel state) : super(state);

  void toggleEditMode();
}
