import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:recipy_frontend/helpers/providers.dart';
import 'package:recipy_frontend/models/ingredient_unit.dart';
import 'package:recipy_frontend/pages/ingredient_units/add_unit_request.dart';
import 'package:recipy_frontend/pages/ingredient_units/ingredient_units_model.dart';
import 'package:recipy_frontend/pages/ingredient_units/ingredient_units_page.dart';
import 'package:recipy_frontend/repositories/http_request_result.dart';

class IngredientUnitsControllerImpl extends IngredientUnitsController {
  late IngredientUnitRepository _repository;

  IngredientUnitsControllerImpl(IngredientUnitsModel state) : super(state) {
    final container = ProviderContainer();
    _repository = container.read(ingredientUnitRepositoryProvider);
    _init();
  }

  void _init() async {
    await _fetchIngredients();
  }

  Future _fetchIngredients() async {
    try {
      state = IngredientUnitsModel(
        isLoading: true,
      );
      var units = await _repository.fetchIngredientUnits();
      state = IngredientUnitsModel(
        units: units,
        isLoading: false,
      );
    } catch (e) {
      state = IngredientUnitsModel(
        error: e.toString(),
        isLoading: false,
      );
    }
  }

  @override
  Future addIngredientUnit(AddIngredientUnitRequest request) async {
    try {
      await _repository.addIngredientUnit(request);
      await _fetchIngredients();
    } catch (e) {
      state = IngredientUnitsModel(
        error: e.toString(),
      );
    }
  }
}

abstract class IngredientUnitRepository {
  Future<List<IngredientUnit>> fetchIngredientUnits();
  Future<HttpPostResult> addIngredientUnit(AddIngredientUnitRequest request);
  void dispose();
}
