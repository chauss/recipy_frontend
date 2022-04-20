// coverage:ignore-file
// GENERATED CODE - DO NOT MODIFY BY HAND
// ignore_for_file: type=lint
// ignore_for_file: unused_element, deprecated_member_use, deprecated_member_use_from_same_package, use_function_type_syntax_for_parameters, unnecessary_const, avoid_init_to_null, invalid_override_different_default_values_named, prefer_expression_function_bodies, annotate_overrides, invalid_annotation_target

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
  String? get error => throw _privateConstructorUsedError;

  @JsonKey(ignore: true)
  $IngredientsModelCopyWith<IngredientsModel> get copyWith =>
      throw _privateConstructorUsedError;
}

/// @nodoc
abstract class $IngredientsModelCopyWith<$Res> {
  factory $IngredientsModelCopyWith(
          IngredientsModel value, $Res Function(IngredientsModel) then) =
      _$IngredientsModelCopyWithImpl<$Res>;
  $Res call({List<Ingredient> ingredients, bool isLoading, String? error});
}

/// @nodoc
class _$IngredientsModelCopyWithImpl<$Res>
    implements $IngredientsModelCopyWith<$Res> {
  _$IngredientsModelCopyWithImpl(this._value, this._then);

  final IngredientsModel _value;
  // ignore: unused_field
  final $Res Function(IngredientsModel) _then;

  @override
  $Res call({
    Object? ingredients = freezed,
    Object? isLoading = freezed,
    Object? error = freezed,
  }) {
    return _then(_value.copyWith(
      ingredients: ingredients == freezed
          ? _value.ingredients
          : ingredients // ignore: cast_nullable_to_non_nullable
              as List<Ingredient>,
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
abstract class _$IngredientsModelCopyWith<$Res>
    implements $IngredientsModelCopyWith<$Res> {
  factory _$IngredientsModelCopyWith(
          _IngredientsModel value, $Res Function(_IngredientsModel) then) =
      __$IngredientsModelCopyWithImpl<$Res>;
  @override
  $Res call({List<Ingredient> ingredients, bool isLoading, String? error});
}

/// @nodoc
class __$IngredientsModelCopyWithImpl<$Res>
    extends _$IngredientsModelCopyWithImpl<$Res>
    implements _$IngredientsModelCopyWith<$Res> {
  __$IngredientsModelCopyWithImpl(
      _IngredientsModel _value, $Res Function(_IngredientsModel) _then)
      : super(_value, (v) => _then(v as _IngredientsModel));

  @override
  _IngredientsModel get _value => super._value as _IngredientsModel;

  @override
  $Res call({
    Object? ingredients = freezed,
    Object? isLoading = freezed,
    Object? error = freezed,
  }) {
    return _then(_IngredientsModel(
      ingredients: ingredients == freezed
          ? _value.ingredients
          : ingredients // ignore: cast_nullable_to_non_nullable
              as List<Ingredient>,
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

class _$_IngredientsModel implements _IngredientsModel {
  const _$_IngredientsModel(
      {final List<Ingredient> ingredients = const [],
      this.isLoading = false,
      this.error})
      : _ingredients = ingredients;

  final List<Ingredient> _ingredients;
  @override
  @JsonKey()
  List<Ingredient> get ingredients {
    // ignore: implicit_dynamic_type
    return EqualUnmodifiableListView(_ingredients);
  }

  @override
  @JsonKey()
  final bool isLoading;
  @override
  final String? error;

  @override
  String toString() {
    return 'IngredientsModel(ingredients: $ingredients, isLoading: $isLoading, error: $error)';
  }

  @override
  bool operator ==(dynamic other) {
    return identical(this, other) ||
        (other.runtimeType == runtimeType &&
            other is _IngredientsModel &&
            const DeepCollectionEquality()
                .equals(other.ingredients, ingredients) &&
            const DeepCollectionEquality().equals(other.isLoading, isLoading) &&
            const DeepCollectionEquality().equals(other.error, error));
  }

  @override
  int get hashCode => Object.hash(
      runtimeType,
      const DeepCollectionEquality().hash(ingredients),
      const DeepCollectionEquality().hash(isLoading),
      const DeepCollectionEquality().hash(error));

  @JsonKey(ignore: true)
  @override
  _$IngredientsModelCopyWith<_IngredientsModel> get copyWith =>
      __$IngredientsModelCopyWithImpl<_IngredientsModel>(this, _$identity);
}

abstract class _IngredientsModel implements IngredientsModel {
  const factory _IngredientsModel(
      {final List<Ingredient> ingredients,
      final bool isLoading,
      final String? error}) = _$_IngredientsModel;

  @override
  List<Ingredient> get ingredients => throw _privateConstructorUsedError;
  @override
  bool get isLoading => throw _privateConstructorUsedError;
  @override
  String? get error => throw _privateConstructorUsedError;
  @override
  @JsonKey(ignore: true)
  _$IngredientsModelCopyWith<_IngredientsModel> get copyWith =>
      throw _privateConstructorUsedError;
}
