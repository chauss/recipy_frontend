// coverage:ignore-file
// GENERATED CODE - DO NOT MODIFY BY HAND
// ignore_for_file: type=lint
// ignore_for_file: unused_element, deprecated_member_use, deprecated_member_use_from_same_package, use_function_type_syntax_for_parameters, unnecessary_const, avoid_init_to_null, invalid_override_different_default_values_named, prefer_expression_function_bodies, annotate_overrides, invalid_annotation_target

part of 'recipe_overview_model.dart';

// **************************************************************************
// FreezedGenerator
// **************************************************************************

T _$identity<T>(T value) => value;

final _privateConstructorUsedError = UnsupportedError(
    'It seems like you constructed your class using `MyClass._()`. This constructor is only meant to be used by freezed and you are not supposed to need it nor use it.\nPlease check the documentation here for more information: https://github.com/rrousselGit/freezed#custom-getters-and-methods');

/// @nodoc
mixin _$RecipeOverviewModel {
  List<RecipeOverview> get recipeOverviews =>
      throw _privateConstructorUsedError;
  bool get isLoading => throw _privateConstructorUsedError;
  String? get error => throw _privateConstructorUsedError;

  @JsonKey(ignore: true)
  $RecipeOverviewModelCopyWith<RecipeOverviewModel> get copyWith =>
      throw _privateConstructorUsedError;
}

/// @nodoc
abstract class $RecipeOverviewModelCopyWith<$Res> {
  factory $RecipeOverviewModelCopyWith(
          RecipeOverviewModel value, $Res Function(RecipeOverviewModel) then) =
      _$RecipeOverviewModelCopyWithImpl<$Res>;
  $Res call(
      {List<RecipeOverview> recipeOverviews, bool isLoading, String? error});
}

/// @nodoc
class _$RecipeOverviewModelCopyWithImpl<$Res>
    implements $RecipeOverviewModelCopyWith<$Res> {
  _$RecipeOverviewModelCopyWithImpl(this._value, this._then);

  final RecipeOverviewModel _value;
  // ignore: unused_field
  final $Res Function(RecipeOverviewModel) _then;

  @override
  $Res call({
    Object? recipeOverviews = freezed,
    Object? isLoading = freezed,
    Object? error = freezed,
  }) {
    return _then(_value.copyWith(
      recipeOverviews: recipeOverviews == freezed
          ? _value.recipeOverviews
          : recipeOverviews // ignore: cast_nullable_to_non_nullable
              as List<RecipeOverview>,
      isLoading: isLoading == freezed
          ? _value.isLoading
          : isLoading // ignore: cast_nullable_to_non_nullable
              as bool,
      error: error == freezed
          ? _value.error
          : error // ignore: cast_nullable_to_non_nullable
              as String?,
    ));
  }
}

/// @nodoc
abstract class _$RecipeOverviewModelCopyWith<$Res>
    implements $RecipeOverviewModelCopyWith<$Res> {
  factory _$RecipeOverviewModelCopyWith(_RecipeOverviewModel value,
          $Res Function(_RecipeOverviewModel) then) =
      __$RecipeOverviewModelCopyWithImpl<$Res>;
  @override
  $Res call(
      {List<RecipeOverview> recipeOverviews, bool isLoading, String? error});
}

/// @nodoc
class __$RecipeOverviewModelCopyWithImpl<$Res>
    extends _$RecipeOverviewModelCopyWithImpl<$Res>
    implements _$RecipeOverviewModelCopyWith<$Res> {
  __$RecipeOverviewModelCopyWithImpl(
      _RecipeOverviewModel _value, $Res Function(_RecipeOverviewModel) _then)
      : super(_value, (v) => _then(v as _RecipeOverviewModel));

  @override
  _RecipeOverviewModel get _value => super._value as _RecipeOverviewModel;

  @override
  $Res call({
    Object? recipeOverviews = freezed,
    Object? isLoading = freezed,
    Object? error = freezed,
  }) {
    return _then(_RecipeOverviewModel(
      recipeOverviews: recipeOverviews == freezed
          ? _value.recipeOverviews
          : recipeOverviews // ignore: cast_nullable_to_non_nullable
              as List<RecipeOverview>,
      isLoading: isLoading == freezed
          ? _value.isLoading
          : isLoading // ignore: cast_nullable_to_non_nullable
              as bool,
      error: error == freezed
          ? _value.error
          : error // ignore: cast_nullable_to_non_nullable
              as String?,
    ));
  }
}

/// @nodoc

class _$_RecipeOverviewModel implements _RecipeOverviewModel {
  const _$_RecipeOverviewModel(
      {final List<RecipeOverview> recipeOverviews = const [],
      this.isLoading = false,
      this.error})
      : _recipeOverviews = recipeOverviews;

  final List<RecipeOverview> _recipeOverviews;
  @override
  @JsonKey()
  List<RecipeOverview> get recipeOverviews {
    // ignore: implicit_dynamic_type
    return EqualUnmodifiableListView(_recipeOverviews);
  }

  @override
  @JsonKey()
  final bool isLoading;
  @override
  final String? error;

  @override
  String toString() {
    return 'RecipeOverviewModel(recipeOverviews: $recipeOverviews, isLoading: $isLoading, error: $error)';
  }

  @override
  bool operator ==(dynamic other) {
    return identical(this, other) ||
        (other.runtimeType == runtimeType &&
            other is _RecipeOverviewModel &&
            const DeepCollectionEquality()
                .equals(other.recipeOverviews, recipeOverviews) &&
            const DeepCollectionEquality().equals(other.isLoading, isLoading) &&
            const DeepCollectionEquality().equals(other.error, error));
  }

  @override
  int get hashCode => Object.hash(
      runtimeType,
      const DeepCollectionEquality().hash(recipeOverviews),
      const DeepCollectionEquality().hash(isLoading),
      const DeepCollectionEquality().hash(error));

  @JsonKey(ignore: true)
  @override
  _$RecipeOverviewModelCopyWith<_RecipeOverviewModel> get copyWith =>
      __$RecipeOverviewModelCopyWithImpl<_RecipeOverviewModel>(
          this, _$identity);
}

abstract class _RecipeOverviewModel implements RecipeOverviewModel {
  const factory _RecipeOverviewModel(
      {final List<RecipeOverview> recipeOverviews,
      final bool isLoading,
      final String? error}) = _$_RecipeOverviewModel;

  @override
  List<RecipeOverview> get recipeOverviews =>
      throw _privateConstructorUsedError;
  @override
  bool get isLoading => throw _privateConstructorUsedError;
  @override
  String? get error => throw _privateConstructorUsedError;
  @override
  @JsonKey(ignore: true)
  _$RecipeOverviewModelCopyWith<_RecipeOverviewModel> get copyWith =>
      throw _privateConstructorUsedError;
}
