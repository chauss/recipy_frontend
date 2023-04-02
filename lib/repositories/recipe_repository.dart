import 'dart:convert';
import 'dart:io';
import 'package:http/http.dart' as http;
import 'package:logging/logging.dart';
import 'package:recipy_frontend/config/api_config.dart';
import 'package:recipy_frontend/config/error_config.dart';
import 'package:recipy_frontend/helpers/http_helper.dart';
import 'package:recipy_frontend/models/recipe.dart';
import 'package:recipy_frontend/models/recipe_overview.dart';
import 'package:recipy_frontend/pages/recipe_detail/parts/ingredient_usage/create_ingredient_usage_request.dart';
import 'package:recipy_frontend/pages/recipe_detail/parts/preparation_step/update_preparation_step_request.dart';
import 'package:recipy_frontend/pages/recipe_detail/parts/preparation_step/create_preparation_step_request.dart';
import 'package:recipy_frontend/pages/recipe_detail/recipe_detail_controller.dart';
import 'package:recipy_frontend/pages/recipe_detail/parts/ingredient_usage/update_ingredient_usage_request.dart';
import 'package:recipy_frontend/pages/recipe_overview/recipe_overview_controller.dart';
import 'package:recipy_frontend/repositories/http_read_result.dart';
import 'package:recipy_frontend/repositories/http_write_result.dart';

