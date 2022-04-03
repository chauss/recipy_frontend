import 'dart:convert';
import 'package:http/http.dart' as http;
import 'package:recipy_frontend/config/api.dart';
import 'package:recipy_frontend/models/recipe.dart';

class RecipeRepository {
  static Future<List<Recipe>> fetchRecipes() async {
    var uri = Uri.parse(APIConfiguration.backendBaseUri + "/recipes");
    var response = await http.get(uri);

    if (response.statusCode == 200) {
      Iterable l = json.decode(response.body);
      List<Recipe> recipes =
          List<Recipe>.from(l.map((json) => Recipe.fromJson(json)));
      return recipes;
    } else {
      throw Exception('Failed to load recipes');
    }
  }

  static Future<bool> addRecipe(Recipe recipe) async {
    var uri = Uri.parse(APIConfiguration.backendBaseUri + "/recipe");
    var response = await http.post(uri, body: {"name": recipe.name});

    if (response.statusCode == 201) {
      return true;
    } else {
      throw Exception('Failed to add recipe (${response.statusCode})');
    }
  }
}
