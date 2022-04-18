import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:recipy_frontend/helpers/error_mapping.dart';
import 'package:recipy_frontend/helpers/providers.dart';
import 'package:recipy_frontend/models/ingredient_unit.dart';
import 'package:recipy_frontend/pages/ingredient_units/parts/add_unit_request.dart';
import 'package:recipy_frontend/pages/ingredient_units/ingredient_units_model.dart';
import 'package:recipy_frontend/pages/ingredient_units/ingredient_units_page.dart';
import 'package:recipy_frontend/repositories/http_request_result.dart';
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
    try {
      state = IngredientUnitsModel(
        isLoading: true,
      );
      var storage = RecipyInMemoryStorage();
      await storage.refetchIngredientUnits();

      state = IngredientUnitsModel(
        units: storage.getIngredientUnits(),
        isLoading: false,
      );
    } catch (e) {
      String errorMessage = errorMessageFor(e.toString());
      state = IngredientUnitsModel(
        error: errorMessage,
        isLoading: false,
      );
    }
  }

  @override
  Future<void> refetchIngredientUnits() async {
    await _fetchIngredientUnits();
  }

  @override
  Future<void> addIngredientUnit(AddIngredientUnitRequest request) async {
    state = IngredientUnitsModel(
      units: state.units,
      isLoading: true,
    );
    try {
      var result = await _repository.addIngredientUnit(request);
      if (result.success) {
        await _fetchIngredientUnits();
      } else {
        state = IngredientUnitsModel(
          units: state.units,
          error: result.error,
          isLoading: false,
        );
      }
    } catch (e) {
      state = IngredientUnitsModel(
        units: state.units,
        error: e.toString(),
        isLoading: false,
      );
    }
  }

  @override
  void dismissError() {
    state = IngredientUnitsModel(
      units: state.units,
      isLoading: state.isLoading,
      error: null,
    );
  }
}

abstract class IngredientUnitRepository {
  Future<List<IngredientUnit>> fetchIngredientUnits();
  Future<HttpPostResult> addIngredientUnit(AddIngredientUnitRequest request);
}
