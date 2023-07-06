import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:recipy_frontend/helpers/providers.dart';
import 'package:recipy_frontend/models/ingredient.dart';

typedef BuildWithIngredient = Widget Function(BuildContext context,
    List<Ingredient> allIngredients, Ingredient? ingredient);

class WithIngredientBuilder extends ConsumerWidget {
  final String? ingredientId;
  final BuildWithIngredient builder;

  const WithIngredientBuilder({
    super.key,
    this.ingredientId,
    required this.builder,
  });

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final allIngredients = ref.read(inMemoryStorageProvider).getIngredients();
    allIngredients.sort((a, b) => a.name.compareTo(b.name));
    Ingredient? ingredient;
    if (ingredientId != null) {
      try {
        ingredient = allIngredients.firstWhere((ing) => ing.id == ingredientId);
      } on StateError catch (_) {}
    }
    return builder(context, allIngredients, ingredient);
  }
}
