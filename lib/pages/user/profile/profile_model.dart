import 'package:freezed_annotation/freezed_annotation.dart';

part 'profile_model.freezed.dart';

@freezed
class ProfileModel with _$ProfileModel {
  const factory ProfileModel({
    @Default("") String displayName,
    @Default("") String email,
    @Default("") String userId,
  }) = _ProfileModel;
}
