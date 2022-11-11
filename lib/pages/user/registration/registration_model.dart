import 'package:freezed_annotation/freezed_annotation.dart';

part 'registration_model.freezed.dart';

@freezed
class RegistrationModel with _$RegistrationModel {
  const factory RegistrationModel({
    String? registrationResult,
    int? errorCode,
  }) = _RegistrationModel;
}
