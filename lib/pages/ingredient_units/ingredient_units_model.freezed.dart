// coverage:ignore-file
// GENERATED CODE - DO NOT MODIFY BY HAND
// ignore_for_file: type=lint
// ignore_for_file: unused_element, deprecated_member_use, deprecated_member_use_from_same_package, use_function_type_syntax_for_parameters, unnecessary_const, avoid_init_to_null, invalid_override_different_default_values_named, prefer_expression_function_bodies, annotate_overrides, invalid_annotation_target

part of 'ingredient_units_model.dart';

// **************************************************************************
// FreezedGenerator
// **************************************************************************

T _$identity<T>(T value) => value;

final _privateConstructorUsedError = UnsupportedError(
    'It seems like you constructed your class using `MyClass._()`. This constructor is only meant to be used by freezed and you are not supposed to need it nor use it.\nPlease check the documentation here for more information: https://github.com/rrousselGit/freezed#custom-getters-and-methods');

/// @nodoc
mixin _$IngredientUnitsModel {
  List<IngredientUnit> get units => throw _privateConstructorUsedError;
  bool get isLoading => throw _privateConstructorUsedError;
  String? get error => throw _privateConstructorUsedError;

  @JsonKey(ignore: true)
  $IngredientUnitsModelCopyWith<IngredientUnitsModel> get copyWith =>
      throw _privateConstructorUsedError;
}

/// @nodoc
abstract class $IngredientUnitsModelCopyWith<$Res> {
  factory $IngredientUnitsModelCopyWith(IngredientUnitsModel value,
          $Res Function(IngredientUnitsModel) then) =
      _$IngredientUnitsModelCopyWithImpl<$Res>;
  $Res call({List<IngredientUnit> units, bool isLoading, String? error});
}

/// @nodoc
class _$IngredientUnitsModelCopyWithImpl<$Res>
    implements $IngredientUnitsModelCopyWith<$Res> {
  _$IngredientUnitsModelCopyWithImpl(this._value, this._then);

  final IngredientUnitsModel _value;
  // ignore: unused_field
  final $Res Function(IngredientUnitsModel) _then;

  @override
  $Res call({
    Object? units = freezed,
    Object? isLoading = freezed,
    Object? error = freezed,
  }) {
    return _then(_value.copyWith(
      units: units == freezed
          ? _value.units
          : units // ignore: cast_nullable_to_non_nullable
              as List<IngredientUnit>,
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
abstract class _$IngredientUnitsModelCopyWith<$Res>
    implements $IngredientUnitsModelCopyWith<$Res> {
  factory _$IngredientUnitsModelCopyWith(_IngredientUnitsModel value,
          $Res Function(_IngredientUnitsModel) then) =
      __$IngredientUnitsModelCopyWithImpl<$Res>;
  @override
  $Res call({List<IngredientUnit> units, bool isLoading, String? error});
}

/// @nodoc
class __$IngredientUnitsModelCopyWithImpl<$Res>
    extends _$IngredientUnitsModelCopyWithImpl<$Res>
    implements _$IngredientUnitsModelCopyWith<$Res> {
  __$IngredientUnitsModelCopyWithImpl(
      _IngredientUnitsModel _value, $Res Function(_IngredientUnitsModel) _then)
      : super(_value, (v) => _then(v as _IngredientUnitsModel));

  @override
  _IngredientUnitsModel get _value => super._value as _IngredientUnitsModel;

  @override
  $Res call({
    Object? units = freezed,
    Object? isLoading = freezed,
    Object? error = freezed,
  }) {
    return _then(_IngredientUnitsModel(
      units: units == freezed
          ? _value.units
          : units // ignore: cast_nullable_to_non_nullable
              as List<IngredientUnit>,
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

class _$_IngredientUnitsModel implements _IngredientUnitsModel {
  const _$_IngredientUnitsModel(
      {final List<IngredientUnit> units = const [],
      this.isLoading = false,
      this.error})
      : _units = units;

  final List<IngredientUnit> _units;
  @override
  @JsonKey()
  List<IngredientUnit> get units {
    // ignore: implicit_dynamic_type
    return EqualUnmodifiableListView(_units);
  }

  @override
  @JsonKey()
  final bool isLoading;
  @override
  final String? error;

  @override
  String toString() {
    return 'IngredientUnitsModel(units: $units, isLoading: $isLoading, error: $error)';
  }

  @override
  bool operator ==(dynamic other) {
    return identical(this, other) ||
        (other.runtimeType == runtimeType &&
            other is _IngredientUnitsModel &&
            const DeepCollectionEquality().equals(other.units, units) &&
            const DeepCollectionEquality().equals(other.isLoading, isLoading) &&
            const DeepCollectionEquality().equals(other.error, error));
  }

  @override
  int get hashCode => Object.hash(
      runtimeType,
      const DeepCollectionEquality().hash(units),
      const DeepCollectionEquality().hash(isLoading),
      const DeepCollectionEquality().hash(error));

  @JsonKey(ignore: true)
  @override
  _$IngredientUnitsModelCopyWith<_IngredientUnitsModel> get copyWith =>
      __$IngredientUnitsModelCopyWithImpl<_IngredientUnitsModel>(
          this, _$identity);
}

abstract class _IngredientUnitsModel implements IngredientUnitsModel {
  const factory _IngredientUnitsModel(
      {final List<IngredientUnit> units,
      final bool isLoading,
      final String? error}) = _$_IngredientUnitsModel;

  @override
  List<IngredientUnit> get units => throw _privateConstructorUsedError;
  @override
  bool get isLoading => throw _privateConstructorUsedError;
  @override
  String? get error => throw _privateConstructorUsedError;
  @override
  @JsonKey(ignore: true)
  _$IngredientUnitsModelCopyWith<_IngredientUnitsModel> get copyWith =>
      throw _privateConstructorUsedError;
}
