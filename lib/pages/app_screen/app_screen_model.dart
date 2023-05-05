import 'package:freezed_annotation/freezed_annotation.dart';

part 'app_screen_model.freezed.dart';

@freezed
class AppScreenModel with _$AppScreenModel {
  const factory AppScreenModel({
    @Default(false) bool isUserLoggedIn,
    @Default(0) int currentPageIndex,
  }) = _AppScreenModel;
}
