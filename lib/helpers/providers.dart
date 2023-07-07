import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:recipy_frontend/pages/app_screen/app_screen_controller.dart';
import 'package:recipy_frontend/pages/app_screen/app_screen_model.dart';
import 'package:recipy_frontend/pages/app_screen/app_screen_page.dart';
import 'package:recipy_frontend/pages/ingredient_units/ingredient_units_controller.dart';
import 'package:recipy_frontend/pages/ingredient_units/ingredient_units_model.dart';
import 'package:recipy_frontend/pages/ingredient_units/ingredient_units_page.dart';
import 'package:recipy_frontend/pages/ingredients/ingredients_controller.dart';
import 'package:recipy_frontend/pages/ingredients/ingredients_model.dart';
import 'package:recipy_frontend/pages/ingredients/ingredients_page.dart';
import 'package:recipy_frontend/pages/recipe_detail/parts/recipe_images/recipe_images_controller.dart';
import 'package:recipy_frontend/pages/recipe_detail/parts/recipe_images/recipe_images_model.dart';
import 'package:recipy_frontend/pages/recipe_detail/parts/recipe_images/recipe_images_widget.dart';
import 'package:recipy_frontend/pages/recipe_detail/recipe_detail_controller.dart';
import 'package:recipy_frontend/pages/recipe_detail/recipe_detail_model.dart';
import 'package:recipy_frontend/pages/recipe_detail/recipe_detail_page.dart';
import 'package:recipy_frontend/pages/recipe_overview/recipe_overview_controller.dart';
import 'package:recipy_frontend/pages/recipe_overview/recipe_overview_model.dart';
import 'package:recipy_frontend/pages/recipe_overview/recipe_overview_page.dart';
import 'package:recipy_frontend/pages/settings/settings_controller.dart';
import 'package:recipy_frontend/pages/settings/settings_model.dart';
import 'package:recipy_frontend/pages/settings/settings_page.dart';
import 'package:recipy_frontend/pages/user/my_recipes/my_recipes_controller.dart';
import 'package:recipy_frontend/pages/user/my_recipes/my_recipes_model.dart';
import 'package:recipy_frontend/pages/user/my_recipes/my_recipes_page.dart';
import 'package:recipy_frontend/pages/user/profile/profile_controller.dart';
import 'package:recipy_frontend/pages/user/profile/profile_model.dart';
import 'package:recipy_frontend/pages/user/profile/profile_page.dart';
import 'package:recipy_frontend/pages/user/registration/registration_controller.dart';
import 'package:recipy_frontend/pages/user/user_management_repository.dart';
import 'package:recipy_frontend/repositories/ingredient_repository.dart';
import 'package:recipy_frontend/repositories/ingredient_unit_repository.dart';
import 'package:recipy_frontend/repositories/firebase_user_repository.dart';
import 'package:recipy_frontend/repositories/recipe_images_repository.dart';
import 'package:recipy_frontend/repositories/recipe_repository.dart';
import 'package:recipy_frontend/storage/in_memory_storage.dart';
import 'package:recipy_frontend/pages/user/login/login_controller.dart';
import 'package:recipy_frontend/pages/user/login/login_model.dart';
import 'package:recipy_frontend/pages/user/login/login_page.dart';
import 'package:recipy_frontend/pages/user/registration/registration_model.dart';

import '../pages/user/registration/registration_page.dart';

// #############################################################################
// # User
// #############################################################################
// General
final userManagementRepositoryProvider =
    Provider<UserManagementRepository>((ref) {
  return FirebaseUserRepository();
});

// Registration
final registrationRepositoryProvider = Provider<RegistrationRepository>((ref) {
  return FirebaseUserRepository();
});

final registrationControllerProvider =
    StateNotifierProvider<RegistrationController, RegistrationModel>(
  (ref) => FirebaseRegistrationController(
    ref.read(registrationRepositoryProvider),
  ),
);

// Login
final loginRepositoryProvider = Provider<LoginRepository>((ref) {
  return FirebaseUserRepository();
});

final loginControllerProvider =
    StateNotifierProvider.autoDispose<LoginController, LoginModel>(
  (ref) => FirebaseLoginController(
    ref.read(loginRepositoryProvider),
  ),
);

// Profile
final profileRepositoryProvider = Provider<ProfileRepository>((ref) {
  return FirebaseUserRepository();
});

final profileControllerProvider =
    StateNotifierProvider.autoDispose<ProfileController, ProfileModel>(
  (ref) => ProfileControllerImpl(
    ref.read(profileRepositoryProvider),
    ref.read(userManagementRepositoryProvider),
  ),
);

