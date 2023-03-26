// coverage:ignore-file
// GENERATED CODE - DO NOT MODIFY BY HAND
// ignore_for_file: type=lint
// ignore_for_file: unused_element, deprecated_member_use, deprecated_member_use_from_same_package, use_function_type_syntax_for_parameters, unnecessary_const, avoid_init_to_null, invalid_override_different_default_values_named, prefer_expression_function_bodies, annotate_overrides, invalid_annotation_target, unnecessary_question_mark

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
  List<EditablePreparationStep> get editableSteps =>
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
      _$RecipeDetailModelCopyWithImpl<$Res, RecipeDetailModel>;
  @useResult
  $Res call(
      {String recipeId,
      bool isLoading,
      bool isEditMode,
      List<EditableIngredientUsage> editableUsages,
      List<EditablePreparationStep> editableSteps,
      int? errorCode,
      Recipe? recipe});
}

/// @nodoc
class _$RecipeDetailModelCopyWithImpl<$Res, $Val extends RecipeDetailModel>
    implements $RecipeDetailModelCopyWith<$Res> {
  _$RecipeDetailModelCopyWithImpl(this._value, this._then);

  // ignore: unused_field
  final $Val _value;
  // ignore: unused_field
  final $Res Function($Val) _then;

  @pragma('vm:prefer-inline')
  @override
  $Res call({
    Object? recipeId = null,
    Object? isLoading = null,
    Object? isEditMode = null,
    Object? editableUsages = null,
    Object? editableSteps = null,
    Object? errorCode = freezed,
    Object? recipe = freezed,
  }) {
    return _then(_value.copyWith(
      recipeId: null == recipeId
          ? _value.recipeId
          : recipeId // ignore: cast_nullable_to_non_nullable
              as String,
      isLoading: null == isLoading
          ? _value.isLoading
          : isLoading // ignore: cast_nullable_to_non_nullable
              as bool,
      isEditMode: null == isEditMode
          ? _value.isEditMode
          : isEditMode // ignore: cast_nullable_to_non_nullable
              as bool,
      editableUsages: null == editableUsages
          ? _value.editableUsages
          : editableUsages // ignore: cast_nullable_to_non_nullable
              as List<EditableIngredientUsage>,
      editableSteps: null == editableSteps
          ? _value.editableSteps
          : editableSteps // ignore: cast_nullable_to_non_nullable
              as List<EditablePreparationStep>,
      errorCode: freezed == errorCode
          ? _value.errorCode
          : errorCode // ignore: cast_nullable_to_non_nullable
              as int?,
      recipe: freezed == recipe
          ? _value.recipe
          : recipe // ignore: cast_nullable_to_non_nullable
              as Recipe?,
    ) as $Val);
  }
}

/// @nodoc
abstract class _$$_RecipeDetailModelCopyWith<$Res>
    implements $RecipeDetailModelCopyWith<$Res> {
  factory _$$_RecipeDetailModelCopyWith(_$_RecipeDetailModel value,
          $Res Function(_$_RecipeDetailModel) then) =
      __$$_RecipeDetailModelCopyWithImpl<$Res>;
  @override
  @useResult
  $Res call(
      {String recipeId,
      bool isLoading,
      bool isEditMode,
      List<EditableIngredientUsage> editableUsages,
      List<EditablePreparationStep> editableSteps,
      int? errorCode,
      Recipe? recipe});
}

