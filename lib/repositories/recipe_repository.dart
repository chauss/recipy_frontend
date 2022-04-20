import 'dart:convert';
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
import 'package:recipy_frontend/repositories/http_write_result.dart';

class RecipyRecipeRepository extends RecipeOverviewRepository
    with RecipeDetailRepository {
  static final log = Logger('RecipeRepository');

  @override
  Future<List<RecipeOverview>> fetchRecipesAsOverview() async {
    var uri =
        Uri.parse(APIConfiguration.backendBaseUri + "/v1/recipes/overview");
    var response = await http.get(uri);

    if (is2xx(response.statusCode)) {
      Iterable l = json.decode(utf8.decode(response.bodyBytes));
      List<RecipeOverview> recipes = List<RecipeOverview>.from(
          l.map((json) => RecipeOverview.fromJson(json)));
      log.fine("Fetched ${recipes.length} recipeOverviews");

      return recipes;
    } else {
      String error = 'Failed to load recipeOverviews (${response.statusCode})';
      log.warning(error);
      throw Exception(error);
    }
  }

  @override
  Future<HttpWriteResult> addRecipe(AddRecipeRequest request) async {
    var uri = Uri.parse(APIConfiguration.backendBaseUri + "/v1/recipe");
    var response = await http.post(uri,
        body: json.encode(<String, String>{"name": request.name}),
        headers: <String, String>{
          'Content-Type': 'application/json; charset=UTF-8',
        });

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
  Future<Recipe?> fetchRecipeById(String recipeId) async {
    var uri =
        Uri.parse(APIConfiguration.backendBaseUri + "/v1/recipe/$recipeId");
    var response = await http.get(uri);

    if (is2xx(response.statusCode)) {
      Map<String, dynamic> recipeJson =
          json.decode(utf8.decode(response.bodyBytes));
      Recipe recipe = Recipe.fromJson(recipeJson);
      log.fine("Fetched recipe \"${recipe.name}\"");

      return recipe;
    } else {
      String errorMessage =
          json.decode(utf8.decode(response.bodyBytes))["message"];
      log.warning(
          'Failed to fetch recipe by id $errorMessage (${response.statusCode})');
      return null;
    }
  }

  @override
  Future<HttpWriteResult> createIngredientUsage(
      CreateIngredientUsageRequest request) async {
    var uri =
        Uri.parse(APIConfiguration.backendBaseUri + "/v1/ingredient/usage");
    var response = await http.post(uri,
        body: json.encode(<String, Object>{
          "recipeId": request.recipeId,
          "ingredientId": request.ingredientId,
          "ingredientUnitId": request.ingredientUnitId,
          "amount": request.amount,
        }),
        headers: <String, String>{
          'Content-Type': 'application/json; charset=UTF-8',
        });

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
    var response = await http.put(uri,
        body: json.encode(<String, Object>{
          "ingredientId": request.ingredientId,
          "ingredientUnitId": request.ingredientUnitId,
          "amount": request.amount,
        }),
        headers: <String, String>{
          'Content-Type': 'application/json; charset=UTF-8',
        });

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
}
