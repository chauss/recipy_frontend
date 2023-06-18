# recipy_frontend

This is the frontend application for Recipy. Recipy is a recipe management software that allows you to save your recipes and more.

# Builing freezed data classes

Some classes are annotated with @freezed. When changing them the following command needs to be run to generate the corresponding \*.feezed.dart file:

```bash
dart run build_runner build
```

If there is an error message like "Could not find a file named "pubspec.yaml" in "/Users/<username>/.pub-cache/hosted/pub.dartlang..." the following could help troubleshoot:

```bash
rm -rf /Users/<username>/.pub-cache
flutter clean
dart pub get
flutter pub get
```
