import 'package:recipy_frontend/models/ingredient_unit.dart';
import 'package:freezed_annotation/freezed_annotation.dart';

part 'ingredient_units_model.freezed.dart';

@freezed
class IngredientUnitsModel with _$IngredientUnitsModel {
  const factory IngredientUnitsModel({
    @Default([]) List<IngredientUnit> units,
    @Default(false) bool isLoading,
    @Default(false) bool canAddIngredientUnits,
    @Default(false) bool canDeleteIngredientUnits,
    int? errorCode,
  }) = _IngredientUnitsModel;
}
