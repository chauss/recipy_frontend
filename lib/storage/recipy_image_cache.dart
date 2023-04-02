import 'dart:io';
import 'dart:typed_data';

import 'package:path_provider/path_provider.dart';

import 'package:flutter/foundation.dart' show kIsWeb;

class RecipyImageCache {
  Future<void> addImage(
      String recipeId, String imageName, Uint8List image) async {
    if (kIsWeb) return;
    final baseDir = await getApplicationDocumentsDirectory();
    final recipePath = "${baseDir.path}/$recipeId";
    final file = File("$recipePath/$imageName");
    if (file.existsSync()) {
      file.deleteSync();
    }
    file.createSync(recursive: true);
    file.writeAsBytes(image);
  }

  Future<Uint8List?> lookupImage(String recipeId, String imageName) async {
    if (kIsWeb) return null;
    final baseDir = await getApplicationDocumentsDirectory();
    final filePath = "${baseDir.path}/$recipeId/$imageName";
    final file = File(filePath);
    if (file.existsSync()) {
      return await file.readAsBytes();
    }
    return null;
  }

  Future<void> removeImage(String recipeId, String imageName) async {
    if (kIsWeb) return;
    final baseDir = await getApplicationDocumentsDirectory();
    final recipePath = "${baseDir.path}/$recipeId";
    final file = File("$recipePath/$imageName");
    if (file.existsSync()) {
      file.deleteSync();
    }
  }
}
