// coverage:ignore-file
// GENERATED CODE - DO NOT MODIFY BY HAND
// ignore_for_file: type=lint
// ignore_for_file: unused_element, deprecated_member_use, deprecated_member_use_from_same_package, use_function_type_syntax_for_parameters, unnecessary_const, avoid_init_to_null, invalid_override_different_default_values_named, prefer_expression_function_bodies, annotate_overrides, invalid_annotation_target

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
      _$RegistrationModelCopyWithImpl<$Res>;
  $Res call(
      {bool successfullyRegistered,
      bool registrationInProgress,
      String? errorCode});
}

/// @nodoc
class _$RegistrationModelCopyWithImpl<$Res>
    implements $RegistrationModelCopyWith<$Res> {
  _$RegistrationModelCopyWithImpl(this._value, this._then);

  final RegistrationModel _value;
  // ignore: unused_field
  final $Res Function(RegistrationModel) _then;

  @override
  $Res call({
    Object? successfullyRegistered = freezed,
    Object? registrationInProgress = freezed,
    Object? errorCode = freezed,
  }) {
    return _then(_value.copyWith(
      successfullyRegistered: successfullyRegistered == freezed
          ? _value.successfullyRegistered
          : successfullyRegistered // ignore: cast_nullable_to_non_nullable
              as bool,
      registrationInProgress: registrationInProgress == freezed
          ? _value.registrationInProgress
          : registrationInProgress // ignore: cast_nullable_to_non_nullable
              as bool,
      errorCode: errorCode == freezed
          ? _value.errorCode
          : errorCode // ignore: cast_nullable_to_non_nullable
              as String?,
    ));
  }
}

/// @nodoc
abstract class _$RegistrationModelCopyWith<$Res>
    implements $RegistrationModelCopyWith<$Res> {
  factory _$RegistrationModelCopyWith(
          _RegistrationModel value, $Res Function(_RegistrationModel) then) =
      __$RegistrationModelCopyWithImpl<$Res>;
  @override
  $Res call(
      {bool successfullyRegistered,
      bool registrationInProgress,
      String? errorCode});
}

/// @nodoc
class __$RegistrationModelCopyWithImpl<$Res>
    extends _$RegistrationModelCopyWithImpl<$Res>
    implements _$RegistrationModelCopyWith<$Res> {
  __$RegistrationModelCopyWithImpl(
      _RegistrationModel _value, $Res Function(_RegistrationModel) _then)
      : super(_value, (v) => _then(v as _RegistrationModel));

  @override
  _RegistrationModel get _value => super._value as _RegistrationModel;

  @override
  $Res call({
    Object? successfullyRegistered = freezed,
    Object? registrationInProgress = freezed,
    Object? errorCode = freezed,
  }) {
    return _then(_RegistrationModel(
      successfullyRegistered: successfullyRegistered == freezed
          ? _value.successfullyRegistered
          : successfullyRegistered // ignore: cast_nullable_to_non_nullable
              as bool,
      registrationInProgress: registrationInProgress == freezed
          ? _value.registrationInProgress
          : registrationInProgress // ignore: cast_nullable_to_non_nullable
              as bool,
      errorCode: errorCode == freezed
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
            other is _RegistrationModel &&
            const DeepCollectionEquality()
                .equals(other.successfullyRegistered, successfullyRegistered) &&
            const DeepCollectionEquality()
                .equals(other.registrationInProgress, registrationInProgress) &&
            const DeepCollectionEquality().equals(other.errorCode, errorCode));
  }

  @override
  int get hashCode => Object.hash(
      runtimeType,
      const DeepCollectionEquality().hash(successfullyRegistered),
      const DeepCollectionEquality().hash(registrationInProgress),
      const DeepCollectionEquality().hash(errorCode));

  @JsonKey(ignore: true)
  @override
  _$RegistrationModelCopyWith<_RegistrationModel> get copyWith =>
      __$RegistrationModelCopyWithImpl<_RegistrationModel>(this, _$identity);
}

abstract class _RegistrationModel implements RegistrationModel {
  const factory _RegistrationModel(
      {final bool successfullyRegistered,
      final bool registrationInProgress,
      final String? errorCode}) = _$_RegistrationModel;

  @override
  bool get successfullyRegistered => throw _privateConstructorUsedError;
  @override
  bool get registrationInProgress => throw _privateConstructorUsedError;
  @override
  String? get errorCode => throw _privateConstructorUsedError;
  @override
  @JsonKey(ignore: true)
  _$RegistrationModelCopyWith<_RegistrationModel> get copyWith =>
      throw _privateConstructorUsedError;
}
