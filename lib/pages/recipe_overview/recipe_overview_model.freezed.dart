// coverage:ignore-file
// GENERATED CODE - DO NOT MODIFY BY HAND
// ignore_for_file: type=lint
// ignore_for_file: unused_element, deprecated_member_use, deprecated_member_use_from_same_package, use_function_type_syntax_for_parameters, unnecessary_const, avoid_init_to_null, invalid_override_different_default_values_named, prefer_expression_function_bodies, annotate_overrides, invalid_annotation_target, unnecessary_question_mark

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
  bool get canAddNewRecipe => throw _privateConstructorUsedError;
  int? get errorCode => throw _privateConstructorUsedError;

  @JsonKey(ignore: true)
  $RecipeOverviewModelCopyWith<RecipeOverviewModel> get copyWith =>
      throw _privateConstructorUsedError;
}

/// @nodoc
abstract class $RecipeOverviewModelCopyWith<$Res> {
  factory $RecipeOverviewModelCopyWith(
          RecipeOverviewModel value, $Res Function(RecipeOverviewModel) then) =
      _$RecipeOverviewModelCopyWithImpl<$Res, RecipeOverviewModel>;
  @useResult
  $Res call(
      {List<RecipeOverview> recipeOverviews,
      bool isLoading,
      bool canAddNewRecipe,
      int? errorCode});
}

/// @nodoc
class _$RecipeOverviewModelCopyWithImpl<$Res, $Val extends RecipeOverviewModel>
    implements $RecipeOverviewModelCopyWith<$Res> {
  _$RecipeOverviewModelCopyWithImpl(this._value, this._then);

  // ignore: unused_field
  final $Val _value;
  // ignore: unused_field
  final $Res Function($Val) _then;

  @pragma('vm:prefer-inline')
  @override
  $Res call({
    Object? recipeOverviews = null,
    Object? isLoading = null,
    Object? canAddNewRecipe = null,
    Object? errorCode = freezed,
  }) {
    return _then(_value.copyWith(
      recipeOverviews: null == recipeOverviews
          ? _value.recipeOverviews
          : recipeOverviews // ignore: cast_nullable_to_non_nullable
              as List<RecipeOverview>,
      isLoading: null == isLoading
          ? _value.isLoading
          : isLoading // ignore: cast_nullable_to_non_nullable
              as bool,
      canAddNewRecipe: null == canAddNewRecipe
          ? _value.canAddNewRecipe
          : canAddNewRecipe // ignore: cast_nullable_to_non_nullable
              as bool,
      errorCode: freezed == errorCode
          ? _value.errorCode
          : errorCode // ignore: cast_nullable_to_non_nullable
              as int?,
    ) as $Val);
  }
}

/// @nodoc
abstract class _$$_RecipeOverviewModelCopyWith<$Res>
    implements $RecipeOverviewModelCopyWith<$Res> {
  factory _$$_RecipeOverviewModelCopyWith(_$_RecipeOverviewModel value,
          $Res Function(_$_RecipeOverviewModel) then) =
      __$$_RecipeOverviewModelCopyWithImpl<$Res>;
  @override
  @useResult
  $Res call(
      {List<RecipeOverview> recipeOverviews,
      bool isLoading,
      bool canAddNewRecipe,
      int? errorCode});
}

/// @nodoc
class __$$_RecipeOverviewModelCopyWithImpl<$Res>
    extends _$RecipeOverviewModelCopyWithImpl<$Res, _$_RecipeOverviewModel>
    implements _$$_RecipeOverviewModelCopyWith<$Res> {
  __$$_RecipeOverviewModelCopyWithImpl(_$_RecipeOverviewModel _value,
      $Res Function(_$_RecipeOverviewModel) _then)
      : super(_value, _then);

  @pragma('vm:prefer-inline')
  @override
  $Res call({
    Object? recipeOverviews = null,
    Object? isLoading = null,
    Object? canAddNewRecipe = null,
    Object? errorCode = freezed,
  }) {
    return _then(_$_RecipeOverviewModel(
      recipeOverviews: null == recipeOverviews
          ? _value._recipeOverviews
          : recipeOverviews // ignore: cast_nullable_to_non_nullable
              as List<RecipeOverview>,
      isLoading: null == isLoading
          ? _value.isLoading
          : isLoading // ignore: cast_nullable_to_non_nullable
              as bool,
      canAddNewRecipe: null == canAddNewRecipe
          ? _value.canAddNewRecipe
          : canAddNewRecipe // ignore: cast_nullable_to_non_nullable
              as bool,
      errorCode: freezed == errorCode
          ? _value.errorCode
          : errorCode // ignore: cast_nullable_to_non_nullable
              as int?,
    ));
  }
}

/// @nodoc

class _$_RecipeOverviewModel implements _RecipeOverviewModel {
  const _$_RecipeOverviewModel(
      {final List<RecipeOverview> recipeOverviews = const [],
      this.isLoading = false,
      this.canAddNewRecipe = false,
      this.errorCode})
      : _recipeOverviews = recipeOverviews;

  final List<RecipeOverview> _recipeOverviews;
  @override
  @JsonKey()
  List<RecipeOverview> get recipeOverviews {
    if (_recipeOverviews is EqualUnmodifiableListView) return _recipeOverviews;
    // ignore: implicit_dynamic_type
    return EqualUnmodifiableListView(_recipeOverviews);
  }

  @override
  @JsonKey()
  final bool isLoading;
  @override
  @JsonKey()
  final bool canAddNewRecipe;
  @override
  final int? errorCode;

  @override
  String toString() {
    return 'RecipeOverviewModel(recipeOverviews: $recipeOverviews, isLoading: $isLoading, canAddNewRecipe: $canAddNewRecipe, errorCode: $errorCode)';
  }

  @override
  bool operator ==(dynamic other) {
    return identical(this, other) ||
        (other.runtimeType == runtimeType &&
            other is _$_RecipeOverviewModel &&
            const DeepCollectionEquality()
                .equals(other._recipeOverviews, _recipeOverviews) &&
            (identical(other.isLoading, isLoading) ||
                other.isLoading == isLoading) &&
            (identical(other.canAddNewRecipe, canAddNewRecipe) ||
                other.canAddNewRecipe == canAddNewRecipe) &&
            (identical(other.errorCode, errorCode) ||
                other.errorCode == errorCode));
  }

  @override
  int get hashCode => Object.hash(
      runtimeType,
      const DeepCollectionEquality().hash(_recipeOverviews),
      isLoading,
      canAddNewRecipe,
      errorCode);

  @JsonKey(ignore: true)
  @override
  @pragma('vm:prefer-inline')
  _$$_RecipeOverviewModelCopyWith<_$_RecipeOverviewModel> get copyWith =>
      __$$_RecipeOverviewModelCopyWithImpl<_$_RecipeOverviewModel>(
          this, _$identity);
}

abstract class _RecipeOverviewModel implements RecipeOverviewModel {
  const factory _RecipeOverviewModel(
      {final List<RecipeOverview> recipeOverviews,
      final bool isLoading,
      final bool canAddNewRecipe,
      final int? errorCode}) = _$_RecipeOverviewModel;

  @override
  List<RecipeOverview> get recipeOverviews;
  @override
  bool get isLoading;
  @override
  bool get canAddNewRecipe;
  @override
  int? get errorCode;
  @override
  @JsonKey(ignore: true)
  _$$_RecipeOverviewModelCopyWith<_$_RecipeOverviewModel> get copyWith =>
      throw _privateConstructorUsedError;
}
