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

## Firebase Hosting

1. Install the firebase_tools
```bash
npm install -g firebase-tools
```

2. Make sure you are authenticated with google
```bash
firebase login
```

3. Initialize the project
```bash
firebase init
```

4. Deploy the currently build web app
Remember that you should have build the web app before running this (eg. with `flutter build web`)
```bash
firebase deploy
```

5. To deploy a preview of the web app run
```bash
firebase hosting:channel:deploy preprod --expires 30d
```
Info:
- preprod is the name of the channel, it can be exchanged for anything to not override the current preprod channel
- 30d means 30 days and is currently to max time that can be set to expires