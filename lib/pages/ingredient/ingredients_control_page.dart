import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:recipy_frontend/models/ingredient.dart';
import 'package:recipy_frontend/models/ingredient_unit.dart';
import 'package:recipy_frontend/repositories/ingredient_repository.dart';
import 'package:recipy_frontend/repositories/ingredient_unit_repository.dart';
import 'package:recipy_frontend/widgets/executive_textfield.dart';
import 'package:recipy_frontend/widgets/future_list_widget.dart';
import 'package:recipy_frontend/widgets/ingredient_unit_widget.dart';
import 'package:recipy_frontend/widgets/ingredient_widget.dart';
import 'package:recipy_frontend/widgets/nav_drawer.dart';

class IngredientsControlPage extends StatefulWidget {
  const IngredientsControlPage({Key? key}) : super(key: key);

  @override
  State<StatefulWidget> createState() => _IngredientsControlPageState();
}

class _IngredientsControlPageState extends State<IngredientsControlPage> {
  @override
  Widget build(BuildContext context) {
    return DefaultTabController(
      length: 2,
      child: Scaffold(
        drawer: const NavDrawer(),
        appBar: AppBar(
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
          buildIngredientsTab(),
          buildIngredientUnitsTab(),
        ]),
      ),
    );
  }

  Widget buildIngredientsTab() => Column(
        children: [
          Expanded(child: buildIngredientsList()),
          ExecutiveTextfield(
            addFunction: IngredientRepository.addIngredient,
            resultCallback: (success) => {if (success) setState(() {})},
            hintText: 'Füge eine neue Zutat hinzu',
          ),
        ],
      );

  FutureListWidget<Ingredient> buildIngredientsList() {
    return FutureListWidget<Ingredient>(
      fetch: IngredientRepository.fetchIngredients,
      widgetBuilder: (ingredient) => IngredientWidget(ingredient: ingredient),
    );
  }

  Widget buildIngredientUnitsTab() => Column(
        children: [
          Expanded(child: buildIngredientUnitsList()),
          ExecutiveTextfield(
            addFunction: IngredientUnitRepository.addIngredientUnit,
            resultCallback: (success) => {if (success) setState(() {})},
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
