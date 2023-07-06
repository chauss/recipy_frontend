import 'package:logging/logging.dart';
import 'package:recipy_frontend/models/recipe_overview.dart';
import 'package:recipy_frontend/models/user.dart';
import 'package:recipy_frontend/pages/user/my_recipes/my_recipes_page.dart';
import 'package:recipy_frontend/pages/user/user_management_repository.dart';
import 'package:recipy_frontend/repositories/http_read_result.dart';

import 'my_recipes_model.dart';

class MyRecipesControllerImpl extends MyRecipesController {
  static final log = Logger("MyRecipesControllerImpl");

  late MyRecipesRepository _repository;
  late UserManagementRepository _userManagementRepository;

  MyRecipesControllerImpl(
    MyRecipesRepository myRecipesRepository,
    UserManagementRepository userManagementRepository,
  ) : super(const MyRecipesModel()) {
    _repository = myRecipesRepository;
    _userManagementRepository = userManagementRepository;
    _userManagementRepository.addOnUserStateChangedListener(_onUserChanged);

    init();
  }

  Future<void> init() async {
    log.fine("Going to initialize MyRecipesControllerImpl...");
    User? user = await _userManagementRepository.getCurrentUser();
    _onUserChanged(user);
    refetchRecipes();
    log.info("Initialized MyRecipesControllerImpl");
  }

  void _onUserChanged(User? newUser) {
    log.info("User changed. NewUser=${newUser?.userId}.");
    state = state.copyWith(
      hasValidUserLoggedIn: newUser != null,
    );
  }

  @override
  void dismissError() {
    state = state.copyWith(errorCode: null);
  }

  @override
  Future<void> refetchRecipes() async {
    log.fine("Going to (re)fetch recipes for user...");
    state = state.copyWith(isLoading: true);
    User? user = await _userManagementRepository.getCurrentUser();
    if (user != null) {
      log.fine("Going to fetch recipes for userId=${user.userId}...");
      final result =
          await _repository.fetchRecipesForUserAsOverview(user.userId);
      if (result.success) {
        log.info(
            "Successfully fetched ${result.data!.length} recipes for user.");
        state = state.copyWith(
          recipeOverviews: result.data!,
          isLoading: false,
        );
      } else {
        log.info(
            "Failed to fetch recipes for user. ErrorCode=${result.errorCode}.");
        state = state.copyWith(
          errorCode: result.errorCode,
          isLoading: false,
        );
      }
    } else {
      log.info("Failed to fetch recipes for user. User is null.");
      state = state.copyWith(isLoading: false);
    }
  }
}

abstract class MyRecipesRepository {
  Future<HttpReadResult<List<RecipeOverview>>> fetchRecipesForUserAsOverview(
      String userId);
}
