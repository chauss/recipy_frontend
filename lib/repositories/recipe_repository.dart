import 'dart:convert';
import 'package:http/http.dart' as http;
import 'package:logging/logging.dart';
import 'package:recipy_frontend/config/api_config.dart';
import 'package:recipy_frontend/helpers/http_helper.dart';
import 'package:recipy_frontend/models/recipe.dart';
import 'package:recipy_frontend/pages/recipe_detail/add_ingredient_usage_request.dart';
import 'package:recipy_frontend/pages/recipe_detail/recipe_detail_controller.dart';
import 'package:recipy_frontend/pages/recipe_detail/update_ingredient_usage_request.dart';
import 'package:recipy_frontend/pages/recipe_overview/add_recipe_request.dart';
import 'package:recipy_frontend/pages/recipe_overview/recipe_overview_controller.dart';
import 'package:recipy_frontend/repositories/http_request_result.dart';

class RecipyRecipeRepository extends RecipeOverviewRepository
    with RecipeDetailRepository {
  static final log = Logger('RecipeRepository');

  @override
  Future<List<Recipe>> fetchRecipes() async {
    var uri = Uri.parse(APIConfiguration.backendBaseUri + "/v1/recipes");
    var response = await http.get(uri);

    if (is2xx(response.statusCode)) {
      Iterable l = json.decode(utf8.decode(response.bodyBytes));
      List<Recipe> recipes =
          List<Recipe>.from(l.map((json) => Recipe.fromJson(json)));
      log.fine("Fetched ${recipes.length} recipes");

      return recipes;
    } else {
      log.warning('Failed to load recipes (${response.statusCode})');
      throw Exception('Failed to load recipes');
    }
  }

  @override
  Future<HttpPostResult> addRecipe(AddRecipeRequest request) async {
    var uri = Uri.parse(APIConfiguration.backendBaseUri + "/v1/recipe");
    var response = await http.post(uri,
        body: json.encode(<String, String>{"name": request.name}),
        headers: <String, String>{
          'Content-Type': 'application/json; charset=UTF-8',
        });

    if (is2xx(response.statusCode)) {
      log.fine("Added recipe \"${request.name}\"");
      return HttpPostResult(success: true);
    } else {
      String errorMessage =
          json.decode(utf8.decode(response.bodyBytes))["message"];
      log.warning(
          'Failed to add recipe $errorMessage (${response.statusCode})');
      return HttpPostResult(success: false, error: errorMessage);
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
  Future<HttpPostResult> createIngredientUsage(
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
      return HttpPostResult(success: true);
    } else {
      String errorMessage =
          json.decode(utf8.decode(response.bodyBytes))["message"];
      log.warning(
          'Failed to add ingredientUsage $errorMessage (${response.statusCode})');
      return HttpPostResult(success: false, error: errorMessage);
    }
  }

  @override
  Future<HttpPostResult> updateIngredientUsage(
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
      return HttpPostResult(success: true);
    } else {
      String errorMessage =
          json.decode(utf8.decode(response.bodyBytes))["message"];
      log.warning(
          'Failed to update ingredientUsage $errorMessage (${response.statusCode})');
      return HttpPostResult(success: false, error: errorMessage);
    }
  }
}