class RecipyRecipeRepository extends RecipeOverviewRepository
    with RecipeDetailRepository {
  static final log = Logger('RecipyRecipeRepository');

  @override
  Future<HttpReadResult<List<RecipeOverview>>> fetchRecipesAsOverview() async {
    var uri =
        Uri.parse("${APIConfiguration.backendBaseUri}/v1/recipes/overview");
    http.Response response;
    try {
      response = await http.get(uri);
    } on SocketException catch (_) {
      log.warning("Could not fetch recipeOverviews: Server unreachable");
      return HttpReadResult(
          success: false, errorCode: ErrorCodes.serverUnreachable);
    }

    if (is2xx(response.statusCode)) {
      Iterable l = json.decode(utf8.decode(response.bodyBytes));
      List<RecipeOverview> recipes = List<RecipeOverview>.from(
          l.map((json) => RecipeOverview.fromJson(json)));
      log.fine("Fetched ${recipes.length} recipeOverviews");

      return HttpReadResult(success: true, data: recipes);
    }
    return handleHttpReadFailed(
        log, response, "Failed to fetch recipeOverviews");
  }

  @override
  Future<HttpWriteResult> addRecipe(String name, String userToken) async {
    var uri = Uri.parse("${APIConfiguration.backendBaseUri}/v1/recipe");
    http.Response response;
    try {
      response = await http.post(
        uri,
        body: json.encode(<String, String>{
          "name": name,
          "userToken": userToken,
        }),
        headers: <String, String>{
          'Content-Type': 'application/json; charset=UTF-8',
        },
      );
    } on SocketException catch (_) {
      log.warning("Could not add recipe \"$name\": Server unreachable");
      return HttpWriteResult(
          success: false, errorCode: ErrorCodes.serverUnreachable);
    }

    if (is2xx(response.statusCode)) {
      log.fine("Added recipe \"$name\"");
      return HttpWriteResult(success: true);
    }
    return handleHttpWriteFailed(
        log, response, "Failed to add recipe \"$name\"");
  }

  @override
  Future<HttpReadResult<Recipe>> fetchRecipeById(String recipeId) async {
    var uri =
        Uri.parse("${APIConfiguration.backendBaseUri}/v1/recipe/$recipeId");
    http.Response response;
    try {
      response = await http.get(uri);
    } on SocketException catch (_) {
      log.warning("Could not fetch recipe by id: Server unreachable");
      return HttpReadResult(
          success: false, errorCode: ErrorCodes.serverUnreachable);
    }

    if (is2xx(response.statusCode)) {
      Map<String, dynamic> recipeJson =
          json.decode(utf8.decode(response.bodyBytes));
      Recipe recipe = Recipe.fromJson(recipeJson);
      log.fine("Fetched recipe \"${recipe.name}\"");

      return HttpReadResult(success: true, data: recipe);
    }
    return handleHttpReadFailed(log, response, "Failed to fetch recipe by id");
  }

  @override
  Future<HttpWriteResult> createIngredientUsage(
      CreateIngredientUsageRequest request) async {
    var uri =
        Uri.parse("${APIConfiguration.backendBaseUri}/v1/ingredient/usage");
    http.Response response;
    try {
      response = await http.post(uri,
          body: json.encode(<String, Object>{
            "recipeId": request.recipeId,
            "ingredientId": request.ingredientId,
            "ingredientUnitId": request.ingredientUnitId,
            "amount": request.amount,
          }),
          headers: <String, String>{
            'Content-Type': 'application/json; charset=UTF-8',
          });
    } on SocketException catch (_) {
      log.warning("Could not create ingredientUsage: Server unreachable");
      return HttpWriteResult(
          success: false, errorCode: ErrorCodes.serverUnreachable);
    }

    if (is2xx(response.statusCode)) {
      log.fine("Create ingredientUsage for recipe ${request.recipeId}");
      return HttpWriteResult(success: true);
    }
    return handleHttpWriteFailed(
        log, response, "Failed to add ingredientUsage");
  }

  @override
  Future<HttpWriteResult> updateIngredientUsage(
      UpdateIngredientUsageRequest request) async {
    var uri = Uri.parse(
        "${APIConfiguration.backendBaseUri}/v1/ingredient/usage/${request.ingredientUsageId}");

    http.Response response;
    try {
      response = await http.put(uri,
          body: json.encode(<String, Object>{
            "ingredientId": request.ingredientId,
            "ingredientUnitId": request.ingredientUnitId,
            "amount": request.amount,
          }),
          headers: <String, String>{
            'Content-Type': 'application/json; charset=UTF-8',
          });
    } on SocketException catch (_) {
      log.warning("Could not update ingredientUsage: Server unreachable");
      return HttpWriteResult(
          success: false, errorCode: ErrorCodes.serverUnreachable);
    }

    if (is2xx(response.statusCode)) {
      log.fine("Updated ingredientUsage ${request.ingredientUsageId}");
      return HttpWriteResult(success: true);
    }
    return handleHttpWriteFailed(
        log, response, "Failed to update ingredientUsage");
  }

  @override
  Future<HttpWriteResult> deleteIngredientUsage(
      String ingredientUsageId) async {
    var uri = Uri.parse(
        "${APIConfiguration.backendBaseUri}/v1/ingredient/usage/$ingredientUsageId");
    http.Response response;
    try {
      response = await http.delete(uri);
    } on SocketException catch (_) {
      log.warning("Could not delete ingredientUsage by id: Server unreachable");
      return HttpWriteResult(
          success: false, errorCode: ErrorCodes.serverUnreachable);
    }

    if (is2xx(response.statusCode)) {
      log.fine("Deleted ingredientUsage $ingredientUsageId");
      return HttpWriteResult(success: true);
    }
    return handleHttpWriteFailed(
        log, response, "Failed to delete ingredientUsage by id");
  }

  @override
  Future<HttpWriteResult> deleteRecipeById(
      String recipeId, String userToken) async {
    var uri =
        Uri.parse("${APIConfiguration.backendBaseUri}/v1/recipe/$recipeId");
    http.Response response;
    try {
      response = await http.delete(
        uri,
        body: json.encode(
          <String, Object>{
            "userToken": userToken,
          },
        ),
        headers: <String, String>{
          'Content-Type': 'application/json; charset=UTF-8',
        },
      );
    } on SocketException catch (_) {
      log.warning("Could not delete recipe by id: Server unreachable");
      return HttpWriteResult(
          success: false, errorCode: ErrorCodes.serverUnreachable);
    }

    if (is2xx(response.statusCode)) {
      log.fine("Deleted recipe $recipeId");
      return HttpWriteResult(success: true);
    }
    return handleHttpWriteFailed(
        log, response, "Failed to delete recipe by id");
  }

  @override
  Future<HttpWriteResult> createPreparationStep(
      CreatePreparationStepRequest request) async {
    var uri = Uri.parse(
        "${APIConfiguration.backendBaseUri}/v1/recipe/preparationStep");
    http.Response response;
    try {
      response = await http.post(uri,
          body: json.encode(<String, Object>{
            "recipeId": request.recipeId,
            "stepNumber": request.stepNumber,
            "description": request.description,
          }),
          headers: <String, String>{
            'Content-Type': 'application/json; charset=UTF-8',
          });
    } on SocketException catch (_) {
      log.warning("Could not create preparationStep: Server unreachable");
      return HttpWriteResult(
          success: false, errorCode: ErrorCodes.serverUnreachable);
    }

    if (is2xx(response.statusCode)) {
      log.fine(
          "Created preparationStep \"${request.stepNumber}\" for recipe ${request.recipeId}");
      return HttpWriteResult(success: true);
    }
    return handleHttpWriteFailed(
        log, response, "Failed to create preparationStep");
  }

  @override
  Future<HttpWriteResult> deletePreparationStep(
      String preparationStepId) async {
    var uri = Uri.parse(
        "${APIConfiguration.backendBaseUri}/v1/recipe/preparationStep/$preparationStepId");
    http.Response response;
    try {
      response = await http.delete(uri);
    } on SocketException catch (_) {
      log.warning("Could not delete preparationStep by id: Server unreachable");
      return HttpWriteResult(
          success: false, errorCode: ErrorCodes.serverUnreachable);
    }

    if (is2xx(response.statusCode)) {
      log.fine("Deleted preparationStep $preparationStepId");
      return HttpWriteResult(success: true);
    }
    return handleHttpWriteFailed(
        log, response, "Failed to delete preparationStep by id");
  }

  @override
  Future<HttpWriteResult> updatePreparationStep(
      UpdatePreparationStepRequest request) async {
    var uri = Uri.parse(
        "${APIConfiguration.backendBaseUri}/v1/recipe/preparationStep/${request.preparationStepId}");

    http.Response response;
    try {
      response = await http.put(uri,
          body: json.encode(<String, Object>{
            "stepNumber": request.stepNumber,
            "description": request.description,
          }),
          headers: <String, String>{
            'Content-Type': 'application/json; charset=UTF-8',
          });
    } on SocketException catch (_) {
      log.warning("Could not update preparationStep: Server unreachable");
      return HttpWriteResult(
          success: false, errorCode: ErrorCodes.serverUnreachable);
    }

    if (is2xx(response.statusCode)) {
      log.fine("Updated preparationStep ${request.preparationStepId}");
      return HttpWriteResult(success: true);
    }
    return handleHttpWriteFailed(
        log, response, "Failed to update preparationStep");
  }
}
