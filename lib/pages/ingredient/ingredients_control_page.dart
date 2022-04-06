import 'package:flutter/material.dart';
import 'package:recipy_frontend/models/ingredient.dart';
import 'package:recipy_frontend/models/ingredient_unit.dart';
import 'package:recipy_frontend/repositories/ingredient_repository.dart';
import 'package:recipy_frontend/widgets/future_list_widget.dart';
import 'package:recipy_frontend/widgets/ingredient_unit_widget.dart';
import 'package:recipy_frontend/widgets/ingredient_widget.dart';

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
        appBar: AppBar(
          title: const Text("Zutaten Control Center"),
          bottom: const TabBar(
            tabs: [
              Tab(icon: Icon(Icons.local_pizza)),
              Tab(icon: Icon(Icons.receipt)),
            ],
          ),
        ),
        body: TabBarView(children: [
          buildIngredientsList(),
          buildIngredientUnitsList(),
        ]),
      ),
    );
    // FloatingActionButton(
    //   onPressed: () => Navigator.push(
    //     context,
    //     MaterialPageRoute(builder: (context) => const AddIngredientPage()),
    //   ).then((addedNewIngredient) {
    //     if (addedNewIngredient == true) {
    //       setState(() {});
    //     }
    //   }),
    //   tooltip: 'Add new ingredient',
    //   child: const Icon(Icons.add),
    // )
  }

  FutureListWidget<Ingredient> buildIngredientsList() {
    return FutureListWidget<Ingredient>(
      heading: "Zutaten",
      fetch: IngredientRepository.fetchIngredients,
      widgetBuilder: (ingredient) => IngredientWidget(ingredient: ingredient),
    );
  }

  FutureListWidget<IngredientUnit> buildIngredientUnitsList() {
    return FutureListWidget<IngredientUnit>(
      heading: "Einheiten",
      fetch: IngredientRepository.fetchIngredientUnits,
      widgetBuilder: (ingredientUnit) =>
          IngredientUnitWidget(ingredientUnit: ingredientUnit),
    );
  }
}
