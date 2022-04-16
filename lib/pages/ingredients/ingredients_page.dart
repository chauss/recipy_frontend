import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:recipy_frontend/helpers/providers.dart';
import 'package:recipy_frontend/pages/ingredients/add_ingredient_request.dart';
import 'package:recipy_frontend/pages/ingredients/ingredients_model.dart';
import 'package:recipy_frontend/widgets/executive_textfield.dart';
import 'package:recipy_frontend/widgets/ingredient_widget.dart';
import 'package:recipy_frontend/widgets/nav_drawer.dart';
import 'package:recipy_frontend/widgets/process_indicator.dart';
import 'package:recipy_frontend/widgets/recipy_app_bar.dart';

class IngredientsPage extends ConsumerWidget {
  const IngredientsPage({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    IngredientsController controller =
        ref.read(ingredientsControllerProvider.notifier);

    IngredientsModel model = ref.watch(ingredientsControllerProvider);

    return Scaffold(
      drawer: const NavDrawer(),
      appBar: const RecipyAppBar(title: "Zutaten"),
      body: Column(
        children: [
          Expanded(child: getBody(model)),
          ExecutiveTextfield(
            addFunction: (name) =>
                controller.addIngredient(AddIngredientRequest(name: name)),
            hintText: 'Füge eine neue Zutat hinzu',
            enabled: !model.isLoading,
          ),
        ],
      ),
    );
  }

  Widget getBody(IngredientsModel model) {
    if (model.isLoading) {
      return const ProcessIndicator();
    } else if (model.error != null) {
      return Text(model.error!);
    } else {
      return ListView(
        children: model.ingredients
            .map((ingredient) => IngredientWidget(ingredient: ingredient))
            .toList(),
      );
    }
  }
}

abstract class IngredientsController extends StateNotifier<IngredientsModel> {
  IngredientsController(IngredientsModel state) : super(state);

  Future<void> addIngredient(AddIngredientRequest request);
}
