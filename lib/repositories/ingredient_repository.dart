import 'dart:convert';
import 'dart:io';
import 'package:http/http.dart' as http;
import 'package:logging/logging.dart';
import 'package:recipy_frontend/config/api_config.dart';
import 'package:recipy_frontend/helpers/http_helper.dart';
import 'package:recipy_frontend/models/ingredient.dart';
import 'package:recipy_frontend/pages/ingredients/parts/add_ingredient_request.dart';
import 'package:recipy_frontend/pages/ingredients/ingredients_controller.dart';
import 'package:recipy_frontend/pages/ingredients/parts/delete_ingredient_request.dart';
import 'package:recipy_frontend/repositories/http_read_result.dart';
import 'package:recipy_frontend/repositories/http_write_result.dart';
import 'package:recipy_frontend/storage/in_memory_storage.dart';

class RecipyIngredientRepository extends IngredientRepository
    with InMemoryStorageIngredientRepository {
  static final log = Logger('IngredientsRepository');

  @override
  Future<HttpReadResult<List<Ingredient>>> fetchIngredients() async {
    var uri = Uri.parse(APIConfiguration.backendBaseUri + "/v1/ingredients");
    http.Response response;
    try {
      response = await http.get(uri);
    } on SocketException catch (_) {
      String error = "Der Server konnte nicht erreicht werden";
      log.warning("Could not fetch ingredients: $error");
      return HttpReadResult(success: false, error: error);
    }

    if (is2xx(response.statusCode)) {
      Iterable l = json.decode(utf8.decode(response.bodyBytes));
      List<Ingredient> ingredients =
          List<Ingredient>.from(l.map((json) => Ingredient.fromJson(json)));
      log.fine("Fetched ${ingredients.length} ingredients");

      return HttpReadResult(success: true, data: ingredients);
    } else {
      String error = 'Failed to load ingredients (${response.statusCode})';
      log.warning(error);
      return HttpReadResult(success: false, error: error);
    }
  }

  @override
  Future<HttpWriteResult> addIngredient(AddIngredientRequest request) async {
    var uri = Uri.parse(APIConfiguration.backendBaseUri + "/v1/ingredient");
    http.Response response;
    try {
      response = await http.post(
        uri,
        body: json.encode(<String, String>{"name": request.name}),
        headers: <String, String>{
          'Content-Type': 'application/json; charset=UTF-8',
        },
      );
    } on SocketException catch (_) {
      String error = "Der Server konnte nicht erreicht werden";
      log.warning("Could not add ingredient \"${request.name}\": $error");
      return HttpWriteResult(success: false, error: error);
    }

    if (is2xx(response.statusCode)) {
      log.fine("Added ingredient \"${request.name}\"");
      return HttpWriteResult(success: true);
    } else {
      String errorMessage =
          json.decode(utf8.decode(response.bodyBytes))["message"];
      log.warning(
          'Failed to add ingredient $errorMessage (${response.statusCode})');
      return HttpWriteResult(success: false, error: errorMessage);
    }
  }

  @override
  Future<HttpWriteResult> deleteIngredientById(
      DeleteIngredientRequest request) async {
    var uri = Uri.parse(APIConfiguration.backendBaseUri +
        "/v1/ingredient/${request.ingredientId}");
    http.Response response;
    try {
      response = await http.delete(uri);
    } on SocketException catch (_) {
      String error = "Der Server konnte nicht erreicht werden";
      log.warning("Could not delete ingredient by id: $error");
      return HttpWriteResult(success: false, error: error);
    }

    if (is2xx(response.statusCode)) {
      log.fine("Deleted ingredient ${request.ingredientId}");
      return HttpWriteResult(success: true);
    } else {
      String errorMessage =
          json.decode(utf8.decode(response.bodyBytes))["message"];
      log.warning(
          'Failed to delete ingredient $errorMessage (${response.statusCode})');
      return HttpWriteResult(success: false, error: errorMessage);
    }
  }
}
