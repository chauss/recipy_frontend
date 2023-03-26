// coverage:ignore-file
// GENERATED CODE - DO NOT MODIFY BY HAND
// ignore_for_file: type=lint
// ignore_for_file: unused_element, deprecated_member_use, deprecated_member_use_from_same_package, use_function_type_syntax_for_parameters, unnecessary_const, avoid_init_to_null, invalid_override_different_default_values_named, prefer_expression_function_bodies, annotate_overrides, invalid_annotation_target, unnecessary_question_mark

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
  int? get errorCode => throw _privateConstructorUsedError;

  @JsonKey(ignore: true)
  $IngredientUnitsModelCopyWith<IngredientUnitsModel> get copyWith =>
      throw _privateConstructorUsedError;
}

/// @nodoc
abstract class $IngredientUnitsModelCopyWith<$Res> {
  factory $IngredientUnitsModelCopyWith(IngredientUnitsModel value,
          $Res Function(IngredientUnitsModel) then) =
      _$IngredientUnitsModelCopyWithImpl<$Res, IngredientUnitsModel>;
  @useResult
  $Res call({List<IngredientUnit> units, bool isLoading, int? errorCode});
}

/// @nodoc
class _$IngredientUnitsModelCopyWithImpl<$Res,
        $Val extends IngredientUnitsModel>
    implements $IngredientUnitsModelCopyWith<$Res> {
  _$IngredientUnitsModelCopyWithImpl(this._value, this._then);

  // ignore: unused_field
  final $Val _value;
  // ignore: unused_field
  final $Res Function($Val) _then;

  @pragma('vm:prefer-inline')
  @override
  $Res call({
    Object? units = null,
    Object? isLoading = null,
    Object? errorCode = freezed,
  }) {
    return _then(_value.copyWith(
      units: null == units
          ? _value.units
          : units // ignore: cast_nullable_to_non_nullable
              as List<IngredientUnit>,
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
abstract class _$$_IngredientUnitsModelCopyWith<$Res>
    implements $IngredientUnitsModelCopyWith<$Res> {
  factory _$$_IngredientUnitsModelCopyWith(_$_IngredientUnitsModel value,
          $Res Function(_$_IngredientUnitsModel) then) =
      __$$_IngredientUnitsModelCopyWithImpl<$Res>;
  @override
  @useResult
  $Res call({List<IngredientUnit> units, bool isLoading, int? errorCode});
}

/// @nodoc
class __$$_IngredientUnitsModelCopyWithImpl<$Res>
    extends _$IngredientUnitsModelCopyWithImpl<$Res, _$_IngredientUnitsModel>
    implements _$$_IngredientUnitsModelCopyWith<$Res> {
  __$$_IngredientUnitsModelCopyWithImpl(_$_IngredientUnitsModel _value,
      $Res Function(_$_IngredientUnitsModel) _then)
      : super(_value, _then);

  @pragma('vm:prefer-inline')
  @override
  $Res call({
    Object? units = null,
    Object? isLoading = null,
    Object? errorCode = freezed,
  }) {
    return _then(_$_IngredientUnitsModel(
      units: null == units
          ? _value._units
          : units // ignore: cast_nullable_to_non_nullable
              as List<IngredientUnit>,
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

class _$_IngredientUnitsModel implements _IngredientUnitsModel {
  const _$_IngredientUnitsModel(
      {final List<IngredientUnit> units = const [],
      this.isLoading = false,
      this.errorCode})
      : _units = units;

  final List<IngredientUnit> _units;
  @override
  @JsonKey()
  List<IngredientUnit> get units {
    if (_units is EqualUnmodifiableListView) return _units;
    // ignore: implicit_dynamic_type
    return EqualUnmodifiableListView(_units);
  }

  @override
  @JsonKey()
  final bool isLoading;
  @override
  final int? errorCode;

  @override
  String toString() {
    return 'IngredientUnitsModel(units: $units, isLoading: $isLoading, errorCode: $errorCode)';
  }

  @override
  bool operator ==(dynamic other) {
    return identical(this, other) ||
        (other.runtimeType == runtimeType &&
            other is _$_IngredientUnitsModel &&
            const DeepCollectionEquality().equals(other._units, _units) &&
            (identical(other.isLoading, isLoading) ||
                other.isLoading == isLoading) &&
            (identical(other.errorCode, errorCode) ||
                other.errorCode == errorCode));
  }

  @override
  int get hashCode => Object.hash(runtimeType,
      const DeepCollectionEquality().hash(_units), isLoading, errorCode);

  @JsonKey(ignore: true)
  @override
  @pragma('vm:prefer-inline')
  _$$_IngredientUnitsModelCopyWith<_$_IngredientUnitsModel> get copyWith =>
      __$$_IngredientUnitsModelCopyWithImpl<_$_IngredientUnitsModel>(
          this, _$identity);
}

abstract class _IngredientUnitsModel implements IngredientUnitsModel {
  const factory _IngredientUnitsModel(
      {final List<IngredientUnit> units,
      final bool isLoading,
      final int? errorCode}) = _$_IngredientUnitsModel;

  @override
  List<IngredientUnit> get units;
  @override
  bool get isLoading;
  @override
  int? get errorCode;
  @override
  @JsonKey(ignore: true)
  _$$_IngredientUnitsModelCopyWith<_$_IngredientUnitsModel> get copyWith =>
      throw _privateConstructorUsedError;
}
