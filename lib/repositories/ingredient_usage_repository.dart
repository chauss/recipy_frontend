import 'dart:convert';
import 'package:http/http.dart' as http;
import 'package:logging/logging.dart';
import 'package:recipy_frontend/config/api_config.dart';
import 'package:recipy_frontend/helpers/http_helper.dart';
import 'package:recipy_frontend/models/ingredient_unit.dart';
import 'package:recipy_frontend/models/ingredient_usage.dart';
import 'package:recipy_frontend/pages/recipe_detail/add_ingredient_usage_request.dart';
import 'package:recipy_frontend/repositories/http_request_result.dart';

class IngredientUsageRepository {
  final log = Logger('IngredientUsageRepository');

  Future<List<IngredientUsage>> fetchIngredientUnits(String recipeId) async {
    var uri = Uri.parse(APIConfiguration.backendBaseUri +
        "/v1/ingredient/usages?recipeId=$recipeId");
    var response = await http.get(uri);

    if (is2xx(response.statusCode)) {
      Iterable l = json.decode(utf8.decode(response.bodyBytes));
      List<IngredientUsage> ingredientUsages = List<IngredientUsage>.from(
          l.map((json) => IngredientUnit.fromJson(json)));
      log.fine("Fetched ${ingredientUsages.length} ingredientUsages");

      return ingredientUsages;
    } else {
      String error =
          'Failed to load ingredientUsages for recipe ($recipeId) (${response.statusCode})';
      log.warning(error);
      throw Exception(error);
    }
  }

  Future<HttpPostResult> addIngredientUsage(
      AddIngredientUsageRequest request) async {
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
      return HttpPostResult(success: true);
    } else {
      String errorMessage =
          json.decode(utf8.decode(response.bodyBytes))["message"];
      log.warning(
          'Failed to add ingredientUsage $errorMessage (${response.statusCode})');
      return HttpPostResult(success: false, error: errorMessage);
    }
  }
}
