// coverage:ignore-file
// GENERATED CODE - DO NOT MODIFY BY HAND
// ignore_for_file: type=lint
// ignore_for_file: unused_element, deprecated_member_use, deprecated_member_use_from_same_package, use_function_type_syntax_for_parameters, unnecessary_const, avoid_init_to_null, invalid_override_different_default_values_named, prefer_expression_function_bodies, annotate_overrides, invalid_annotation_target, unnecessary_question_mark

part of 'device_info_state.dart';

// **************************************************************************
// FreezedGenerator
// **************************************************************************

T _$identity<T>(T value) => value;

final _privateConstructorUsedError = UnsupportedError(
    'It seems like you constructed your class using `MyClass._()`. This constructor is only meant to be used by freezed and you are not supposed to need it nor use it.\nPlease check the documentation here for more information: https://github.com/rrousselGit/freezed#custom-getters-and-methods');

/// @nodoc
mixin _$DeviceInfoState {
  bool get isMobile => throw _privateConstructorUsedError;
  bool get isTablet => throw _privateConstructorUsedError;
  bool get isWeb => throw _privateConstructorUsedError;
  bool get screenWithSmallWidth => throw _privateConstructorUsedError;

  @JsonKey(ignore: true)
  $DeviceInfoStateCopyWith<DeviceInfoState> get copyWith =>
      throw _privateConstructorUsedError;
}

/// @nodoc
abstract class $DeviceInfoStateCopyWith<$Res> {
  factory $DeviceInfoStateCopyWith(
          DeviceInfoState value, $Res Function(DeviceInfoState) then) =
      _$DeviceInfoStateCopyWithImpl<$Res, DeviceInfoState>;
  @useResult
  $Res call(
      {bool isMobile, bool isTablet, bool isWeb, bool screenWithSmallWidth});
}

/// @nodoc
class _$DeviceInfoStateCopyWithImpl<$Res, $Val extends DeviceInfoState>
    implements $DeviceInfoStateCopyWith<$Res> {
  _$DeviceInfoStateCopyWithImpl(this._value, this._then);

  // ignore: unused_field
  final $Val _value;
  // ignore: unused_field
  final $Res Function($Val) _then;

  @pragma('vm:prefer-inline')
  @override
  $Res call({
    Object? isMobile = null,
    Object? isTablet = null,
    Object? isWeb = null,
    Object? screenWithSmallWidth = null,
  }) {
    return _then(_value.copyWith(
      isMobile: null == isMobile
          ? _value.isMobile
          : isMobile // ignore: cast_nullable_to_non_nullable
              as bool,
      isTablet: null == isTablet
          ? _value.isTablet
          : isTablet // ignore: cast_nullable_to_non_nullable
              as bool,
      isWeb: null == isWeb
          ? _value.isWeb
          : isWeb // ignore: cast_nullable_to_non_nullable
              as bool,
      screenWithSmallWidth: null == screenWithSmallWidth
          ? _value.screenWithSmallWidth
          : screenWithSmallWidth // ignore: cast_nullable_to_non_nullable
              as bool,
    ) as $Val);
  }
}

/// @nodoc
abstract class _$$_DeviceInfoStateCopyWith<$Res>
    implements $DeviceInfoStateCopyWith<$Res> {
  factory _$$_DeviceInfoStateCopyWith(
          _$_DeviceInfoState value, $Res Function(_$_DeviceInfoState) then) =
      __$$_DeviceInfoStateCopyWithImpl<$Res>;
  @override
  @useResult
  $Res call(
      {bool isMobile, bool isTablet, bool isWeb, bool screenWithSmallWidth});
}

/// @nodoc
class __$$_DeviceInfoStateCopyWithImpl<$Res>
    extends _$DeviceInfoStateCopyWithImpl<$Res, _$_DeviceInfoState>
    implements _$$_DeviceInfoStateCopyWith<$Res> {
  __$$_DeviceInfoStateCopyWithImpl(
      _$_DeviceInfoState _value, $Res Function(_$_DeviceInfoState) _then)
      : super(_value, _then);

  @pragma('vm:prefer-inline')
  @override
  $Res call({
    Object? isMobile = null,
    Object? isTablet = null,
    Object? isWeb = null,
    Object? screenWithSmallWidth = null,
  }) {
    return _then(_$_DeviceInfoState(
      isMobile: null == isMobile
          ? _value.isMobile
          : isMobile // ignore: cast_nullable_to_non_nullable
              as bool,
      isTablet: null == isTablet
          ? _value.isTablet
          : isTablet // ignore: cast_nullable_to_non_nullable
              as bool,
      isWeb: null == isWeb
          ? _value.isWeb
          : isWeb // ignore: cast_nullable_to_non_nullable
              as bool,
      screenWithSmallWidth: null == screenWithSmallWidth
          ? _value.screenWithSmallWidth
          : screenWithSmallWidth // ignore: cast_nullable_to_non_nullable
              as bool,
    ));
  }
}

/// @nodoc

class _$_DeviceInfoState implements _DeviceInfoState {
  const _$_DeviceInfoState(
      {this.isMobile = false,
      this.isTablet = false,
      this.isWeb = false,
      this.screenWithSmallWidth = false});

  @override
  @JsonKey()
  final bool isMobile;
  @override
  @JsonKey()
  final bool isTablet;
  @override
  @JsonKey()
  final bool isWeb;
  @override
  @JsonKey()
  final bool screenWithSmallWidth;

  @override
  String toString() {
    return 'DeviceInfoState(isMobile: $isMobile, isTablet: $isTablet, isWeb: $isWeb, screenWithSmallWidth: $screenWithSmallWidth)';
  }

  @override
  bool operator ==(dynamic other) {
    return identical(this, other) ||
        (other.runtimeType == runtimeType &&
            other is _$_DeviceInfoState &&
            (identical(other.isMobile, isMobile) ||
                other.isMobile == isMobile) &&
            (identical(other.isTablet, isTablet) ||
                other.isTablet == isTablet) &&
            (identical(other.isWeb, isWeb) || other.isWeb == isWeb) &&
            (identical(other.screenWithSmallWidth, screenWithSmallWidth) ||
                other.screenWithSmallWidth == screenWithSmallWidth));
  }

  @override
  int get hashCode =>
      Object.hash(runtimeType, isMobile, isTablet, isWeb, screenWithSmallWidth);

  @JsonKey(ignore: true)
  @override
  @pragma('vm:prefer-inline')
  _$$_DeviceInfoStateCopyWith<_$_DeviceInfoState> get copyWith =>
      __$$_DeviceInfoStateCopyWithImpl<_$_DeviceInfoState>(this, _$identity);
}

abstract class _DeviceInfoState implements DeviceInfoState {
  const factory _DeviceInfoState(
      {final bool isMobile,
      final bool isTablet,
      final bool isWeb,
      final bool screenWithSmallWidth}) = _$_DeviceInfoState;

  @override
  bool get isMobile;
  @override
  bool get isTablet;
  @override
  bool get isWeb;
  @override
  bool get screenWithSmallWidth;
  @override
  @JsonKey(ignore: true)
  _$$_DeviceInfoStateCopyWith<_$_DeviceInfoState> get copyWith =>
      throw _privateConstructorUsedError;
}
