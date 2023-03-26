// coverage:ignore-file
// GENERATED CODE - DO NOT MODIFY BY HAND
// ignore_for_file: type=lint
// ignore_for_file: unused_element, deprecated_member_use, deprecated_member_use_from_same_package, use_function_type_syntax_for_parameters, unnecessary_const, avoid_init_to_null, invalid_override_different_default_values_named, prefer_expression_function_bodies, annotate_overrides, invalid_annotation_target, unnecessary_question_mark

part of 'ingredients_model.dart';

// **************************************************************************
// FreezedGenerator
// **************************************************************************

T _$identity<T>(T value) => value;

final _privateConstructorUsedError = UnsupportedError(
    'It seems like you constructed your class using `MyClass._()`. This constructor is only meant to be used by freezed and you are not supposed to need it nor use it.\nPlease check the documentation here for more information: https://github.com/rrousselGit/freezed#custom-getters-and-methods');

/// @nodoc
mixin _$IngredientsModel {
  List<Ingredient> get ingredients => throw _privateConstructorUsedError;
  bool get isLoading => throw _privateConstructorUsedError;
  int? get errorCode => throw _privateConstructorUsedError;

  @JsonKey(ignore: true)
  $IngredientsModelCopyWith<IngredientsModel> get copyWith =>
      throw _privateConstructorUsedError;
}

/// @nodoc
abstract class $IngredientsModelCopyWith<$Res> {
  factory $IngredientsModelCopyWith(
          IngredientsModel value, $Res Function(IngredientsModel) then) =
      _$IngredientsModelCopyWithImpl<$Res, IngredientsModel>;
  @useResult
  $Res call({List<Ingredient> ingredients, bool isLoading, int? errorCode});
}

/// @nodoc
class _$IngredientsModelCopyWithImpl<$Res, $Val extends IngredientsModel>
    implements $IngredientsModelCopyWith<$Res> {
  _$IngredientsModelCopyWithImpl(this._value, this._then);

  // ignore: unused_field
  final $Val _value;
  // ignore: unused_field
  final $Res Function($Val) _then;

  @pragma('vm:prefer-inline')
  @override
  $Res call({
    Object? ingredients = null,
    Object? isLoading = null,
    Object? errorCode = freezed,
  }) {
    return _then(_value.copyWith(
      ingredients: null == ingredients
          ? _value.ingredients
          : ingredients // ignore: cast_nullable_to_non_nullable
              as List<Ingredient>,
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
abstract class _$$_IngredientsModelCopyWith<$Res>
    implements $IngredientsModelCopyWith<$Res> {
  factory _$$_IngredientsModelCopyWith(
          _$_IngredientsModel value, $Res Function(_$_IngredientsModel) then) =
      __$$_IngredientsModelCopyWithImpl<$Res>;
  @override
  @useResult
  $Res call({List<Ingredient> ingredients, bool isLoading, int? errorCode});
}

/// @nodoc
class __$$_IngredientsModelCopyWithImpl<$Res>
    extends _$IngredientsModelCopyWithImpl<$Res, _$_IngredientsModel>
    implements _$$_IngredientsModelCopyWith<$Res> {
  __$$_IngredientsModelCopyWithImpl(
      _$_IngredientsModel _value, $Res Function(_$_IngredientsModel) _then)
      : super(_value, _then);

  @pragma('vm:prefer-inline')
  @override
  $Res call({
    Object? ingredients = null,
    Object? isLoading = null,
    Object? errorCode = freezed,
  }) {
    return _then(_$_IngredientsModel(
      ingredients: null == ingredients
          ? _value._ingredients
          : ingredients // ignore: cast_nullable_to_non_nullable
              as List<Ingredient>,
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

class _$_IngredientsModel implements _IngredientsModel {
  const _$_IngredientsModel(
      {final List<Ingredient> ingredients = const [],
      this.isLoading = false,
      this.errorCode})
      : _ingredients = ingredients;

  final List<Ingredient> _ingredients;
  @override
  @JsonKey()
  List<Ingredient> get ingredients {
    if (_ingredients is EqualUnmodifiableListView) return _ingredients;
    // ignore: implicit_dynamic_type
    return EqualUnmodifiableListView(_ingredients);
  }

  @override
  @JsonKey()
  final bool isLoading;
  @override
  final int? errorCode;

  @override
  String toString() {
    return 'IngredientsModel(ingredients: $ingredients, isLoading: $isLoading, errorCode: $errorCode)';
  }

  @override
  bool operator ==(dynamic other) {
    return identical(this, other) ||
        (other.runtimeType == runtimeType &&
            other is _$_IngredientsModel &&
            const DeepCollectionEquality()
                .equals(other._ingredients, _ingredients) &&
            (identical(other.isLoading, isLoading) ||
                other.isLoading == isLoading) &&
            (identical(other.errorCode, errorCode) ||
                other.errorCode == errorCode));
  }

  @override
  int get hashCode => Object.hash(runtimeType,
      const DeepCollectionEquality().hash(_ingredients), isLoading, errorCode);

  @JsonKey(ignore: true)
  @override
  @pragma('vm:prefer-inline')
  _$$_IngredientsModelCopyWith<_$_IngredientsModel> get copyWith =>
      __$$_IngredientsModelCopyWithImpl<_$_IngredientsModel>(this, _$identity);
}

abstract class _IngredientsModel implements IngredientsModel {
  const factory _IngredientsModel(
      {final List<Ingredient> ingredients,
      final bool isLoading,
      final int? errorCode}) = _$_IngredientsModel;

  @override
  List<Ingredient> get ingredients;
  @override
  bool get isLoading;
  @override
  int? get errorCode;
  @override
  @JsonKey(ignore: true)
  _$$_IngredientsModelCopyWith<_$_IngredientsModel> get copyWith =>
      throw _privateConstructorUsedError;
}
