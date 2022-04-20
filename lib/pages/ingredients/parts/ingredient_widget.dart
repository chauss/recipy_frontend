import 'package:flutter/material.dart';
import 'package:intl/intl.dart';
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
              Text(ingredient.name),
              Text(DateFormat.Hm().format(ingredient.created)),
              Text(DateFormat.yMMMd().format(ingredient.created)),
            ],
          ),
          InkWell(
            child: Image.asset(
              'assets/icons/trash.png',
              width: 28,
            ),
            onTap: onDeleteIngredientCallback,
          ),
        ],
      ),
    );
  }
}
