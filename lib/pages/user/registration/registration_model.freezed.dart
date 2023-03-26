// coverage:ignore-file
// GENERATED CODE - DO NOT MODIFY BY HAND
// ignore_for_file: type=lint
// ignore_for_file: unused_element, deprecated_member_use, deprecated_member_use_from_same_package, use_function_type_syntax_for_parameters, unnecessary_const, avoid_init_to_null, invalid_override_different_default_values_named, prefer_expression_function_bodies, annotate_overrides, invalid_annotation_target, unnecessary_question_mark

part of 'registration_model.dart';

// **************************************************************************
// FreezedGenerator
// **************************************************************************

T _$identity<T>(T value) => value;

final _privateConstructorUsedError = UnsupportedError(
    'It seems like you constructed your class using `MyClass._()`. This constructor is only meant to be used by freezed and you are not supposed to need it nor use it.\nPlease check the documentation here for more information: https://github.com/rrousselGit/freezed#custom-getters-and-methods');

/// @nodoc
mixin _$RegistrationModel {
  bool get successfullyRegistered => throw _privateConstructorUsedError;
  bool get registrationInProgress => throw _privateConstructorUsedError;
  String? get errorCode => throw _privateConstructorUsedError;

  @JsonKey(ignore: true)
  $RegistrationModelCopyWith<RegistrationModel> get copyWith =>
      throw _privateConstructorUsedError;
}

/// @nodoc
abstract class $RegistrationModelCopyWith<$Res> {
  factory $RegistrationModelCopyWith(
          RegistrationModel value, $Res Function(RegistrationModel) then) =
      _$RegistrationModelCopyWithImpl<$Res, RegistrationModel>;
  @useResult
  $Res call(
      {bool successfullyRegistered,
      bool registrationInProgress,
      String? errorCode});
}

/// @nodoc
class _$RegistrationModelCopyWithImpl<$Res, $Val extends RegistrationModel>
    implements $RegistrationModelCopyWith<$Res> {
  _$RegistrationModelCopyWithImpl(this._value, this._then);

  // ignore: unused_field
  final $Val _value;
  // ignore: unused_field
  final $Res Function($Val) _then;

  @pragma('vm:prefer-inline')
  @override
  $Res call({
    Object? successfullyRegistered = null,
    Object? registrationInProgress = null,
    Object? errorCode = freezed,
  }) {
    return _then(_value.copyWith(
      successfullyRegistered: null == successfullyRegistered
          ? _value.successfullyRegistered
          : successfullyRegistered // ignore: cast_nullable_to_non_nullable
              as bool,
      registrationInProgress: null == registrationInProgress
          ? _value.registrationInProgress
          : registrationInProgress // ignore: cast_nullable_to_non_nullable
              as bool,
      errorCode: freezed == errorCode
          ? _value.errorCode
          : errorCode // ignore: cast_nullable_to_non_nullable
              as String?,
    ) as $Val);
  }
}

/// @nodoc
abstract class _$$_RegistrationModelCopyWith<$Res>
    implements $RegistrationModelCopyWith<$Res> {
  factory _$$_RegistrationModelCopyWith(_$_RegistrationModel value,
          $Res Function(_$_RegistrationModel) then) =
      __$$_RegistrationModelCopyWithImpl<$Res>;
  @override
  @useResult
  $Res call(
      {bool successfullyRegistered,
      bool registrationInProgress,
      String? errorCode});
}

/// @nodoc
class __$$_RegistrationModelCopyWithImpl<$Res>
    extends _$RegistrationModelCopyWithImpl<$Res, _$_RegistrationModel>
    implements _$$_RegistrationModelCopyWith<$Res> {
  __$$_RegistrationModelCopyWithImpl(
      _$_RegistrationModel _value, $Res Function(_$_RegistrationModel) _then)
      : super(_value, _then);

  @pragma('vm:prefer-inline')
  @override
  $Res call({
    Object? successfullyRegistered = null,
    Object? registrationInProgress = null,
    Object? errorCode = freezed,
  }) {
    return _then(_$_RegistrationModel(
      successfullyRegistered: null == successfullyRegistered
          ? _value.successfullyRegistered
          : successfullyRegistered // ignore: cast_nullable_to_non_nullable
              as bool,
      registrationInProgress: null == registrationInProgress
          ? _value.registrationInProgress
          : registrationInProgress // ignore: cast_nullable_to_non_nullable
              as bool,
      errorCode: freezed == errorCode
          ? _value.errorCode
          : errorCode // ignore: cast_nullable_to_non_nullable
              as String?,
    ));
  }
}

/// @nodoc

class _$_RegistrationModel implements _RegistrationModel {
  const _$_RegistrationModel(
      {this.successfullyRegistered = false,
      this.registrationInProgress = false,
      this.errorCode});

  @override
  @JsonKey()
  final bool successfullyRegistered;
  @override
  @JsonKey()
  final bool registrationInProgress;
  @override
  final String? errorCode;

  @override
  String toString() {
    return 'RegistrationModel(successfullyRegistered: $successfullyRegistered, registrationInProgress: $registrationInProgress, errorCode: $errorCode)';
  }

  @override
  bool operator ==(dynamic other) {
    return identical(this, other) ||
        (other.runtimeType == runtimeType &&
            other is _$_RegistrationModel &&
            (identical(other.successfullyRegistered, successfullyRegistered) ||
                other.successfullyRegistered == successfullyRegistered) &&
            (identical(other.registrationInProgress, registrationInProgress) ||
                other.registrationInProgress == registrationInProgress) &&
            (identical(other.errorCode, errorCode) ||
                other.errorCode == errorCode));
  }

  @override
  int get hashCode => Object.hash(
      runtimeType, successfullyRegistered, registrationInProgress, errorCode);

  @JsonKey(ignore: true)
  @override
  @pragma('vm:prefer-inline')
  _$$_RegistrationModelCopyWith<_$_RegistrationModel> get copyWith =>
      __$$_RegistrationModelCopyWithImpl<_$_RegistrationModel>(
          this, _$identity);
}

abstract class _RegistrationModel implements RegistrationModel {
  const factory _RegistrationModel(
      {final bool successfullyRegistered,
      final bool registrationInProgress,
      final String? errorCode}) = _$_RegistrationModel;

  @override
  bool get successfullyRegistered;
  @override
  bool get registrationInProgress;
  @override
  String? get errorCode;
  @override
  @JsonKey(ignore: true)
  _$$_RegistrationModelCopyWith<_$_RegistrationModel> get copyWith =>
      throw _privateConstructorUsedError;
}
