import 'package:recipy_frontend/config/error_config.dart';
import 'package:recipy_frontend/models/user.dart';
import 'package:recipy_frontend/pages/ingredients/parts/add_ingredient_request.dart';
import 'package:recipy_frontend/pages/ingredients/ingredients_model.dart';
import 'package:recipy_frontend/pages/ingredients/ingredients_page.dart';
import 'package:recipy_frontend/pages/ingredients/parts/delete_ingredient_request.dart';
import 'package:recipy_frontend/pages/user/user_management_repository.dart';
import 'package:recipy_frontend/repositories/http_write_result.dart';
import 'package:recipy_frontend/storage/in_memory_storage.dart';

class IngredintsControllerImpl extends IngredientsController {
  late IngredientRepository _repository;
  late UserManagementRepository _userManagementRepository;
  late RecipyInMemoryStorage _inMemoryStorage;

  IngredintsControllerImpl(
    IngredientsModel state,
    IngredientRepository ingredientRepository,
    UserManagementRepository userManagementRepository,
    RecipyInMemoryStorage inMemoryStorage,
  ) : super(state) {
    _repository = ingredientRepository;
    _userManagementRepository = userManagementRepository;
    _inMemoryStorage = inMemoryStorage;
    _userManagementRepository.addOnUserStateChangedListener(_onUserChanged);

    _init();
  }

  void _init() async {
    await _fetchIngredients();
  }

  void _onUserChanged(User? newUser) {
    state = state.copyWith(
      canAddIngredients: newUser != null,
      canDeleteIngredients: newUser != null,
    );
  }

  Future<void> _fetchIngredients() async {
    state = state.copyWith(isLoading: true);

    var result = await _inMemoryStorage.refetchIngredients();

    if (result.success) {
      state = state.copyWith(ingredients: result.data!, isLoading: false);
    } else {
      state = state.copyWith(errorCode: result.errorCode, isLoading: false);
    }
  }

  @override
  Future<void> refetchIngredients() async {
    await _fetchIngredients();
  }

  @override
  Future<void> addIngredient(String name) async {
    state = state.copyWith(isLoading: true);

    User? currentUser = await _userManagementRepository.getCurrentUser();
    if (currentUser == null) {
      state = state.copyWith(
        errorCode: ErrorCodes.couldNotFindUserToAuthorizeActionWith,
        isLoading: false,
      );
      return;
    }

    final result = await _repository.addIngredient(AddIngredientRequest(
      name: name,
      userToken: currentUser.authToken,
    ));
    if (result.success) {
      await _fetchIngredients();
    } else {
      state = state.copyWith(errorCode: result.errorCode, isLoading: false);
    }
  }

  @override
  void dismissError() => state = state.copyWith(errorCode: null);

  @override
  Future<void> deleteIngredient(String ingredientId) async {
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
        await _repository.deleteIngredientById(DeleteIngredientRequest(
      ingredientId: ingredientId,
      userToken: currentUser.authToken,
    ));
    if (result.success) {
      await _fetchIngredients();
    } else {
      state = state.copyWith(errorCode: result.errorCode, isLoading: false);
    }
  }
}

abstract class IngredientRepository {
  Future<HttpWriteResult> deleteIngredientById(DeleteIngredientRequest request);
  Future<HttpWriteResult> addIngredient(AddIngredientRequest request);
}
