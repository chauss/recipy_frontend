import 'dart:convert';
import 'package:http/http.dart' as http;
import 'package:logging/logging.dart';
import 'package:recipy_frontend/config/api_config.dart';
import 'package:recipy_frontend/helpers/http_helper.dart';
import 'package:recipy_frontend/models/ingredient_unit.dart';
import 'package:recipy_frontend/models/ingredient_usage.dart';

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
}
