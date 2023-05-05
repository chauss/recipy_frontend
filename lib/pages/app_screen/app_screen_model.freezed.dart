// coverage:ignore-file
// GENERATED CODE - DO NOT MODIFY BY HAND
// ignore_for_file: type=lint
// ignore_for_file: unused_element, deprecated_member_use, deprecated_member_use_from_same_package, use_function_type_syntax_for_parameters, unnecessary_const, avoid_init_to_null, invalid_override_different_default_values_named, prefer_expression_function_bodies, annotate_overrides, invalid_annotation_target, unnecessary_question_mark

part of 'app_screen_model.dart';

// **************************************************************************
// FreezedGenerator
// **************************************************************************

T _$identity<T>(T value) => value;

final _privateConstructorUsedError = UnsupportedError(
    'It seems like you constructed your class using `MyClass._()`. This constructor is only meant to be used by freezed and you are not supposed to need it nor use it.\nPlease check the documentation here for more information: https://github.com/rrousselGit/freezed#custom-getters-and-methods');

/// @nodoc
mixin _$AppScreenModel {
  bool get isUserLoggedIn => throw _privateConstructorUsedError;
  int get currentPageIndex => throw _privateConstructorUsedError;

  @JsonKey(ignore: true)
  $AppScreenModelCopyWith<AppScreenModel> get copyWith =>
      throw _privateConstructorUsedError;
}

/// @nodoc
abstract class $AppScreenModelCopyWith<$Res> {
  factory $AppScreenModelCopyWith(
          AppScreenModel value, $Res Function(AppScreenModel) then) =
      _$AppScreenModelCopyWithImpl<$Res, AppScreenModel>;
  @useResult
  $Res call({bool isUserLoggedIn, int currentPageIndex});
}

/// @nodoc
class _$AppScreenModelCopyWithImpl<$Res, $Val extends AppScreenModel>
    implements $AppScreenModelCopyWith<$Res> {
  _$AppScreenModelCopyWithImpl(this._value, this._then);

  // ignore: unused_field
  final $Val _value;
  // ignore: unused_field
  final $Res Function($Val) _then;

  @pragma('vm:prefer-inline')
  @override
  $Res call({
    Object? isUserLoggedIn = null,
    Object? currentPageIndex = null,
  }) {
    return _then(_value.copyWith(
      isUserLoggedIn: null == isUserLoggedIn
          ? _value.isUserLoggedIn
          : isUserLoggedIn // ignore: cast_nullable_to_non_nullable
              as bool,
      currentPageIndex: null == currentPageIndex
          ? _value.currentPageIndex
          : currentPageIndex // ignore: cast_nullable_to_non_nullable
              as int,
    ) as $Val);
  }
}

/// @nodoc
abstract class _$$_AppScreenModelCopyWith<$Res>
    implements $AppScreenModelCopyWith<$Res> {
  factory _$$_AppScreenModelCopyWith(
          _$_AppScreenModel value, $Res Function(_$_AppScreenModel) then) =
      __$$_AppScreenModelCopyWithImpl<$Res>;
  @override
  @useResult
  $Res call({bool isUserLoggedIn, int currentPageIndex});
}

/// @nodoc
class __$$_AppScreenModelCopyWithImpl<$Res>
    extends _$AppScreenModelCopyWithImpl<$Res, _$_AppScreenModel>
    implements _$$_AppScreenModelCopyWith<$Res> {
  __$$_AppScreenModelCopyWithImpl(
      _$_AppScreenModel _value, $Res Function(_$_AppScreenModel) _then)
      : super(_value, _then);

  @pragma('vm:prefer-inline')
  @override
  $Res call({
    Object? isUserLoggedIn = null,
    Object? currentPageIndex = null,
  }) {
    return _then(_$_AppScreenModel(
      isUserLoggedIn: null == isUserLoggedIn
          ? _value.isUserLoggedIn
          : isUserLoggedIn // ignore: cast_nullable_to_non_nullable
              as bool,
      currentPageIndex: null == currentPageIndex
          ? _value.currentPageIndex
          : currentPageIndex // ignore: cast_nullable_to_non_nullable
              as int,
    ));
  }
}

/// @nodoc

class _$_AppScreenModel implements _AppScreenModel {
  const _$_AppScreenModel(
      {this.isUserLoggedIn = false, this.currentPageIndex = 0});

  @override
  @JsonKey()
  final bool isUserLoggedIn;
  @override
  @JsonKey()
  final int currentPageIndex;

  @override
  String toString() {
    return 'AppScreenModel(isUserLoggedIn: $isUserLoggedIn, currentPageIndex: $currentPageIndex)';
  }

  @override
  bool operator ==(dynamic other) {
    return identical(this, other) ||
        (other.runtimeType == runtimeType &&
            other is _$_AppScreenModel &&
            (identical(other.isUserLoggedIn, isUserLoggedIn) ||
                other.isUserLoggedIn == isUserLoggedIn) &&
            (identical(other.currentPageIndex, currentPageIndex) ||
                other.currentPageIndex == currentPageIndex));
  }

  @override
  int get hashCode =>
      Object.hash(runtimeType, isUserLoggedIn, currentPageIndex);

  @JsonKey(ignore: true)
  @override
  @pragma('vm:prefer-inline')
  _$$_AppScreenModelCopyWith<_$_AppScreenModel> get copyWith =>
      __$$_AppScreenModelCopyWithImpl<_$_AppScreenModel>(this, _$identity);
}

abstract class _AppScreenModel implements AppScreenModel {
  const factory _AppScreenModel(
      {final bool isUserLoggedIn,
      final int currentPageIndex}) = _$_AppScreenModel;

  @override
  bool get isUserLoggedIn;
  @override
  int get currentPageIndex;
  @override
  @JsonKey(ignore: true)
  _$$_AppScreenModelCopyWith<_$_AppScreenModel> get copyWith =>
      throw _privateConstructorUsedError;
}
