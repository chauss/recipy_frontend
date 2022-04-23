// coverage:ignore-file
// GENERATED CODE - DO NOT MODIFY BY HAND
// ignore_for_file: type=lint
// ignore_for_file: unused_element, deprecated_member_use, deprecated_member_use_from_same_package, use_function_type_syntax_for_parameters, unnecessary_const, avoid_init_to_null, invalid_override_different_default_values_named, prefer_expression_function_bodies, annotate_overrides, invalid_annotation_target

part of 'recipe_detail_model.dart';

// **************************************************************************
// FreezedGenerator
// **************************************************************************

T _$identity<T>(T value) => value;

final _privateConstructorUsedError = UnsupportedError(
    'It seems like you constructed your class using `MyClass._()`. This constructor is only meant to be used by freezed and you are not supposed to need it nor use it.\nPlease check the documentation here for more information: https://github.com/rrousselGit/freezed#custom-getters-and-methods');

/// @nodoc
mixin _$RecipeDetailModel {
  String get recipeId => throw _privateConstructorUsedError;
  bool get isLoading => throw _privateConstructorUsedError;
  bool get isEditMode => throw _privateConstructorUsedError;
  List<EditableIngredientUsage> get editableUsages =>
      throw _privateConstructorUsedError;
  int? get errorCode => throw _privateConstructorUsedError;
  Recipe? get recipe => throw _privateConstructorUsedError;

  @JsonKey(ignore: true)
  $RecipeDetailModelCopyWith<RecipeDetailModel> get copyWith =>
      throw _privateConstructorUsedError;
}

/// @nodoc
abstract class $RecipeDetailModelCopyWith<$Res> {
  factory $RecipeDetailModelCopyWith(
          RecipeDetailModel value, $Res Function(RecipeDetailModel) then) =
      _$RecipeDetailModelCopyWithImpl<$Res>;
  $Res call(
      {String recipeId,
      bool isLoading,
      bool isEditMode,
      List<EditableIngredientUsage> editableUsages,
      int? errorCode,
      Recipe? recipe});
}

/// @nodoc
class _$RecipeDetailModelCopyWithImpl<$Res>
    implements $RecipeDetailModelCopyWith<$Res> {
  _$RecipeDetailModelCopyWithImpl(this._value, this._then);

  final RecipeDetailModel _value;
  // ignore: unused_field
  final $Res Function(RecipeDetailModel) _then;

  @override
  $Res call({
    Object? recipeId = freezed,
    Object? isLoading = freezed,
    Object? isEditMode = freezed,
    Object? editableUsages = freezed,
    Object? errorCode = freezed,
    Object? recipe = freezed,
  }) {
    return _then(_value.copyWith(
      recipeId: recipeId == freezed
          ? _value.recipeId
          : recipeId // ignore: cast_nullable_to_non_nullable
              as String,
      isLoading: isLoading == freezed
          ? _value.isLoading
          : isLoading // ignore: cast_nullable_to_non_nullable
              as bool,
      isEditMode: isEditMode == freezed
          ? _value.isEditMode
          : isEditMode // ignore: cast_nullable_to_non_nullable
              as bool,
      editableUsages: editableUsages == freezed
          ? _value.editableUsages
          : editableUsages // ignore: cast_nullable_to_non_nullable
              as List<EditableIngredientUsage>,
      errorCode: errorCode == freezed
          ? _value.errorCode
          : errorCode // ignore: cast_nullable_to_non_nullable
              as int?,
      recipe: recipe == freezed
          ? _value.recipe
          : recipe // ignore: cast_nullable_to_non_nullable
              as Recipe?,
    ));
  }
}

/// @nodoc
abstract class _$RecipeDetailModelCopyWith<$Res>
    implements $RecipeDetailModelCopyWith<$Res> {
  factory _$RecipeDetailModelCopyWith(
          _RecipeDetailModel value, $Res Function(_RecipeDetailModel) then) =
      __$RecipeDetailModelCopyWithImpl<$Res>;
  @override
  $Res call(
      {String recipeId,
      bool isLoading,
      bool isEditMode,
      List<EditableIngredientUsage> editableUsages,
      int? errorCode,
      Recipe? recipe});
}

