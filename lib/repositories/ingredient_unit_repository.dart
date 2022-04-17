import 'dart:convert';
import 'package:http/http.dart' as http;
import 'package:logging/logging.dart';
import 'package:recipy_frontend/config/api_config.dart';
import 'package:recipy_frontend/helpers/http_helper.dart';
import 'package:recipy_frontend/models/ingredient_unit.dart';
import 'package:recipy_frontend/pages/ingredient_units/add_unit_request.dart';
import 'package:recipy_frontend/pages/ingredient_units/ingredient_units_controller.dart';
import 'package:recipy_frontend/repositories/http_request_result.dart';

class RecipyIngredientUnitRepository extends IngredientUnitRepository {
  static final log = Logger('IngredientUnitRepository');

  @override
  Future<List<IngredientUnit>> fetchIngredientUnits() async {
    var uri =
        Uri.parse(APIConfiguration.backendBaseUri + "/v1/ingredient/units");
    var response = await http.get(uri);

    if (is2xx(response.statusCode)) {
      Iterable l = json.decode(utf8.decode(response.bodyBytes));
      List<IngredientUnit> ingredientUnits = List<IngredientUnit>.from(
          l.map((json) => IngredientUnit.fromJson(json)));
      log.fine("Fetched ${ingredientUnits.length} ingredientUnits");

      return ingredientUnits;
    } else {
      String error = 'Failed to load ingredientUnits (${response.statusCode})';
      log.warning(error);
      throw Exception(error);
    }
  }

  @override
  Future<HttpPostResult> addIngredientUnit(
      AddIngredientUnitRequest request) async {
    var uri =
        Uri.parse(APIConfiguration.backendBaseUri + "/v1/ingredient/unit");
    var response = await http.post(uri,
        body: json.encode(<String, String>{"name": request.name}),
        headers: <String, String>{
          'Content-Type': 'application/json; charset=UTF-8',
        });

    if (is2xx(response.statusCode)) {
      return HttpPostResult(success: true);
    } else {
      String errorMessage =
          json.decode(utf8.decode(response.bodyBytes))["message"];
      log.warning(
          'Failed to add ingredientUnit $errorMessage (${response.statusCode})');
      return HttpPostResult(success: false, error: errorMessage);
    }
  }
}
