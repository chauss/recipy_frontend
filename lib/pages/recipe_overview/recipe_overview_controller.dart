import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:recipy_frontend/config/error_config.dart';
import 'package:recipy_frontend/helpers/providers.dart';
import 'package:recipy_frontend/models/recipe_overview.dart';
import 'package:recipy_frontend/models/user.dart';
import 'package:recipy_frontend/pages/recipe_overview/recipe_overview_model.dart';
import 'package:recipy_frontend/pages/recipe_overview/recipe_overview_page.dart';
import 'package:recipy_frontend/pages/user/user_management_repository.dart';
import 'package:recipy_frontend/repositories/http_read_result.dart';
import 'package:recipy_frontend/repositories/http_write_result.dart';

class RecipeOverviewControllerImpl extends RecipeOverviewController {
  late RecipeOverviewRepository _recipeRepository;
  late UserManagementRepository _userManagementRepository;

  RecipeOverviewControllerImpl(RecipeOverviewModel state) : super(state) {
    final container = ProviderContainer();
    _recipeRepository = container.read(recipeOverviewRepositoryProvider);
    _userManagementRepository =
        container.read(userManagementRepositoryProvider);

    _userManagementRepository.addOnUserStateChangedListener(_onUserChanged);

    _init();
  }

  void _init() async {
    _onUserChanged(await _userManagementRepository.getCurrentUser());
    _fetchRecipes();
  }

  Future<void> _fetchRecipes() async {
    state = state.copyWith(isLoading: true);
    var result = await _recipeRepository.fetchRecipesAsOverview();
    if (result.success) {
      state = state.copyWith(recipeOverviews: result.data!, isLoading: false);
    } else {
      state = state.copyWith(errorCode: result.errorCode, isLoading: false);
    }
  }

  @override
  Future<void> refetchRecipes() async {
    await _fetchRecipes();
  }

  @override
  Future<void> addRecipe(String name) async {
    User? currentUser = await _userManagementRepository.getCurrentUser();
    if (!state.canAddNewRecipe) {
      state = state.copyWith(
          errorCode: ErrorCodes.triedToAddRecipeWhileItWasNotAllowed);
      return;
    } else if (currentUser == null) {
      state = state.copyWith(
          errorCode: ErrorCodes.couldNotFindUserToCreateNewRecipeWith);
      return;
    }
    var result = await _recipeRepository.addRecipe(name, currentUser.authToken);
    if (result.success) {
      await _fetchRecipes();
    } else {
      state = state.copyWith(errorCode: result.errorCode);
    }
  }

  @override
  void dismissError() => state = state.copyWith(errorCode: null);

  void _onUserChanged(User? newUser) {
    state = state.copyWith(canAddNewRecipe: newUser != null);
  }
}

abstract class RecipeOverviewRepository {
  Future<HttpReadResult<List<RecipeOverview>>> fetchRecipesAsOverview();
  Future<HttpWriteResult> addRecipe(String name, String userId);
}