/// @nodoc
class __$RecipeDetailModelCopyWithImpl<$Res>
    extends _$RecipeDetailModelCopyWithImpl<$Res>
    implements _$RecipeDetailModelCopyWith<$Res> {
  __$RecipeDetailModelCopyWithImpl(
      _RecipeDetailModel _value, $Res Function(_RecipeDetailModel) _then)
      : super(_value, (v) => _then(v as _RecipeDetailModel));

  @override
  _RecipeDetailModel get _value => super._value as _RecipeDetailModel;

  @override
  $Res call({
    Object? recipeId = freezed,
    Object? isLoading = freezed,
    Object? isEditMode = freezed,
    Object? editableUsages = freezed,
    Object? errorCode = freezed,
    Object? recipe = freezed,
  }) {
    return _then(_RecipeDetailModel(
      recipeId: recipeId == freezed
          ? _value.recipeId
          : recipeId // ignore: cast_nullable_to_non_nullable
              as String,
      isLoading: isLoading == freezed
          ? _value.isLoading
          : isLoading // ignore: cast_nullable_to_non_nullable
              as bool,
      isEditMode: isEditMode == freezed
          ? _value.isEditMode
          : isEditMode // ignore: cast_nullable_to_non_nullable
              as bool,
      editableUsages: editableUsages == freezed
          ? _value.editableUsages
          : editableUsages // ignore: cast_nullable_to_non_nullable
              as List<EditableIngredientUsage>,
      errorCode: errorCode == freezed
          ? _value.errorCode
          : errorCode // ignore: cast_nullable_to_non_nullable
              as int?,
      recipe: recipe == freezed
          ? _value.recipe
          : recipe // ignore: cast_nullable_to_non_nullable
              as Recipe?,
    ));
  }
}

/// @nodoc

class _$_RecipeDetailModel implements _RecipeDetailModel {
  const _$_RecipeDetailModel(
      {required this.recipeId,
      this.isLoading = false,
      this.isEditMode = false,
      final List<EditableIngredientUsage> editableUsages = const [],
      this.errorCode,
      this.recipe})
      : _editableUsages = editableUsages;

  @override
  final String recipeId;
  @override
  @JsonKey()
  final bool isLoading;
  @override
  @JsonKey()
  final bool isEditMode;
  final List<EditableIngredientUsage> _editableUsages;
  @override
  @JsonKey()
  List<EditableIngredientUsage> get editableUsages {
    // ignore: implicit_dynamic_type
    return EqualUnmodifiableListView(_editableUsages);
  }

  @override
  final int? errorCode;
  @override
  final Recipe? recipe;

  @override
  String toString() {
    return 'RecipeDetailModel(recipeId: $recipeId, isLoading: $isLoading, isEditMode: $isEditMode, editableUsages: $editableUsages, errorCode: $errorCode, recipe: $recipe)';
  }

  @override
  bool operator ==(dynamic other) {
    return identical(this, other) ||
        (other.runtimeType == runtimeType &&
            other is _RecipeDetailModel &&
            const DeepCollectionEquality().equals(other.recipeId, recipeId) &&
            const DeepCollectionEquality().equals(other.isLoading, isLoading) &&
            const DeepCollectionEquality()
                .equals(other.isEditMode, isEditMode) &&
            const DeepCollectionEquality()
                .equals(other.editableUsages, editableUsages) &&
            const DeepCollectionEquality().equals(other.errorCode, errorCode) &&
            const DeepCollectionEquality().equals(other.recipe, recipe));
  }

  @override
  int get hashCode => Object.hash(
      runtimeType,
      const DeepCollectionEquality().hash(recipeId),
      const DeepCollectionEquality().hash(isLoading),
      const DeepCollectionEquality().hash(isEditMode),
      const DeepCollectionEquality().hash(editableUsages),
      const DeepCollectionEquality().hash(errorCode),
      const DeepCollectionEquality().hash(recipe));

  @JsonKey(ignore: true)
  @override
  _$RecipeDetailModelCopyWith<_RecipeDetailModel> get copyWith =>
      __$RecipeDetailModelCopyWithImpl<_RecipeDetailModel>(this, _$identity);
}

abstract class _RecipeDetailModel implements RecipeDetailModel {
  const factory _RecipeDetailModel(
      {required final String recipeId,
      final bool isLoading,
      final bool isEditMode,
      final List<EditableIngredientUsage> editableUsages,
      final int? errorCode,
      final Recipe? recipe}) = _$_RecipeDetailModel;

  @override
  String get recipeId => throw _privateConstructorUsedError;
  @override
  bool get isLoading => throw _privateConstructorUsedError;
  @override
  bool get isEditMode => throw _privateConstructorUsedError;
  @override
  List<EditableIngredientUsage> get editableUsages =>
      throw _privateConstructorUsedError;
  @override
  int? get errorCode => throw _privateConstructorUsedError;
  @override
  Recipe? get recipe => throw _privateConstructorUsedError;
  @override
  @JsonKey(ignore: true)
  _$RecipeDetailModelCopyWith<_RecipeDetailModel> get copyWith =>
      throw _privateConstructorUsedError;
}
