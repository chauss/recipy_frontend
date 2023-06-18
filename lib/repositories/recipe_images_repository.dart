import 'dart:convert';
import 'dart:io';
import 'dart:typed_data';

import 'package:http_parser/http_parser.dart';
import 'package:http/http.dart' as http;
import 'package:logging/logging.dart';
import 'package:recipy_frontend/config/api_config.dart';
import 'package:recipy_frontend/config/error_config.dart';
import 'package:recipy_frontend/helpers/http_helper.dart';
import 'package:recipy_frontend/models/recipe_image.dart';
import 'package:recipy_frontend/pages/recipe_detail/parts/recipe_images/recipe_images_controller.dart';
import 'package:recipy_frontend/repositories/http_read_result.dart';
import 'package:recipy_frontend/repositories/http_write_result.dart';
import 'package:recipy_frontend/storage/recipy_image_cache.dart';

class RecipyRecipeImagesRepository extends RecipeImagesRepository {
  static final log = Logger('RecipyRecipeImagesRepository');
  final RecipyImageCache imageCache = RecipyImageCache();

  @override
  Future<HttpReadResult<Uint8List>> getImageForRecipe(
      String recipeId, String imageId) async {
    final cachedImage = await imageCache.lookupImage(recipeId, imageId);
    if (cachedImage != null) {
      log.fine("Found image in cache: $recipeId/$imageId");
      return HttpReadResult(success: true, data: cachedImage);
    }
    final uri = Uri.parse(
        "${APIConfiguration.backendBaseUri}/v1/recipe/$recipeId/image/$imageId");
    http.Response response;
    try {
      response = await http.get(uri);
    } on SocketException catch (_) {
      log.warning("Could not fetch image for recipe: Server unreachable");
      return HttpReadResult(
          success: false, errorCode: ErrorCodes.serverUnreachable);
    }

    if (is2xx(response.statusCode)) {
      imageCache.addImage(recipeId, imageId, response.bodyBytes);
      return HttpReadResult(success: true, data: response.bodyBytes);
    }
    return handleHttpReadFailed(
        log, response, "Failed to fetch image $imageId for recipe $recipeId");
  }

  @override
  Future<HttpReadResult<List<RecipeImage>>> getRecipeImagesForRecipeId(
      String recipeId) async {
    final uri = Uri.parse(
        "${APIConfiguration.backendBaseUri}/v1/recipe/$recipeId/images");
    http.Response response;
    try {
      response = await http.get(uri);
    } on SocketException catch (_) {
      log.warning(
          "Could not fetch recipeImages for recipe: Server unreachable");
      return HttpReadResult(
          success: false, errorCode: ErrorCodes.serverUnreachable);
    }

    if (is2xx(response.statusCode)) {
      Iterable l = json.decode(utf8.decode(response.bodyBytes));

      List<RecipeImage> recipeImage =
          List<RecipeImage>.from(l.map((json) => RecipeImage.fromJson(json)));
      log.fine("Fetched ${recipeImage.length} recipeImages");

      return HttpReadResult(success: true, data: recipeImage);
    }
    return handleHttpReadFailed(
        log, response, "Failed to fetch recipeImages for recipe $recipeId");
  }

  @override
  Future<HttpWriteResult> addRecipeImage(
    String recipeId,
    Uint8List bytes,
    String fileExtension,
    String userToken,
  ) async {
    var uri = Uri.parse("${APIConfiguration.backendBaseUri}/v1/recipe/image");
    http.Response response;
    try {
      var request = http.MultipartRequest("POST", uri);
      request.fields["recipeId"] = recipeId;
      request.headers.addAll({
        HttpHeaders.authorizationHeader: 'Bearer $userToken',
      });
      request.files.add(
        http.MultipartFile.fromBytes(
          "image",
          bytes,
          filename: "image.$fileExtension",
          contentType: MediaType('image', fileExtension),
        ),
      );

      response = await http.Response.fromStream(await request.send());
    } on SocketException catch (_) {
      log.warning(
          "Could not add (recipe)Image to recipe $recipeId: Server unreachable");
      return HttpWriteResult(
          success: false, errorCode: ErrorCodes.serverUnreachable);
    }

    if (is2xx(response.statusCode)) {
      log.fine("Added (recipe)Image to recipe $recipeId");
      return HttpWriteResult(success: true);
    }
    return handleHttpWriteFailed(
        log, response, "Failed to add (recipe)Image to recipe $recipeId");
  }

  @override
  Future<HttpWriteResult> removeRecipeImage(
    String recipeId,
    String imageId,
    String userToken,
  ) async {
    var uri = Uri.parse(
        "${APIConfiguration.backendBaseUri}/v1/recipe/$recipeId/image/$imageId");
    http.Response response;
    try {
      response = await http.delete(
        uri,
        headers: {HttpHeaders.authorizationHeader: 'Bearer $userToken'},
      );
    } on SocketException catch (_) {
      log.warning(
          "Could not delete recipeImage $imageId from recipe $recipeId: Server unreachable");
      return HttpWriteResult(
          success: false, errorCode: ErrorCodes.serverUnreachable);
    }

    if (is2xx(response.statusCode)) {
      log.fine("Deleted recipeImage $imageId from recipe $recipeId");
      imageCache.removeImage(recipeId, imageId);
      return HttpWriteResult(success: true);
    }
    return handleHttpWriteFailed(log, response,
        "Failed to delete recipeImage $imageId from recipe $recipeId");
  }
}
