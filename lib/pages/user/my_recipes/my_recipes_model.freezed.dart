// coverage:ignore-file
// GENERATED CODE - DO NOT MODIFY BY HAND
// ignore_for_file: type=lint
// ignore_for_file: unused_element, deprecated_member_use, deprecated_member_use_from_same_package, use_function_type_syntax_for_parameters, unnecessary_const, avoid_init_to_null, invalid_override_different_default_values_named, prefer_expression_function_bodies, annotate_overrides, invalid_annotation_target, unnecessary_question_mark

part of 'my_recipes_model.dart';

// **************************************************************************
// FreezedGenerator
// **************************************************************************

T _$identity<T>(T value) => value;

final _privateConstructorUsedError = UnsupportedError(
    'It seems like you constructed your class using `MyClass._()`. This constructor is only meant to be used by freezed and you are not supposed to need it nor use it.\nPlease check the documentation here for more information: https://github.com/rrousselGit/freezed#custom-getters-and-methods');

/// @nodoc
mixin _$MyRecipesModel {
  List<RecipeOverview> get recipeOverviews =>
      throw _privateConstructorUsedError;
  bool get hasValidUserLoggedIn => throw _privateConstructorUsedError;
  bool get isLoading => throw _privateConstructorUsedError;
  int? get errorCode => throw _privateConstructorUsedError;

  @JsonKey(ignore: true)
  $MyRecipesModelCopyWith<MyRecipesModel> get copyWith =>
      throw _privateConstructorUsedError;
}

/// @nodoc
abstract class $MyRecipesModelCopyWith<$Res> {
  factory $MyRecipesModelCopyWith(
          MyRecipesModel value, $Res Function(MyRecipesModel) then) =
      _$MyRecipesModelCopyWithImpl<$Res, MyRecipesModel>;
  @useResult
  $Res call(
      {List<RecipeOverview> recipeOverviews,
      bool hasValidUserLoggedIn,
      bool isLoading,
      int? errorCode});
}

/// @nodoc
class _$MyRecipesModelCopyWithImpl<$Res, $Val extends MyRecipesModel>
    implements $MyRecipesModelCopyWith<$Res> {
  _$MyRecipesModelCopyWithImpl(this._value, this._then);

  // ignore: unused_field
  final $Val _value;
  // ignore: unused_field
  final $Res Function($Val) _then;

  @pragma('vm:prefer-inline')
  @override
  $Res call({
    Object? recipeOverviews = null,
    Object? hasValidUserLoggedIn = null,
    Object? isLoading = null,
    Object? errorCode = freezed,
  }) {
    return _then(_value.copyWith(
      recipeOverviews: null == recipeOverviews
          ? _value.recipeOverviews
          : recipeOverviews // ignore: cast_nullable_to_non_nullable
              as List<RecipeOverview>,
      hasValidUserLoggedIn: null == hasValidUserLoggedIn
          ? _value.hasValidUserLoggedIn
          : hasValidUserLoggedIn // ignore: cast_nullable_to_non_nullable
              as bool,
      isLoading: null == isLoading
          ? _value.isLoading
          : isLoading // ignore: cast_nullable_to_non_nullable
              as bool,
      errorCode: freezed == errorCode
          ? _value.errorCode
          : errorCode // ignore: cast_nullable_to_non_nullable
              as int?,
    ) as $Val);
  }
}

/// @nodoc
abstract class _$$_MyRecipesModelCopyWith<$Res>
    implements $MyRecipesModelCopyWith<$Res> {
  factory _$$_MyRecipesModelCopyWith(
          _$_MyRecipesModel value, $Res Function(_$_MyRecipesModel) then) =
      __$$_MyRecipesModelCopyWithImpl<$Res>;
  @override
  @useResult
  $Res call(
      {List<RecipeOverview> recipeOverviews,
      bool hasValidUserLoggedIn,
      bool isLoading,
      int? errorCode});
}

