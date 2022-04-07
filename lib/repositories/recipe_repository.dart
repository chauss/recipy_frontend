import 'dart:convert';
import 'package:http/http.dart' as http;
import 'package:logging/logging.dart';
import 'package:recipy_frontend/config/api_config.dart';
import 'package:recipy_frontend/helpers/http_helper.dart';
import 'package:recipy_frontend/models/recipe.dart';

class RecipeRepository {
  static final log = Logger('RecipeRepository');

  static Future<List<Recipe>> fetchRecipes() async {
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

  static Future<bool> addRecipe(String name) async {
    var uri = Uri.parse(APIConfiguration.backendBaseUri + "/v1/recipe");
    var response = await http.post(uri,
        body: json.encode(<String, String>{"name": name}),
        headers: <String, String>{
          'Content-Type': 'application/json; charset=UTF-8',
        });

    if (is2xx(response.statusCode)) {
      return true;
    } else {
      log.warning('Failed to add recipe (${response.statusCode})');
      return false;
    }
  }
}
