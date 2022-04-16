import 'package:recipy_frontend/models/ingredient_unit.dart';

class IngredientUnitsModel {
  List<IngredientUnit> units;
  bool isLoading;
  String? error;

  IngredientUnitsModel({
    this.units = const [],
    this.isLoading = false,
    this.error,
  });
}
