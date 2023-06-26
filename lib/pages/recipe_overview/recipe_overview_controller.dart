import 'package:logging/logging.dart';
import 'package:recipy_frontend/config/error_config.dart';
import 'package:recipy_frontend/models/recipe_overview.dart';
import 'package:recipy_frontend/models/user.dart';
import 'package:recipy_frontend/pages/recipe_overview/recipe_overview_model.dart';
import 'package:recipy_frontend/pages/recipe_overview/recipe_overview_page.dart';
import 'package:recipy_frontend/pages/user/user_management_repository.dart';
import 'package:recipy_frontend/repositories/http_read_result.dart';
import 'package:recipy_frontend/repositories/http_write_result.dart';

class RecipeOverviewControllerImpl extends RecipeOverviewController {
  static final log = Logger('RecipeOverviewControllerImpl');

  late RecipeOverviewRepository _recipeRepository;
  late UserManagementRepository _userManagementRepository;

  RecipeOverviewControllerImpl(
    RecipeOverviewModel state,
    RecipeOverviewRepository recipeOverviewRepository,
    UserManagementRepository userManagementRepository,
  ) : super(state) {
    _recipeRepository = recipeOverviewRepository;
    _userManagementRepository = userManagementRepository;

    _userManagementRepository.addOnUserStateChangedListener(_onUserChanged);

    _init();
  }

  void _init() async {
    log.fine("Going to initialize RecipeOverviewController...");
    _onUserChanged(await _userManagementRepository.getCurrentUser());
    _fetchRecipes();
    log.info("Initialized RecipeOverviewController");
  }

  Future<void> _fetchRecipes() async {
    log.fine("Going to fetch recipes...");
    state = state.copyWith(isLoading: true);
    var result = await _recipeRepository.fetchRecipesAsOverview();
    if (result.success) {
      state = state.copyWith(recipeOverviews: result.data!, isLoading: false);
    } else {
      state = state.copyWith(errorCode: result.errorCode, isLoading: false);
    }
    log.info(
        "Fetched recipes. RecipeCount=${result.data?.length}. ErrorCode=${result.errorCode}");
  }

  @override
  Future<void> refetchRecipes() async {
    log.fine("Going to refetch recipes...");
    await _fetchRecipes();
  }

  @override
  Future<void> addRecipe(String name) async {
    log.fine("Going to add recipe \"$name\"...");
    User? currentUser = await _userManagementRepository.getCurrentUser();
    if (!state.canAddNewRecipe) {
      state = state.copyWith(
          errorCode: ErrorCodes.triedToAddRecipeWhileItWasNotAllowed);
      log.fine(
          "Could not add recipe. Current state is set to canAddNewRecipe=false");
      return;
    } else if (currentUser == null) {
      state = state.copyWith(
          errorCode: ErrorCodes.couldNotFindUserToCreateNewRecipeWith);
      log.fine("Could not add recipe. CurrentUser is null");
      return;
    }
    var result = await _recipeRepository.addRecipe(name, currentUser.authToken);
    if (result.success) {
      await _fetchRecipes();
    } else {
      state = state.copyWith(errorCode: result.errorCode);
    }
    log.info(
        "Adding recipe resulted in: Success=${result.success}. ErrorCode=${result.errorCode}");
  }

  @override
  void dismissError() => state = state.copyWith(errorCode: null);

  void _onUserChanged(User? newUser) {
    log.info("Logged in user changed to newUserId=${newUser?.userId}");
    state = state.copyWith(canAddNewRecipe: newUser != null);
  }
}

abstract class RecipeOverviewRepository {
  Future<HttpReadResult<List<RecipeOverview>>> fetchRecipesAsOverview();
  Future<HttpWriteResult> addRecipe(String name, String userToken);
}
