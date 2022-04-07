import 'dart:convert';
import 'package:http/http.dart' as http;
import 'package:logging/logging.dart';
import 'package:recipy_frontend/config/api_config.dart';
import 'package:recipy_frontend/helpers/http_helper.dart';
import 'package:recipy_frontend/models/ingredient_unit.dart';
import 'package:recipy_frontend/models/ingredient_usage.dart';

class IngredientUsageRepository {
  static final log = Logger('IngredientUsageRepository');

  static Future<List<IngredientUsage>> fetchIngredientUnits(
      String recipeId) async {
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
      log.warning('Failed to load ingredientUsages (${response.statusCode})');
      throw Exception('Failed to load ingredientUsages');
    }
  }

  static Future<bool> addIngredientUsage(
    String recipeId,
    String ingredientId,
    String ingredientUnitId,
    double amount,
  ) async {
    var uri =
        Uri.parse(APIConfiguration.backendBaseUri + "/v1/ingredient/usage");
    var response = await http.post(uri,
        body: json.encode(<String, Object>{
          "recipeId": recipeId,
          "ingredientId": ingredientId,
          "ingredientUnitId": ingredientUnitId,
          "amount": amount,
        }),
        headers: <String, String>{
          'Content-Type': 'application/json; charset=UTF-8',
        });

    if (is2xx(response.statusCode)) {
      return true;
    } else {
      String errorMessage =
          json.decode(utf8.decode(response.bodyBytes))["error"];
      log.warning(
          'Failed to add ingredientUsage $errorMessage (${response.statusCode})');
      return false;
    }
  }
}
