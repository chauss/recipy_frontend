import 'dart:convert';
import 'dart:io';
import 'package:http/http.dart' as http;
import 'package:logging/logging.dart';
import 'package:recipy_frontend/config/api_config.dart';
import 'package:recipy_frontend/helpers/http_helper.dart';
import 'package:recipy_frontend/models/ingredient_unit.dart';
import 'package:recipy_frontend/pages/ingredient_units/parts/add_unit_request.dart';
import 'package:recipy_frontend/pages/ingredient_units/ingredient_units_controller.dart';
import 'package:recipy_frontend/pages/ingredient_units/parts/delete_ingredient_unit_request.dart';
import 'package:recipy_frontend/repositories/http_read_result.dart';
import 'package:recipy_frontend/repositories/http_write_result.dart';
import 'package:recipy_frontend/storage/in_memory_storage.dart';

class RecipyIngredientUnitRepository extends IngredientUnitRepository
    with InMemoryStorageIngredientUnitRepository {
  static final log = Logger('IngredientUnitRepository');

  @override
  Future<HttpReadResult<List<IngredientUnit>>> fetchIngredientUnits() async {
    var uri =
        Uri.parse(APIConfiguration.backendBaseUri + "/v1/ingredient/units");
    http.Response response;
    try {
      response = await http.get(uri);
    } on SocketException catch (_) {
      String error = "Der Server konnte nicht erreicht werden";
      log.warning("Could not fetch ingredientUnits: $error");
      return HttpReadResult(success: false, error: error);
    }

    if (is2xx(response.statusCode)) {
      Iterable l = json.decode(utf8.decode(response.bodyBytes));
      List<IngredientUnit> ingredientUnits = List<IngredientUnit>.from(
          l.map((json) => IngredientUnit.fromJson(json)));
      log.fine("Fetched ${ingredientUnits.length} ingredientUnits");

      return HttpReadResult(success: true, data: ingredientUnits);
    } else {
      String error = 'Failed to load ingredientUnits (${response.statusCode})';
      log.warning(error);
      return HttpReadResult(success: false, error: error);
    }
  }

  @override
  Future<HttpWriteResult> addIngredientUnit(
      AddIngredientUnitRequest request) async {
    var uri =
        Uri.parse(APIConfiguration.backendBaseUri + "/v1/ingredient/unit");
    http.Response response;
    try {
      response = await http.post(uri,
          body: json.encode(<String, String>{"name": request.name}),
          headers: <String, String>{
            'Content-Type': 'application/json; charset=UTF-8',
          });
    } on SocketException catch (_) {
      String error = "Der Server konnte nicht erreicht werden";
      log.warning("Could not add ingredientUnit \"${request.name}\": $error");
      return HttpWriteResult(success: false, error: error);
    }

    if (is2xx(response.statusCode)) {
      return HttpWriteResult(success: true);
    } else {
      String errorMessage =
          json.decode(utf8.decode(response.bodyBytes))["message"];
      log.warning(
          'Failed to add ingredientUnit $errorMessage (${response.statusCode})');
      return HttpWriteResult(success: false, error: errorMessage);
    }
  }

  @override
  Future<HttpWriteResult> deleteIngredientUnitById(
      DeleteIngredientUnitRequest request) async {
    var uri = Uri.parse(APIConfiguration.backendBaseUri +
        "/v1/ingredient/unit/${request.ingredientUnitId}");
    http.Response response;
    try {
      response = await http.delete(uri);
    } on SocketException catch (_) {
      String error = "Der Server konnte nicht erreicht werden";
      log.warning("Could not delete ingredientUnit by id: $error");
      return HttpWriteResult(success: false, error: error);
    }

    if (is2xx(response.statusCode)) {
      log.fine("Deleted ingredientUnit ${request.ingredientUnitId}");
      return HttpWriteResult(success: true);
    } else {
      String errorMessage =
          json.decode(utf8.decode(response.bodyBytes))["message"];
      log.warning(
          'Failed to delete ingredientUnit $errorMessage (${response.statusCode})');
      return HttpWriteResult(success: false, error: errorMessage);
    }
  }
}
