// coverage:ignore-file
// GENERATED CODE - DO NOT MODIFY BY HAND
// ignore_for_file: type=lint
// ignore_for_file: unused_element, deprecated_member_use, deprecated_member_use_from_same_package, use_function_type_syntax_for_parameters, unnecessary_const, avoid_init_to_null, invalid_override_different_default_values_named, prefer_expression_function_bodies, annotate_overrides, invalid_annotation_target, unnecessary_question_mark

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
      _$LoginModelCopyWithImpl<$Res, LoginModel>;
  @useResult
  $Res call(
      {bool successfullyLoggedIn, bool loginInProgress, String? errorCode});
}

/// @nodoc
class _$LoginModelCopyWithImpl<$Res, $Val extends LoginModel>
    implements $LoginModelCopyWith<$Res> {
  _$LoginModelCopyWithImpl(this._value, this._then);

  // ignore: unused_field
  final $Val _value;
  // ignore: unused_field
  final $Res Function($Val) _then;

  @pragma('vm:prefer-inline')
  @override
  $Res call({
    Object? successfullyLoggedIn = null,
    Object? loginInProgress = null,
    Object? errorCode = freezed,
  }) {
    return _then(_value.copyWith(
      successfullyLoggedIn: null == successfullyLoggedIn
          ? _value.successfullyLoggedIn
          : successfullyLoggedIn // ignore: cast_nullable_to_non_nullable
              as bool,
      loginInProgress: null == loginInProgress
          ? _value.loginInProgress
          : loginInProgress // ignore: cast_nullable_to_non_nullable
              as bool,
      errorCode: freezed == errorCode
          ? _value.errorCode
          : errorCode // ignore: cast_nullable_to_non_nullable
              as String?,
    ) as $Val);
  }
}

/// @nodoc
abstract class _$$_LoginModelCopyWith<$Res>
    implements $LoginModelCopyWith<$Res> {
  factory _$$_LoginModelCopyWith(
          _$_LoginModel value, $Res Function(_$_LoginModel) then) =
      __$$_LoginModelCopyWithImpl<$Res>;
  @override
  @useResult
  $Res call(
      {bool successfullyLoggedIn, bool loginInProgress, String? errorCode});
}

/// @nodoc
class __$$_LoginModelCopyWithImpl<$Res>
    extends _$LoginModelCopyWithImpl<$Res, _$_LoginModel>
    implements _$$_LoginModelCopyWith<$Res> {
  __$$_LoginModelCopyWithImpl(
      _$_LoginModel _value, $Res Function(_$_LoginModel) _then)
      : super(_value, _then);

  @pragma('vm:prefer-inline')
  @override
  $Res call({
    Object? successfullyLoggedIn = null,
    Object? loginInProgress = null,
    Object? errorCode = freezed,
  }) {
    return _then(_$_LoginModel(
      successfullyLoggedIn: null == successfullyLoggedIn
          ? _value.successfullyLoggedIn
          : successfullyLoggedIn // ignore: cast_nullable_to_non_nullable
              as bool,
      loginInProgress: null == loginInProgress
          ? _value.loginInProgress
          : loginInProgress // ignore: cast_nullable_to_non_nullable
              as bool,
      errorCode: freezed == errorCode
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
            other is _$_LoginModel &&
            (identical(other.successfullyLoggedIn, successfullyLoggedIn) ||
                other.successfullyLoggedIn == successfullyLoggedIn) &&
            (identical(other.loginInProgress, loginInProgress) ||
                other.loginInProgress == loginInProgress) &&
            (identical(other.errorCode, errorCode) ||
                other.errorCode == errorCode));
  }

  @override
  int get hashCode => Object.hash(
      runtimeType, successfullyLoggedIn, loginInProgress, errorCode);

  @JsonKey(ignore: true)
  @override
  @pragma('vm:prefer-inline')
  _$$_LoginModelCopyWith<_$_LoginModel> get copyWith =>
      __$$_LoginModelCopyWithImpl<_$_LoginModel>(this, _$identity);
}

abstract class _LoginModel implements LoginModel {
  const factory _LoginModel(
      {final bool successfullyLoggedIn,
      final bool loginInProgress,
      final String? errorCode}) = _$_LoginModel;

  @override
  bool get successfullyLoggedIn;
  @override
  bool get loginInProgress;
  @override
  String? get errorCode;
  @override
  @JsonKey(ignore: true)
  _$$_LoginModelCopyWith<_$_LoginModel> get copyWith =>
      throw _privateConstructorUsedError;
}
