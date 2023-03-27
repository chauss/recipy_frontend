// coverage:ignore-file
// GENERATED CODE - DO NOT MODIFY BY HAND
// ignore_for_file: type=lint
// ignore_for_file: unused_element, deprecated_member_use, deprecated_member_use_from_same_package, use_function_type_syntax_for_parameters, unnecessary_const, avoid_init_to_null, invalid_override_different_default_values_named, prefer_expression_function_bodies, annotate_overrides, invalid_annotation_target, unnecessary_question_mark

part of 'recipe_images_model.dart';

// **************************************************************************
// FreezedGenerator
// **************************************************************************

T _$identity<T>(T value) => value;

final _privateConstructorUsedError = UnsupportedError(
    'It seems like you constructed your class using `MyClass._()`. This constructor is only meant to be used by freezed and you are not supposed to need it nor use it.\nPlease check the documentation here for more information: https://github.com/rrousselGit/freezed#custom-getters-and-methods');

/// @nodoc
mixin _$RecipeImagesModel {
  String get recipeId => throw _privateConstructorUsedError;
  bool get isLoading => throw _privateConstructorUsedError;
  List<LoadableRecipeImage> get loadableRecipeImages =>
      throw _privateConstructorUsedError;
  int? get errorCode => throw _privateConstructorUsedError;

  @JsonKey(ignore: true)
  $RecipeImagesModelCopyWith<RecipeImagesModel> get copyWith =>
      throw _privateConstructorUsedError;
}

/// @nodoc
abstract class $RecipeImagesModelCopyWith<$Res> {
  factory $RecipeImagesModelCopyWith(
          RecipeImagesModel value, $Res Function(RecipeImagesModel) then) =
      _$RecipeImagesModelCopyWithImpl<$Res, RecipeImagesModel>;
  @useResult
  $Res call(
      {String recipeId,
      bool isLoading,
      List<LoadableRecipeImage> loadableRecipeImages,
      int? errorCode});
}

/// @nodoc
class _$RecipeImagesModelCopyWithImpl<$Res, $Val extends RecipeImagesModel>
    implements $RecipeImagesModelCopyWith<$Res> {
  _$RecipeImagesModelCopyWithImpl(this._value, this._then);

  // ignore: unused_field
  final $Val _value;
  // ignore: unused_field
  final $Res Function($Val) _then;

  @pragma('vm:prefer-inline')
  @override
  $Res call({
    Object? recipeId = null,
    Object? isLoading = null,
    Object? loadableRecipeImages = null,
    Object? errorCode = freezed,
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
      loadableRecipeImages: null == loadableRecipeImages
          ? _value.loadableRecipeImages
          : loadableRecipeImages // ignore: cast_nullable_to_non_nullable
              as List<LoadableRecipeImage>,
      errorCode: freezed == errorCode
          ? _value.errorCode
          : errorCode // ignore: cast_nullable_to_non_nullable
              as int?,
    ) as $Val);
  }
}

/// @nodoc
abstract class _$$_RecipeImagesModelCopyWith<$Res>
    implements $RecipeImagesModelCopyWith<$Res> {
  factory _$$_RecipeImagesModelCopyWith(_$_RecipeImagesModel value,
          $Res Function(_$_RecipeImagesModel) then) =
      __$$_RecipeImagesModelCopyWithImpl<$Res>;
  @override
  @useResult
  $Res call(
      {String recipeId,
      bool isLoading,
      List<LoadableRecipeImage> loadableRecipeImages,
      int? errorCode});
}

/// @nodoc
class __$$_RecipeImagesModelCopyWithImpl<$Res>
    extends _$RecipeImagesModelCopyWithImpl<$Res, _$_RecipeImagesModel>
    implements _$$_RecipeImagesModelCopyWith<$Res> {
  __$$_RecipeImagesModelCopyWithImpl(
      _$_RecipeImagesModel _value, $Res Function(_$_RecipeImagesModel) _then)
      : super(_value, _then);

  @pragma('vm:prefer-inline')
  @override
  $Res call({
    Object? recipeId = null,
    Object? isLoading = null,
    Object? loadableRecipeImages = null,
    Object? errorCode = freezed,
  }) {
    return _then(_$_RecipeImagesModel(
      recipeId: null == recipeId
          ? _value.recipeId
          : recipeId // ignore: cast_nullable_to_non_nullable
              as String,
      isLoading: null == isLoading
          ? _value.isLoading
          : isLoading // ignore: cast_nullable_to_non_nullable
              as bool,
      loadableRecipeImages: null == loadableRecipeImages
          ? _value._loadableRecipeImages
          : loadableRecipeImages // ignore: cast_nullable_to_non_nullable
              as List<LoadableRecipeImage>,
      errorCode: freezed == errorCode
          ? _value.errorCode
          : errorCode // ignore: cast_nullable_to_non_nullable
              as int?,
    ));
  }
}

/// @nodoc

class _$_RecipeImagesModel implements _RecipeImagesModel {
  const _$_RecipeImagesModel(
      {required this.recipeId,
      this.isLoading = true,
      final List<LoadableRecipeImage> loadableRecipeImages = const [],
      this.errorCode})
      : _loadableRecipeImages = loadableRecipeImages;

  @override
  final String recipeId;
  @override
  @JsonKey()
  final bool isLoading;
  final List<LoadableRecipeImage> _loadableRecipeImages;
  @override
  @JsonKey()
  List<LoadableRecipeImage> get loadableRecipeImages {
    if (_loadableRecipeImages is EqualUnmodifiableListView)
      return _loadableRecipeImages;
    // ignore: implicit_dynamic_type
    return EqualUnmodifiableListView(_loadableRecipeImages);
  }

  @override
  final int? errorCode;

  @override
  String toString() {
    return 'RecipeImagesModel(recipeId: $recipeId, isLoading: $isLoading, loadableRecipeImages: $loadableRecipeImages, errorCode: $errorCode)';
  }

  @override
  bool operator ==(dynamic other) {
    return identical(this, other) ||
        (other.runtimeType == runtimeType &&
            other is _$_RecipeImagesModel &&
            (identical(other.recipeId, recipeId) ||
                other.recipeId == recipeId) &&
            (identical(other.isLoading, isLoading) ||
                other.isLoading == isLoading) &&
            const DeepCollectionEquality()
                .equals(other._loadableRecipeImages, _loadableRecipeImages) &&
            (identical(other.errorCode, errorCode) ||
                other.errorCode == errorCode));
  }

  @override
  int get hashCode => Object.hash(runtimeType, recipeId, isLoading,
      const DeepCollectionEquality().hash(_loadableRecipeImages), errorCode);

  @JsonKey(ignore: true)
  @override
  @pragma('vm:prefer-inline')
  _$$_RecipeImagesModelCopyWith<_$_RecipeImagesModel> get copyWith =>
      __$$_RecipeImagesModelCopyWithImpl<_$_RecipeImagesModel>(
          this, _$identity);
}

abstract class _RecipeImagesModel implements RecipeImagesModel {
  const factory _RecipeImagesModel(
      {required final String recipeId,
      final bool isLoading,
      final List<LoadableRecipeImage> loadableRecipeImages,
      final int? errorCode}) = _$_RecipeImagesModel;

  @override
  String get recipeId;
  @override
  bool get isLoading;
  @override
  List<LoadableRecipeImage> get loadableRecipeImages;
  @override
  int? get errorCode;
  @override
  @JsonKey(ignore: true)
  _$$_RecipeImagesModelCopyWith<_$_RecipeImagesModel> get copyWith =>
      throw _privateConstructorUsedError;
}
