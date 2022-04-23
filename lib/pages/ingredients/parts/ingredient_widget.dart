import 'package:flutter/material.dart';
import 'package:recipy_frontend/models/ingredient.dart';

class IngredientWidget extends StatelessWidget {
  final Ingredient ingredient;
  final Function()? onDeleteIngredientCallback;

  const IngredientWidget({
    Key? key,
    required this.ingredient,
    this.onDeleteIngredientCallback,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Card(
      child: Container(
          padding: const EdgeInsets.all(12),
          decoration: BoxDecoration(
              border: Border.all(
                  color: Theme.of(context).primaryColorDark, width: 2),
              borderRadius: const BorderRadius.all(Radius.circular(4))),
          child: Stack(
            children: [
              Align(
                alignment: Alignment.centerLeft,
                child: Padding(
                  padding: const EdgeInsets.only(left: 16),
                  child: Text(
                    ingredient.name,
                    style: TextStyle(
                      color: Theme.of(context).primaryColorDark,
                      fontSize: 16,
                    ),
                  ),
                ),
              ),
              Align(
                alignment: Alignment.centerRight,
                child: InkWell(
                  child: Image.asset(
                    'assets/icons/trash.png',
                    height: 24,
                  ),
                  onTap: onDeleteIngredientCallback,
                ),
              ),
            ],
          )),
    );
  }
}
