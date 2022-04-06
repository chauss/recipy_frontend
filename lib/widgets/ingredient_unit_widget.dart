import 'package:flutter/material.dart';
import 'package:intl/intl.dart';
import 'package:recipy_frontend/models/ingredient_unit.dart';

class IngredientUnitWidget extends StatelessWidget {
  final IngredientUnit ingredientUnit;

  const IngredientUnitWidget({Key? key, required this.ingredientUnit})
      : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Container(
      width: 200,
      margin: const EdgeInsets.all(10),
      padding: const EdgeInsets.all(20),
      decoration: BoxDecoration(
          border: Border.all(color: Colors.blueAccent),
          borderRadius: const BorderRadius.all(Radius.circular(4))),
      child: Column(
        children: [
          Text(ingredientUnit.name),
          Text(DateFormat.Hm().format(ingredientUnit.created)),
          Text(DateFormat.yMMMd().format(ingredientUnit.created)),
        ],
      ),
    );
  }
}
