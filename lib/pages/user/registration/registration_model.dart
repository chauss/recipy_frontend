import 'package:freezed_annotation/freezed_annotation.dart';

part 'registration_model.freezed.dart';

@freezed
class RegistrationModel with _$RegistrationModel {
  const factory RegistrationModel({
    @Default(false) bool successfullyRegistered,
    @Default(false) bool registrationInProgress,
    String? errorCode,
  }) = _RegistrationModel;
}
