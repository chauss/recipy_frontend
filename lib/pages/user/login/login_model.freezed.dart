// coverage:ignore-file
// GENERATED CODE - DO NOT MODIFY BY HAND
// ignore_for_file: type=lint
// ignore_for_file: unused_element, deprecated_member_use, deprecated_member_use_from_same_package, use_function_type_syntax_for_parameters, unnecessary_const, avoid_init_to_null, invalid_override_different_default_values_named, prefer_expression_function_bodies, annotate_overrides, invalid_annotation_target

part of 'login_model.dart';

// **************************************************************************
// FreezedGenerator
// **************************************************************************

T _$identity<T>(T value) => value;

final _privateConstructorUsedError = UnsupportedError(
    'It seems like you constructed your class using `MyClass._()`. This constructor is only meant to be used by freezed and you are not supposed to need it nor use it.\nPlease check the documentation here for more information: https://github.com/rrousselGit/freezed#custom-getters-and-methods');

/// @nodoc
mixin _$LoginModel {
  bool get successfullyLoggedIn => throw _privateConstructorUsedError;
  bool get loginInProgress => throw _privateConstructorUsedError;
  String? get errorCode => throw _privateConstructorUsedError;

  @JsonKey(ignore: true)
  $LoginModelCopyWith<LoginModel> get copyWith =>
      throw _privateConstructorUsedError;
}

/// @nodoc
abstract class $LoginModelCopyWith<$Res> {
  factory $LoginModelCopyWith(
          LoginModel value, $Res Function(LoginModel) then) =
      _$LoginModelCopyWithImpl<$Res>;
  $Res call(
      {bool successfullyLoggedIn, bool loginInProgress, String? errorCode});
}

/// @nodoc
class _$LoginModelCopyWithImpl<$Res> implements $LoginModelCopyWith<$Res> {
  _$LoginModelCopyWithImpl(this._value, this._then);

  final LoginModel _value;
  // ignore: unused_field
  final $Res Function(LoginModel) _then;

  @override
  $Res call({
    Object? successfullyLoggedIn = freezed,
    Object? loginInProgress = freezed,
    Object? errorCode = freezed,
  }) {
    return _then(_value.copyWith(
      successfullyLoggedIn: successfullyLoggedIn == freezed
          ? _value.successfullyLoggedIn
          : successfullyLoggedIn // ignore: cast_nullable_to_non_nullable
              as bool,
      loginInProgress: loginInProgress == freezed
          ? _value.loginInProgress
          : loginInProgress // ignore: cast_nullable_to_non_nullable
              as bool,
      errorCode: errorCode == freezed
          ? _value.errorCode
          : errorCode // ignore: cast_nullable_to_non_nullable
              as String?,
    ));
  }
}

/// @nodoc
abstract class _$LoginModelCopyWith<$Res> implements $LoginModelCopyWith<$Res> {
  factory _$LoginModelCopyWith(
          _LoginModel value, $Res Function(_LoginModel) then) =
      __$LoginModelCopyWithImpl<$Res>;
  @override
  $Res call(
      {bool successfullyLoggedIn, bool loginInProgress, String? errorCode});
}

/// @nodoc
class __$LoginModelCopyWithImpl<$Res> extends _$LoginModelCopyWithImpl<$Res>
    implements _$LoginModelCopyWith<$Res> {
  __$LoginModelCopyWithImpl(
      _LoginModel _value, $Res Function(_LoginModel) _then)
      : super(_value, (v) => _then(v as _LoginModel));

  @override
  _LoginModel get _value => super._value as _LoginModel;

  @override
  $Res call({
    Object? successfullyLoggedIn = freezed,
    Object? loginInProgress = freezed,
    Object? errorCode = freezed,
  }) {
    return _then(_LoginModel(
      successfullyLoggedIn: successfullyLoggedIn == freezed
          ? _value.successfullyLoggedIn
          : successfullyLoggedIn // ignore: cast_nullable_to_non_nullable
              as bool,
      loginInProgress: loginInProgress == freezed
          ? _value.loginInProgress
          : loginInProgress // ignore: cast_nullable_to_non_nullable
              as bool,
      errorCode: errorCode == freezed
          ? _value.errorCode
          : errorCode // ignore: cast_nullable_to_non_nullable
              as String?,
    ));
  }
}

/// @nodoc

class _$_LoginModel implements _LoginModel {
  const _$_LoginModel(
      {this.successfullyLoggedIn = false,
      this.loginInProgress = false,
      this.errorCode});

  @override
  @JsonKey()
  final bool successfullyLoggedIn;
  @override
  @JsonKey()
  final bool loginInProgress;
  @override
  final String? errorCode;

  @override
  String toString() {
    return 'LoginModel(successfullyLoggedIn: $successfullyLoggedIn, loginInProgress: $loginInProgress, errorCode: $errorCode)';
  }

  @override
  bool operator ==(dynamic other) {
    return identical(this, other) ||
        (other.runtimeType == runtimeType &&
            other is _LoginModel &&
            const DeepCollectionEquality()
                .equals(other.successfullyLoggedIn, successfullyLoggedIn) &&
            const DeepCollectionEquality()
                .equals(other.loginInProgress, loginInProgress) &&
            const DeepCollectionEquality().equals(other.errorCode, errorCode));
  }

  @override
  int get hashCode => Object.hash(
      runtimeType,
      const DeepCollectionEquality().hash(successfullyLoggedIn),
      const DeepCollectionEquality().hash(loginInProgress),
      const DeepCollectionEquality().hash(errorCode));

  @JsonKey(ignore: true)
  @override
  _$LoginModelCopyWith<_LoginModel> get copyWith =>
      __$LoginModelCopyWithImpl<_LoginModel>(this, _$identity);
}

abstract class _LoginModel implements LoginModel {
  const factory _LoginModel(
      {final bool successfullyLoggedIn,
      final bool loginInProgress,
      final String? errorCode}) = _$_LoginModel;

  @override
  bool get successfullyLoggedIn => throw _privateConstructorUsedError;
  @override
  bool get loginInProgress => throw _privateConstructorUsedError;
  @override
  String? get errorCode => throw _privateConstructorUsedError;
  @override
  @JsonKey(ignore: true)
  _$LoginModelCopyWith<_LoginModel> get copyWith =>
      throw _privateConstructorUsedError;
}
