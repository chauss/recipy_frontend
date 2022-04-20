import 'package:flutter/material.dart';
import 'package:intl/intl.dart';
import 'package:recipy_frontend/models/ingredient_unit.dart';

class IngredientUnitWidget extends StatelessWidget {
  final IngredientUnit ingredientUnit;
  final Function()? onDeleteIngredientUnitCallback;

  const IngredientUnitWidget({
    Key? key,
    required this.ingredientUnit,
    this.onDeleteIngredientUnitCallback,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Container(
      width: 200,
      margin: const EdgeInsets.all(10),
      padding: const EdgeInsets.all(20),
      decoration: BoxDecoration(
          border: Border.all(color: Colors.blueAccent),
          borderRadius: const BorderRadius.all(Radius.circular(4))),
      child: Row(
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        children: [
          Container(),
          Column(
            children: [
              Text(ingredientUnit.name),
              Text(DateFormat.Hm().format(ingredientUnit.created)),
              Text(DateFormat.yMMMd().format(ingredientUnit.created)),
            ],
          ),
          InkWell(
            child: Image.asset(
              'assets/icons/trash.png',
              width: 28,
            ),
            onTap: onDeleteIngredientUnitCallback,
          ),
        ],
      ),
    );
  }
}
