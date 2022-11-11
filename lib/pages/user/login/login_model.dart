import 'package:freezed_annotation/freezed_annotation.dart';

part 'login_model.freezed.dart';

@freezed
class LoginModel with _$LoginModel {
  const factory LoginModel({
    @Default(false) bool successfullyLoggedIn,
    @Default(false) bool loginInProgress,
    String? errorCode,
  }) = _LoginModel;
}