// #############################################################################
// # Ingredients
// #############################################################################
final ingredientRepositoryProvider = Provider<IngredientRepository>((ref) {
  return RecipyIngredientRepository();
});

final ingredientsControllerProvider =
    StateNotifierProvider<IngredientsController, IngredientsModel>(
  (ref) => IngredintsControllerImpl(
    ref.read(ingredientRepositoryProvider),
    ref.read(userManagementRepositoryProvider),
    ref.read(inMemoryStorageProvider),
  ),
);

// #############################################################################
// # Ingredient Units
// #############################################################################
final ingredientUnitRepositoryProvider =
    Provider<IngredientUnitRepository>((ref) {
  return RecipyIngredientUnitRepository();
});

final ingredientUnitControllerProvider =
    StateNotifierProvider<IngredientUnitsController, IngredientUnitsModel>(
  (ref) => IngredientUnitsControllerImpl(
    ref.read(userManagementRepositoryProvider),
    ref.read(inMemoryStorageProvider),
  ),
);

// #############################################################################
// # Recipe Overview
// #############################################################################
final recipeOverviewRepositoryProvider =
    Provider<RecipeOverviewRepository>((ref) {
  return RecipyRecipeRepository();
});

final recipeOverviewControllerProvider =
    StateNotifierProvider<RecipeOverviewController, RecipeOverviewModel>(
  (ref) => RecipeOverviewControllerImpl(
    ref.read(recipeOverviewRepositoryProvider),
    ref.read(userManagementRepositoryProvider),
  ),
);

// #############################################################################
// # My Recipes
// #############################################################################
final myRecipesRepositoryProvider = Provider<MyRecipesRepository>((ref) {
  return RecipyRecipeRepository();
});

final StateNotifierProvider<MyRecipesController, MyRecipesModel>
    myRecipesControllerProvider =
    StateNotifierProvider<MyRecipesController, MyRecipesModel>(
  (ref) => MyRecipesControllerImpl(
    ref.read(myRecipesRepositoryProvider),
    ref.read(userManagementRepositoryProvider),
  ),
);

// #############################################################################
// # Recipe Detail
// #############################################################################
final recipeDetailRepositoryProvider = Provider<RecipeDetailRepository>((ref) {
  return RecipyRecipeRepository();
});

final recipeDetailControllerProvider = StateNotifierProvider.family<
    RecipeDetailController, RecipeDetailModel, String>(
  (ref, recipeId) => RecipeDetailControllerImpl(
    recipeId,
    ref.read(recipeDetailRepositoryProvider),
    ref.read(userManagementRepositoryProvider),
  ),
);

// #############################################################################
// # Settings
// #############################################################################
final settingsControllerProvider =
    StateNotifierProvider<SettingsController, SettingsModel>(
  (ref) => SettingsControllerImpl(
    ref.read(userManagementRepositoryProvider),
  ),
);

// #############################################################################
// # Storage
// #############################################################################
final inMemoryStorageProvider = Provider<RecipyInMemoryStorage>((ref) {
  return RecipyInMemoryStorage(
    ref.read(inMemoryStorageIngredientRepositoryProvider),
    ref.read(inMemoryStorageIngredientUnitRepositoryProvider),
  );
});

final inMemoryStorageIngredientRepositoryProvider =
    Provider<InMemoryStorageIngredientRepository>((ref) {
  return RecipyIngredientRepository();
});

final inMemoryStorageIngredientUnitRepositoryProvider =
    Provider<InMemoryStorageIngredientUnitRepository>((ref) {
  return RecipyIngredientUnitRepository();
});

// #############################################################################
// # Recipe Images
// #############################################################################
final recipeImagesRepositoryProvider = Provider<RecipeImagesRepository>((ref) {
  return RecipyRecipeImagesRepository();
});

final recipeImagesControllerProvider = StateNotifierProvider.family<
    RecipeImagesController, RecipeImagesModel, String>(
  (ref, recipeId) => RecipeImagesControllerImpl(
    recipeId,
    ref.read(recipeImagesRepositoryProvider),
    ref.read(userManagementRepositoryProvider),
  ),
);

// #############################################################################
// # Bottom Navigation Bar
// #############################################################################
final recipyAppScreenControllerProvider =
    StateNotifierProvider<AppScreenController, AppScreenModel>(
  (ref) => AppScreenControllerImpl(
    ref.read(userManagementRepositoryProvider),
  ),
);
