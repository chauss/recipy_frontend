import 'dart:convert';
import 'dart:io';
import 'package:http/http.dart' as http;
import 'package:logging/logging.dart';
import 'package:recipy_frontend/config/api_config.dart';
import 'package:recipy_frontend/helpers/http_helper.dart';
import 'package:recipy_frontend/models/ingredient.dart';

class IngredientRepository {
  static final log = Logger('IngredientsRepository');

  static Future<List<Ingredient>> fetchIngredients() async {
    var uri = Uri.parse(APIConfiguration.backendBaseUri + "/v1/ingredients");
    var response = await http.get(uri);

    if (is2xx(response.statusCode)) {
      Iterable l = json.decode(utf8.decode(response.bodyBytes));
      List<Ingredient> ingredients =
          List<Ingredient>.from(l.map((json) => Ingredient.fromJson(json)));
      log.fine("Fetched ${ingredients.length} ingredients");

      return ingredients;
    } else {
      log.warning('Failed to load ingredients (${response.statusCode})');
      throw const HttpException('Failed to load ingredients');
    }
  }

  static Future<bool> addIngredient(String name) async {
    var uri = Uri.parse(APIConfiguration.backendBaseUri + "/v1/ingredient");
    var response = await http.post(uri,
        body: json.encode(<String, String>{"name": name}),
        headers: <String, String>{
          'Content-Type': 'application/json; charset=UTF-8',
        });

    if (is2xx(response.statusCode)) {
      return true;
    } else {
      String errorMessage =
          json.decode(utf8.decode(response.bodyBytes))["error"];
      log.warning(
          'Failed to add ingredient $errorMessage (${response.statusCode})');
      return false;
    }
  }
}