/// @nodoc
class __$$_RecipeDetailModelCopyWithImpl<$Res>
    extends _$RecipeDetailModelCopyWithImpl<$Res, _$_RecipeDetailModel>
    implements _$$_RecipeDetailModelCopyWith<$Res> {
  __$$_RecipeDetailModelCopyWithImpl(
      _$_RecipeDetailModel _value, $Res Function(_$_RecipeDetailModel) _then)
      : super(_value, _then);

  @pragma('vm:prefer-inline')
  @override
  $Res call({
    Object? recipeId = null,
    Object? isLoading = null,
    Object? isEditMode = null,
    Object? editableUsages = null,
    Object? editableSteps = null,
    Object? errorCode = freezed,
    Object? recipe = freezed,
  }) {
    return _then(_$_RecipeDetailModel(
      recipeId: null == recipeId
          ? _value.recipeId
          : recipeId // ignore: cast_nullable_to_non_nullable
              as String,
      isLoading: null == isLoading
          ? _value.isLoading
          : isLoading // ignore: cast_nullable_to_non_nullable
              as bool,
      isEditMode: null == isEditMode
          ? _value.isEditMode
          : isEditMode // ignore: cast_nullable_to_non_nullable
              as bool,
      editableUsages: null == editableUsages
          ? _value._editableUsages
          : editableUsages // ignore: cast_nullable_to_non_nullable
              as List<EditableIngredientUsage>,
      editableSteps: null == editableSteps
          ? _value._editableSteps
          : editableSteps // ignore: cast_nullable_to_non_nullable
              as List<EditablePreparationStep>,
      errorCode: freezed == errorCode
          ? _value.errorCode
          : errorCode // ignore: cast_nullable_to_non_nullable
              as int?,
      recipe: freezed == recipe
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
      final List<EditablePreparationStep> editableSteps = const [],
      this.errorCode,
      this.recipe})
      : _editableUsages = editableUsages,
        _editableSteps = editableSteps;

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
    if (_editableUsages is EqualUnmodifiableListView) return _editableUsages;
    // ignore: implicit_dynamic_type
    return EqualUnmodifiableListView(_editableUsages);
  }

  final List<EditablePreparationStep> _editableSteps;
  @override
  @JsonKey()
  List<EditablePreparationStep> get editableSteps {
    if (_editableSteps is EqualUnmodifiableListView) return _editableSteps;
    // ignore: implicit_dynamic_type
    return EqualUnmodifiableListView(_editableSteps);
  }

  @override
  final int? errorCode;
  @override
  final Recipe? recipe;

  @override
  String toString() {
    return 'RecipeDetailModel(recipeId: $recipeId, isLoading: $isLoading, isEditMode: $isEditMode, editableUsages: $editableUsages, editableSteps: $editableSteps, errorCode: $errorCode, recipe: $recipe)';
  }

  @override
  bool operator ==(dynamic other) {
    return identical(this, other) ||
        (other.runtimeType == runtimeType &&
            other is _$_RecipeDetailModel &&
            (identical(other.recipeId, recipeId) ||
                other.recipeId == recipeId) &&
            (identical(other.isLoading, isLoading) ||
                other.isLoading == isLoading) &&
            (identical(other.isEditMode, isEditMode) ||
                other.isEditMode == isEditMode) &&
            const DeepCollectionEquality()
                .equals(other._editableUsages, _editableUsages) &&
            const DeepCollectionEquality()
                .equals(other._editableSteps, _editableSteps) &&
            (identical(other.errorCode, errorCode) ||
                other.errorCode == errorCode) &&
            (identical(other.recipe, recipe) || other.recipe == recipe));
  }

  @override
  int get hashCode => Object.hash(
      runtimeType,
      recipeId,
      isLoading,
      isEditMode,
      const DeepCollectionEquality().hash(_editableUsages),
      const DeepCollectionEquality().hash(_editableSteps),
      errorCode,
      recipe);

  @JsonKey(ignore: true)
  @override
  @pragma('vm:prefer-inline')
  _$$_RecipeDetailModelCopyWith<_$_RecipeDetailModel> get copyWith =>
      __$$_RecipeDetailModelCopyWithImpl<_$_RecipeDetailModel>(
          this, _$identity);
}

abstract class _RecipeDetailModel implements RecipeDetailModel {
  const factory _RecipeDetailModel(
      {required final String recipeId,
      final bool isLoading,
      final bool isEditMode,
      final List<EditableIngredientUsage> editableUsages,
      final List<EditablePreparationStep> editableSteps,
      final int? errorCode,
      final Recipe? recipe}) = _$_RecipeDetailModel;

  @override
  String get recipeId;
  @override
  bool get isLoading;
  @override
  bool get isEditMode;
  @override
  List<EditableIngredientUsage> get editableUsages;
  @override
  List<EditablePreparationStep> get editableSteps;
  @override
  int? get errorCode;
  @override
  Recipe? get recipe;
  @override
  @JsonKey(ignore: true)
  _$$_RecipeDetailModelCopyWith<_$_RecipeDetailModel> get copyWith =>
      throw _privateConstructorUsedError;
}
