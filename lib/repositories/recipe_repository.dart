import 'dart:convert';
import 'dart:io';
import 'package:http/http.dart' as http;
import 'package:logging/logging.dart';
import 'package:recipy_frontend/config/api_config.dart';
import 'package:recipy_frontend/helpers/http_helper.dart';
import 'package:recipy_frontend/models/recipe.dart';
import 'package:recipy_frontend/models/recipe_overview.dart';
import 'package:recipy_frontend/pages/recipe_detail/parts/add_ingredient_usage_request.dart';
import 'package:recipy_frontend/pages/recipe_detail/recipe_detail_controller.dart';
import 'package:recipy_frontend/pages/recipe_detail/parts/update_ingredient_usage_request.dart';
import 'package:recipy_frontend/pages/recipe_overview/parts/add_recipe_request.dart';
import 'package:recipy_frontend/pages/recipe_overview/recipe_overview_controller.dart';
import 'package:recipy_frontend/repositories/http_read_result.dart';
import 'package:recipy_frontend/repositories/http_write_result.dart';

class RecipyRecipeRepository extends RecipeOverviewRepository
    with RecipeDetailRepository {
  static final log = Logger('RecipeRepository');

  @override
  Future<HttpReadResult<List<RecipeOverview>>> fetchRecipesAsOverview() async {
    var uri =
        Uri.parse(APIConfiguration.backendBaseUri + "/v1/recipes/overview");
    http.Response response;
    try {
      response = await http.get(uri);
    } on SocketException catch (_) {
      String error = "Der Server konnte nicht erreicht werden";
      log.warning("Could not fetch recipes: $error");
      return HttpReadResult(success: false, error: error);
    }

    if (is2xx(response.statusCode)) {
      Iterable l = json.decode(utf8.decode(response.bodyBytes));
      List<RecipeOverview> recipes = List<RecipeOverview>.from(
          l.map((json) => RecipeOverview.fromJson(json)));
      log.fine("Fetched ${recipes.length} recipeOverviews");

      return HttpReadResult(success: true, data: recipes);
    } else {
      String error = 'Failed to load recipeOverviews (${response.statusCode})';
      log.warning("Could not fetch recipes: $error");
      return HttpReadResult(success: false, error: error);
    }
  }

  @override
  Future<HttpWriteResult> addRecipe(AddRecipeRequest request) async {
    var uri = Uri.parse(APIConfiguration.backendBaseUri + "/v1/recipe");
    http.Response response;
    try {
      response = await http.post(uri,
          body: json.encode(<String, String>{"name": request.name}),
          headers: <String, String>{
            'Content-Type': 'application/json; charset=UTF-8',
          });
    } on SocketException catch (_) {
      String error = "Der Server konnte nicht erreicht werden";
      log.warning("Could not add recipe \"${request.name}\": $error");
      return HttpWriteResult(success: false, error: error);
    }

    if (is2xx(response.statusCode)) {
      log.fine("Added recipe \"${request.name}\"");
      return HttpWriteResult(success: true);
    } else {
      String errorMessage =
          json.decode(utf8.decode(response.bodyBytes))["message"];
      log.warning(
          'Failed to add recipe $errorMessage (${response.statusCode})');
      return HttpWriteResult(success: false, error: errorMessage);
    }
  }

  @override
  Future<HttpReadResult<Recipe>> fetchRecipeById(String recipeId) async {
    var uri =
        Uri.parse(APIConfiguration.backendBaseUri + "/v1/recipe/$recipeId");
    http.Response response;
    try {
      response = await http.get(uri);
    } on SocketException catch (_) {
      String error = "Der Server konnte nicht erreicht werden";
      log.warning("Could not fetch recipe by id: $error");
      return HttpReadResult(success: false, error: error);
    }

    if (is2xx(response.statusCode)) {
      Map<String, dynamic> recipeJson =
          json.decode(utf8.decode(response.bodyBytes));
      Recipe recipe = Recipe.fromJson(recipeJson);
      log.fine("Fetched recipe \"${recipe.name}\"");

      return HttpReadResult(success: true, data: recipe);
    } else {
      String errorMessage =
          json.decode(utf8.decode(response.bodyBytes))["message"];
      log.warning(
          'Failed to fetch recipe by id $errorMessage (${response.statusCode})');
      return HttpReadResult(success: false, error: errorMessage);
    }
  }

  @override
  Future<HttpWriteResult> createIngredientUsage(
      CreateIngredientUsageRequest request) async {
    var uri =
        Uri.parse(APIConfiguration.backendBaseUri + "/v1/ingredient/usage");
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
      String error = "Der Server konnte nicht erreicht werden";
      log.warning("Could not create ingredientUsage: $error");
      return HttpWriteResult(success: false, error: error);
    }

    if (is2xx(response.statusCode)) {
      log.fine("Create ingredientUsage for recipe ${request.recipeId}");
      return HttpWriteResult(success: true);
    } else {
      String errorMessage =
          json.decode(utf8.decode(response.bodyBytes))["message"];
      log.warning(
          'Failed to add ingredientUsage $errorMessage (${response.statusCode})');
      return HttpWriteResult(success: false, error: errorMessage);
    }
  }

  @override
  Future<HttpWriteResult> updateIngredientUsage(
      UpdateIngredientUsageRequest request) async {
    var uri = Uri.parse(APIConfiguration.backendBaseUri +
        "/v1/ingredient/usage/${request.ingredientUsageId}");

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
      String error = "Der Server konnte nicht erreicht werden";
      log.warning("Could not update ingredientUsage: $error");
      return HttpWriteResult(success: false, error: error);
    }

    if (is2xx(response.statusCode)) {
      log.fine("Updated ingredientUsage ${request.ingredientUsageId}");
      return HttpWriteResult(success: true);
    } else {
      String errorMessage =
          json.decode(utf8.decode(response.bodyBytes))["message"];
      log.warning(
          'Failed to update ingredientUsage $errorMessage (${response.statusCode})');
      return HttpWriteResult(success: false, error: errorMessage);
    }
  }

  @override
  Future<HttpWriteResult> deleteIngredientUsage(
      String ingredientUsageId) async {
    var uri = Uri.parse(APIConfiguration.backendBaseUri +
        "/v1/ingredient/usage/$ingredientUsageId");
    http.Response response;
    try {
      response = await http.delete(uri);
    } on SocketException catch (_) {
      String error = "Der Server konnte nicht erreicht werden";
      log.warning("Could not delete ingredientUsage by id: $error");
      return HttpWriteResult(success: false, error: error);
    }

    if (is2xx(response.statusCode)) {
      log.fine("Deleted ingredientUsage $ingredientUsageId");
      return HttpWriteResult(success: true);
    } else {
      String errorMessage =
          json.decode(utf8.decode(response.bodyBytes))["message"];
      log.warning(
          'Failed to delete ingredientUsage $errorMessage (${response.statusCode})');
      return HttpWriteResult(success: false, error: errorMessage);
    }
  }
}
