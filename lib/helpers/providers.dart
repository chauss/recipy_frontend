import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:recipy_frontend/pages/ingredient_units/ingredient_units_controller.dart';
import 'package:recipy_frontend/pages/ingredient_units/ingredient_units_model.dart';
import 'package:recipy_frontend/pages/ingredient_units/ingredient_units_page.dart';
import 'package:recipy_frontend/pages/ingredients/ingredients_controller.dart';
import 'package:recipy_frontend/pages/ingredients/ingredients_model.dart';
import 'package:recipy_frontend/pages/ingredients/ingredients_page.dart';
import 'package:recipy_frontend/pages/recipe_detail/recipe_detail_controller.dart';
import 'package:recipy_frontend/pages/recipe_detail/recipe_detail_model.dart';
import 'package:recipy_frontend/pages/recipe_detail/recipe_detail_page.dart';
import 'package:recipy_frontend/pages/recipe_overview/recipe_overview_controller.dart';
import 'package:recipy_frontend/pages/recipe_overview/recipe_overview_model.dart';
import 'package:recipy_frontend/pages/recipe_overview/recipe_overview_page.dart';
import 'package:recipy_frontend/pages/user/profile/profile_controller.dart';
import 'package:recipy_frontend/pages/user/profile/profile_model.dart';
import 'package:recipy_frontend/pages/user/profile/profile_page.dart';
import 'package:recipy_frontend/pages/user/registration/registration_controller.dart';
import 'package:recipy_frontend/pages/user/user_management_repository.dart';
import 'package:recipy_frontend/repositories/ingredient_repository.dart';
import 'package:recipy_frontend/repositories/ingredient_unit_repository.dart';
import 'package:recipy_frontend/repositories/firebase_user_repository.dart';
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
  final repository = FirebaseUserRepository();

  return repository;
});

// Registration
final registrationRepositoryProvider = Provider<RegistrationRepository>((ref) {
  final repository = FirebaseUserRepository();

  return repository;
});

final registrationControllerProvider = StateNotifierProvider.autoDispose<
    RegistrationController, RegistrationModel>(
  (ref) => FirebaseRegistrationController(const RegistrationModel()),
);

// Login
final loginRepositoryProvider = Provider<LoginRepository>((ref) {
  final repository = FirebaseUserRepository();

  return repository;
});

final loginControllerProvider =
    StateNotifierProvider.autoDispose<LoginController, LoginModel>(
  (ref) => FirebaseLoginController(const LoginModel()),
);

// Profile
final profileRepositoryProvider = Provider<ProfileRepository>((ref) {
  final repository = FirebaseUserRepository();

  return repository;
});

final profileControllerProvider =
    StateNotifierProvider.autoDispose<ProfileController, ProfileModel>(
  (ref) => ProfileControllerImpl(const ProfileModel()),
);

// #############################################################################
// # Ingredients
// #############################################################################
final ingredientRepositoryProvider = Provider<IngredientRepository>((ref) {
  final repository = RecipyIngredientRepository();

  return repository;
});

final StateNotifierProvider<IngredientsController, IngredientsModel>
    ingredientsControllerProvider =
    StateNotifierProvider<IngredientsController, IngredientsModel>(
  (ref) => IngredintsControllerImpl(const IngredientsModel()),
);

// #############################################################################
// # Ingredient Units
// #############################################################################
final ingredientUnitRepositoryProvider =
    Provider<IngredientUnitRepository>((ref) {
  final repository = RecipyIngredientUnitRepository();

  return repository;
});

final StateNotifierProvider<IngredientUnitsController, IngredientUnitsModel>
    ingredientUnitControllerProvider =
    StateNotifierProvider<IngredientUnitsController, IngredientUnitsModel>(
  (ref) => IngredientUnitsControllerImpl(const IngredientUnitsModel()),
);

// #############################################################################
// # Recipe Overview
// #############################################################################
final recipeOverviewRepositoryProvider =
    Provider<RecipeOverviewRepository>((ref) {
  final repository = RecipyRecipeRepository();

  return repository;
});

final StateNotifierProvider<RecipeOverviewController, RecipeOverviewModel>
    recipeOverviewControllerProvider =
    StateNotifierProvider<RecipeOverviewController, RecipeOverviewModel>(
  (ref) => RecipeOverviewControllerImpl(const RecipeOverviewModel()),
);

// #############################################################################
// # Recipe Detail
// #############################################################################
final recipeDetailRepositoryProvider = Provider<RecipeDetailRepository>((ref) {
  final repository = RecipyRecipeRepository();

  return repository;
});

final StateNotifierProviderFamily<RecipeDetailController, RecipeDetailModel,
        String> recipeDetailControllerProvider =
    StateNotifierProvider.family<RecipeDetailController, RecipeDetailModel,
        String>(
  (ref, recipeId) =>
      RecipeDetailControllerImpl(RecipeDetailModel(recipeId: recipeId)),
);

// #############################################################################
// # Storage
// #############################################################################
final inMemoryStorageIngredientRepositoryProvider =
    Provider<InMemoryStorageIngredientRepository>((ref) {
  return RecipyIngredientRepository();
});

final inMemoryStorageIngredientUnitRepositoryProvider =
    Provider<InMemoryStorageIngredientUnitRepository>((ref) {
  return RecipyIngredientUnitRepository();
});
