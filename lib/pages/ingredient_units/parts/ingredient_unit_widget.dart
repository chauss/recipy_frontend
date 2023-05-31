import 'package:flutter/material.dart';
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
    return Card(
      child: Container(
        width: 200,
        padding: const EdgeInsets.all(12),
        decoration: BoxDecoration(
            border: Border.all(
                color: Theme.of(context).primaryColorLight, width: .3),
            borderRadius: const BorderRadius.all(Radius.circular(4))),
        child: Stack(
          children: [
            Align(
              alignment: Alignment.centerLeft,
              child: Padding(
                padding: const EdgeInsets.only(left: 16),
                child: Text(
                  ingredientUnit.name,
                  style: const TextStyle(fontSize: 16),
                ),
              ),
            ),
            Align(
              alignment: Alignment.centerRight,
              child: InkWell(
                onTap: onDeleteIngredientUnitCallback,
                child: Image.asset('assets/icons/trash.png',
                    height: 24, color: Colors.white70),
              ),
            ),
          ],
        ),
      ),
    );
  }
}
