import 'dart:convert';
import 'dart:io';
import 'package:http/http.dart' as http;
import 'package:logging/logging.dart';
import 'package:recipy_frontend/config/api_config.dart';
import 'package:recipy_frontend/config/error_config.dart';
import 'package:recipy_frontend/helpers/http_helper.dart';
import 'package:recipy_frontend/models/ingredient_unit.dart';
import 'package:recipy_frontend/pages/ingredient_units/parts/add_unit_request.dart';
import 'package:recipy_frontend/pages/ingredient_units/ingredient_units_controller.dart';
import 'package:recipy_frontend/pages/ingredient_units/parts/delete_ingredient_unit_request.dart';
import 'package:recipy_frontend/repositories/http_read_result.dart';
import 'package:recipy_frontend/repositories/http_write_result.dart';
import 'package:recipy_frontend/storage/in_memory_storage.dart';

class RecipyIngredientUnitRepository
    implements
        IngredientUnitRepository,
        InMemoryStorageIngredientUnitRepository {
  static final log = Logger('RecipyIngredientUnitRepository');

  @override
  Future<HttpReadResult<List<IngredientUnit>>> fetchIngredientUnits() async {
    var uri =
        Uri.parse("${APIConfiguration.backendBaseUri}/v1/ingredient/units");
    http.Response response;
    try {
      response = await http.get(uri);
    } catch (e) {
      log.warning(
          "Could not fetch ingredientUnits: Server unreachable? Error: $e");
      return HttpReadResult(
          success: false, errorCode: ErrorCodes.serverUnreachable);
    }

    if (is2xx(response.statusCode)) {
      Iterable l = json.decode(utf8.decode(response.bodyBytes));
      List<IngredientUnit> ingredientUnits = List<IngredientUnit>.from(
          l.map((json) => IngredientUnit.fromJson(json)));
      log.fine("Fetched ${ingredientUnits.length} ingredientUnits");

      return HttpReadResult(success: true, data: ingredientUnits);
    }
    return handleHttpReadFailed(
        log, response, "Failed to fetch ingredientUnits");
  }

  @override
  Future<HttpWriteResult> addIngredientUnit(
      AddIngredientUnitRequest request) async {
    var uri =
        Uri.parse("${APIConfiguration.backendBaseUri}/v1/ingredient/unit");
    http.Response response;
    try {
      response = await http.post(uri,
          body: json.encode(<String, String>{"name": request.name}),
          headers: <String, String>{
            HttpHeaders.contentTypeHeader: 'application/json; charset=UTF-8',
            HttpHeaders.authorizationHeader: 'Bearer ${request.userToken}',
          });
    } catch (e) {
      log.warning(
          "Could not add ingredientUnit \"${request.name}\": Server unreachable? Error: $e");
      return HttpWriteResult(
          success: false, errorCode: ErrorCodes.serverUnreachable);
    }

    if (is2xx(response.statusCode)) {
      return HttpWriteResult(success: true);
    }
    return handleHttpWriteFailed(
        log, response, "Failed to add ingredientUnit \"${request.name}\"");
  }

  @override
  Future<HttpWriteResult> deleteIngredientUnitById(
      DeleteIngredientUnitRequest request) async {
    var uri = Uri.parse(
        "${APIConfiguration.backendBaseUri}/v1/ingredient/unit/${request.ingredientUnitId}");
    http.Response response;
    try {
      response = await http.delete(
        uri,
        headers: <String, String>{
          HttpHeaders.contentTypeHeader: 'application/json; charset=UTF-8',
          HttpHeaders.authorizationHeader: 'Bearer ${request.userToken}',
        },
      );
    } catch (e) {
      log.warning(
          "Could not delete ingredientUnit by id \"${request.ingredientUnitId}\": Server unreachable? Error: $e");
      log.warning("Could not delete ingredientUnit by id: Server unreachable");
      return HttpWriteResult(
          success: false, errorCode: ErrorCodes.serverUnreachable);
    }

    if (is2xx(response.statusCode)) {
      log.fine("Deleted ingredientUnit ${request.ingredientUnitId}");
      return HttpWriteResult(success: true);
    }
    return handleHttpWriteFailed(
        log, response, "Failed to delete ingredientUnit by id");
  }
}
