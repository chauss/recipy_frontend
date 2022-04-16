import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:recipy_frontend/models/ingredient_unit.dart';
import 'package:recipy_frontend/pages/ingredient_control/add_ingredient_request.dart';
import 'package:recipy_frontend/pages/ingredient_control/ingredient_control_controller.dart';
import 'package:recipy_frontend/pages/ingredient_control/ingredient_control_model.dart';
import 'package:recipy_frontend/repositories/ingredient_unit_repository.dart';
import 'package:recipy_frontend/widgets/executive_textfield.dart';
import 'package:recipy_frontend/widgets/future_list_widget.dart';
import 'package:recipy_frontend/widgets/ingredient_unit_widget.dart';
import 'package:recipy_frontend/widgets/ingredient_widget.dart';
import 'package:recipy_frontend/widgets/nav_drawer.dart';

class IngredientsControlPage extends ConsumerWidget {
  final GlobalKey<ScaffoldState> _scaffoldKey = GlobalKey<ScaffoldState>();

  IngredientsControlPage({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    IngredientControlController controller =
        ref.read(ingredientControlControllerProvider.notifier);

    IngredientControlModel model =
        ref.watch(ingredientControlControllerProvider);

    return DefaultTabController(
      length: 2,
      child: Scaffold(
        key: _scaffoldKey,
        drawer: const NavDrawer(),
        appBar: AppBar(
          leading: InkWell(
            child: const Image(
              image: AssetImage('assets/burger-icon.png'),
              width: 40,
            ),
            onTap: () => _scaffoldKey.currentState?.openDrawer(),
          ),
          title: const Text("Zutaten Verwaltung"),
          bottom: TabBar(
            tabs: [
              Tab(
                child: Row(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: const [
                    Icon(CupertinoIcons.barcode),
                    SizedBox(width: 4),
                    Text("Zutaten")
                  ],
                ),
              ),
              Tab(
                child: Row(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: const [
                    Icon(CupertinoIcons.greaterthan_square),
                    SizedBox(width: 4),
                    Text("Einheiten")
                  ],
                ),
              ),
            ],
          ),
        ),
        body: TabBarView(children: [
          buildIngredientsTab(controller, model),
          buildIngredientUnitsTab(),
        ]),
      ),
    );
  }

  Widget buildIngredientsTab(IngredientControlController controller,
          IngredientControlModel model) =>
      Column(
        children: [
          Expanded(child: buildIngredientsList(model)),
          ExecutiveTextfield(
            addFunction: (name) =>
                controller.addIngredient(AddIngredientRequest(name: name)),
            hintText: 'Füge eine neue Zutat hinzu',
          ),
        ],
      );

  Widget buildIngredientsList(IngredientControlModel model) {
    return ListView(
      children: model.ingredients
          .map((ingredient) => IngredientWidget(ingredient: ingredient))
          .toList(),
    );
  }

  Widget buildIngredientUnitsTab() => Column(
        children: [
          Expanded(child: buildIngredientUnitsList()),
          ExecutiveTextfield(
            addFunction: IngredientUnitRepository.addIngredientUnit,
            hintText: 'Füge eine neue Einheit hinzu',
          ),
        ],
      );

  FutureListWidget<IngredientUnit> buildIngredientUnitsList() {
    return FutureListWidget<IngredientUnit>(
      fetch: IngredientUnitRepository.fetchIngredientUnits,
      widgetBuilder: (ingredientUnit) =>
          IngredientUnitWidget(ingredientUnit: ingredientUnit),
    );
  }
}

final StateNotifierProvider<IngredientControlController, IngredientControlModel>
    ingredientControlControllerProvider =
    StateNotifierProvider<IngredientControlController, IngredientControlModel>(
  (ref) => IngredintControlControllerImpl(IngredientControlModel()),
);

abstract class IngredientControlController
    extends StateNotifier<IngredientControlModel> {
  IngredientControlController(IngredientControlModel state) : super(state);

  Future addIngredient(AddIngredientRequest request);
}
