import 'package:recipy_frontend/config/error_config.dart';
import 'package:recipy_frontend/models/user.dart';
import 'package:recipy_frontend/pages/ingredient_units/parts/add_unit_request.dart';
import 'package:recipy_frontend/pages/ingredient_units/ingredient_units_page.dart';
import 'package:recipy_frontend/pages/ingredient_units/parts/delete_ingredient_unit_request.dart';
import 'package:recipy_frontend/pages/user/user_management_repository.dart';
import 'package:recipy_frontend/repositories/http_write_result.dart';
import 'package:recipy_frontend/storage/in_memory_storage.dart';

class IngredientUnitsControllerImpl extends IngredientUnitsController {
  late IngredientUnitRepository _repository;
  late UserManagementRepository _userManagementRepository;
  late RecipyInMemoryStorage _inMemoryStorage;

  IngredientUnitsControllerImpl(
    super.state,
    UserManagementRepository userManagementRepository,
    RecipyInMemoryStorage inMemoryStorage,
  ) {
    _userManagementRepository = userManagementRepository;
    _inMemoryStorage = inMemoryStorage;
    _userManagementRepository.addOnUserStateChangedListener(_onUserChanged);

    _init();
  }

  void _init() async {
    await _fetchIngredientUnits();
  }

  void _onUserChanged(User? newUser) {
    state = state.copyWith(
      canAddIngredientUnits: newUser != null,
      canDeleteIngredientUnits: newUser != null,
    );
  }

  Future<void> _fetchIngredientUnits() async {
    state = state.copyWith(isLoading: true);

    var result = await _inMemoryStorage.refetchIngredientUnits();

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
  Future<void> addIngredientUnit(String name) async {
    state = state.copyWith(isLoading: true);

    User? currentUser = await _userManagementRepository.getCurrentUser();
    if (currentUser == null) {
      state = state.copyWith(
        errorCode: ErrorCodes.couldNotFindUserToAuthorizeActionWith,
        isLoading: false,
      );
      return;
    }

    var result = await _repository.addIngredientUnit(
      AddIngredientUnitRequest(name: name, userToken: currentUser.authToken),
    );
    if (result.success) {
      await _fetchIngredientUnits();
    } else {
      state = state.copyWith(errorCode: result.errorCode, isLoading: false);
    }
  }

  @override
  void dismissError() => state = state.copyWith(errorCode: null);

  @override
  void deleteIngredientUnit(String ingredientUnitId) async {
    state = state.copyWith(isLoading: true);

    User? currentUser = await _userManagementRepository.getCurrentUser();
    if (currentUser == null) {
      state = state.copyWith(
        errorCode: ErrorCodes.couldNotFindUserToAuthorizeActionWith,
        isLoading: false,
      );
      return;
    }

    final result =
        await _repository.deleteIngredientUnitById(DeleteIngredientUnitRequest(
      ingredientUnitId: ingredientUnitId,
      userToken: currentUser.authToken,
    ));
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
