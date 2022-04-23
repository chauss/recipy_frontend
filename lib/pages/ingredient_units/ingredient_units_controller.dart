import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:recipy_frontend/helpers/providers.dart';
import 'package:recipy_frontend/pages/ingredient_units/parts/add_unit_request.dart';
import 'package:recipy_frontend/pages/ingredient_units/ingredient_units_model.dart';
import 'package:recipy_frontend/pages/ingredient_units/ingredient_units_page.dart';
import 'package:recipy_frontend/pages/ingredient_units/parts/delete_ingredient_unit_request.dart';
import 'package:recipy_frontend/repositories/http_write_result.dart';
import 'package:recipy_frontend/storage/in_memory_storage.dart';

class IngredientUnitsControllerImpl extends IngredientUnitsController {
  late IngredientUnitRepository _repository;

  IngredientUnitsControllerImpl(IngredientUnitsModel state) : super(state) {
    final container = ProviderContainer();
    _repository = container.read(ingredientUnitRepositoryProvider);
    _init();
  }

  void _init() async {
    await _fetchIngredientUnits();
  }

  Future<void> _fetchIngredientUnits() async {
    state = state.copyWith(isLoading: true);

    var result = await RecipyInMemoryStorage().refetchIngredientUnits();

    if (result.success) {
      state = state.copyWith(units: result.data!, isLoading: false);
    } else {
      state = state.copyWith(errorCode: result.errorCode, isLoading: false);
    }
  }

  @override
  Future<void> refetchIngredientUnits() async {
    await _fetchIngredientUnits();
  }

  @override
  Future<void> addIngredientUnit(AddIngredientUnitRequest request) async {
    state = state.copyWith(isLoading: true);

    var result = await _repository.addIngredientUnit(request);
    if (result.success) {
      await _fetchIngredientUnits();
    } else {
      state = state.copyWith(errorCode: result.errorCode, isLoading: false);
    }
  }

  @override
  void dismissError() => state = state.copyWith(errorCode: null);

  @override
  void deleteIngredientUnit(DeleteIngredientUnitRequest request) async {
    state = state.copyWith(isLoading: true);

    final result = await _repository.deleteIngredientUnitById(request);
    if (result.success) {
      await _fetchIngredientUnits();
    } else {
      state = state.copyWith(errorCode: result.errorCode, isLoading: false);
    }
  }
}

abstract class IngredientUnitRepository {
  Future<HttpWriteResult> addIngredientUnit(AddIngredientUnitRequest request);
  Future<HttpWriteResult> deleteIngredientUnitById(
      DeleteIngredientUnitRequest request);
}