/// @nodoc
class __$$_MyRecipesModelCopyWithImpl<$Res>
    extends _$MyRecipesModelCopyWithImpl<$Res, _$_MyRecipesModel>
    implements _$$_MyRecipesModelCopyWith<$Res> {
  __$$_MyRecipesModelCopyWithImpl(
      _$_MyRecipesModel _value, $Res Function(_$_MyRecipesModel) _then)
      : super(_value, _then);

  @pragma('vm:prefer-inline')
  @override
  $Res call({
    Object? recipeOverviews = null,
    Object? hasValidUserLoggedIn = null,
    Object? isLoading = null,
    Object? errorCode = freezed,
  }) {
    return _then(_$_MyRecipesModel(
      recipeOverviews: null == recipeOverviews
          ? _value._recipeOverviews
          : recipeOverviews // ignore: cast_nullable_to_non_nullable
              as List<RecipeOverview>,
      hasValidUserLoggedIn: null == hasValidUserLoggedIn
          ? _value.hasValidUserLoggedIn
          : hasValidUserLoggedIn // ignore: cast_nullable_to_non_nullable
              as bool,
      isLoading: null == isLoading
          ? _value.isLoading
          : isLoading // ignore: cast_nullable_to_non_nullable
              as bool,
      errorCode: freezed == errorCode
          ? _value.errorCode
          : errorCode // ignore: cast_nullable_to_non_nullable
              as int?,
    ));
  }
}

/// @nodoc

class _$_MyRecipesModel implements _MyRecipesModel {
  const _$_MyRecipesModel(
      {final List<RecipeOverview> recipeOverviews = const [],
      this.hasValidUserLoggedIn = true,
      this.isLoading = false,
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
  final bool hasValidUserLoggedIn;
  @override
  @JsonKey()
  final bool isLoading;
  @override
  final int? errorCode;

  @override
  String toString() {
    return 'MyRecipesModel(recipeOverviews: $recipeOverviews, hasValidUserLoggedIn: $hasValidUserLoggedIn, isLoading: $isLoading, errorCode: $errorCode)';
  }

  @override
  bool operator ==(dynamic other) {
    return identical(this, other) ||
        (other.runtimeType == runtimeType &&
            other is _$_MyRecipesModel &&
            const DeepCollectionEquality()
                .equals(other._recipeOverviews, _recipeOverviews) &&
            (identical(other.hasValidUserLoggedIn, hasValidUserLoggedIn) ||
                other.hasValidUserLoggedIn == hasValidUserLoggedIn) &&
            (identical(other.isLoading, isLoading) ||
                other.isLoading == isLoading) &&
            (identical(other.errorCode, errorCode) ||
                other.errorCode == errorCode));
  }

  @override
  int get hashCode => Object.hash(
      runtimeType,
      const DeepCollectionEquality().hash(_recipeOverviews),
      hasValidUserLoggedIn,
      isLoading,
      errorCode);

  @JsonKey(ignore: true)
  @override
  @pragma('vm:prefer-inline')
  _$$_MyRecipesModelCopyWith<_$_MyRecipesModel> get copyWith =>
      __$$_MyRecipesModelCopyWithImpl<_$_MyRecipesModel>(this, _$identity);
}

abstract class _MyRecipesModel implements MyRecipesModel {
  const factory _MyRecipesModel(
      {final List<RecipeOverview> recipeOverviews,
      final bool hasValidUserLoggedIn,
      final bool isLoading,
      final int? errorCode}) = _$_MyRecipesModel;

  @override
  List<RecipeOverview> get recipeOverviews;
  @override
  bool get hasValidUserLoggedIn;
  @override
  bool get isLoading;
  @override
  int? get errorCode;
  @override
  @JsonKey(ignore: true)
  _$$_MyRecipesModelCopyWith<_$_MyRecipesModel> get copyWith =>
      throw _privateConstructorUsedError;
}
