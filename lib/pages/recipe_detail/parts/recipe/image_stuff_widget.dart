import 'dart:typed_data';

import 'package:flutter/material.dart';
import 'package:recipy_frontend/models/recipe_image.dart';
import 'package:image_picker/image_picker.dart';

class ImageStuffWidget extends StatefulWidget {
  final List<RecipeImage>? recipeImages;

  const ImageStuffWidget({required this.recipeImages, Key? key})
      : super(key: key);

  @override
  State<StatefulWidget> createState() => ImageStuffWidgetState();
}

class ImageStuffWidgetState extends State<ImageStuffWidget> {
  final ImagePicker _picker = ImagePicker();
  Image? image;

  @override
  Widget build(BuildContext context) {
    if (image == null) {
      return Container(
        height: 300,
        width: 300,
        color: Colors.red,
        child: ElevatedButton(
          onPressed: pickImage,
          child: const Text("Pick Image"),
        ),
      );
    } else {
      return Container(
        child: image,
      );
    }
  }

  void pickImage() async {
    try {
      XFile? selectedImage = await _picker.pickImage(
        source: ImageSource.camera,
        maxWidth: 1920,
        maxHeight: 1080,
        requestFullMetadata: true,
      );
      final Uint8List bytes = await selectedImage!.readAsBytes();
      Image newImage = Image.memory(bytes);

      print("FileSize: ${bytes.length / 1024}kb");
      print("MimeType: ${selectedImage.mimeType}");
      print("Name: ${selectedImage.name}");
      print("Path: ${selectedImage.path}");
      print("RuntimeType: ${selectedImage.runtimeType}");
      print("LastModified: ${await selectedImage.lastModified()}");
      print("Length: ${await selectedImage.length()}");

      setState(() {
        image = newImage;
      });
    } catch (e) {
      print("Error: $e");
    }
  }
}
