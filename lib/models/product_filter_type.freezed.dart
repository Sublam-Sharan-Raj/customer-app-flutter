// coverage:ignore-file
// GENERATED CODE - DO NOT MODIFY BY HAND
// ignore_for_file: type=lint
// ignore_for_file: unused_element, deprecated_member_use, deprecated_member_use_from_same_package, use_function_type_syntax_for_parameters, unnecessary_const, avoid_init_to_null, invalid_override_different_default_values_named, prefer_expression_function_bodies, annotate_overrides, invalid_annotation_target, unnecessary_question_mark

part of 'product_filter_type.dart';

// **************************************************************************
// FreezedGenerator
// **************************************************************************

T _$identity<T>(T value) => value;

final _privateConstructorUsedError = UnsupportedError(
    'It seems like you constructed your class using `MyClass._()`. This constructor is only meant to be used by freezed and you are not supposed to need it nor use it.\nPlease check the documentation here for more information: https://github.com/rrousselGit/freezed#adding-getters-and-methods-to-our-models');

ProductFilterType _$ProductFilterTypeFromJson(Map<String, dynamic> json) {
  return _ProductFilterType.fromJson(json);
}

/// @nodoc
mixin _$ProductFilterType {
  @JsonKey(name: "name")
  String? get name => throw _privateConstructorUsedError;
  @JsonKey(name: "value")
  String? get value => throw _privateConstructorUsedError;

  /// Serializes this ProductFilterType to a JSON map.
  Map<String, dynamic> toJson() => throw _privateConstructorUsedError;

  /// Create a copy of ProductFilterType
  /// with the given fields replaced by the non-null parameter values.
  @JsonKey(includeFromJson: false, includeToJson: false)
  $ProductFilterTypeCopyWith<ProductFilterType> get copyWith =>
      throw _privateConstructorUsedError;
}

/// @nodoc
abstract class $ProductFilterTypeCopyWith<$Res> {
  factory $ProductFilterTypeCopyWith(
          ProductFilterType value, $Res Function(ProductFilterType) then) =
      _$ProductFilterTypeCopyWithImpl<$Res, ProductFilterType>;
  @useResult
  $Res call(
      {@JsonKey(name: "name") String? name,
      @JsonKey(name: "value") String? value});
}

/// @nodoc
class _$ProductFilterTypeCopyWithImpl<$Res, $Val extends ProductFilterType>
    implements $ProductFilterTypeCopyWith<$Res> {
  _$ProductFilterTypeCopyWithImpl(this._value, this._then);

  // ignore: unused_field
  final $Val _value;
  // ignore: unused_field
  final $Res Function($Val) _then;

  /// Create a copy of ProductFilterType
  /// with the given fields replaced by the non-null parameter values.
  @pragma('vm:prefer-inline')
  @override
  $Res call({
    Object? name = freezed,
    Object? value = freezed,
  }) {
    return _then(_value.copyWith(
      name: freezed == name
          ? _value.name
          : name // ignore: cast_nullable_to_non_nullable
              as String?,
      value: freezed == value
          ? _value.value
          : value // ignore: cast_nullable_to_non_nullable
              as String?,
    ) as $Val);
  }
}

/// @nodoc
abstract class _$$ProductFilterTypeImplCopyWith<$Res>
    implements $ProductFilterTypeCopyWith<$Res> {
  factory _$$ProductFilterTypeImplCopyWith(_$ProductFilterTypeImpl value,
          $Res Function(_$ProductFilterTypeImpl) then) =
      __$$ProductFilterTypeImplCopyWithImpl<$Res>;
  @override
  @useResult
  $Res call(
      {@JsonKey(name: "name") String? name,
      @JsonKey(name: "value") String? value});
}

/// @nodoc
class __$$ProductFilterTypeImplCopyWithImpl<$Res>
    extends _$ProductFilterTypeCopyWithImpl<$Res, _$ProductFilterTypeImpl>
    implements _$$ProductFilterTypeImplCopyWith<$Res> {
  __$$ProductFilterTypeImplCopyWithImpl(_$ProductFilterTypeImpl _value,
      $Res Function(_$ProductFilterTypeImpl) _then)
      : super(_value, _then);

  /// Create a copy of ProductFilterType
  /// with the given fields replaced by the non-null parameter values.
  @pragma('vm:prefer-inline')
  @override
  $Res call({
    Object? name = freezed,
    Object? value = freezed,
  }) {
    return _then(_$ProductFilterTypeImpl(
      name: freezed == name
          ? _value.name
          : name // ignore: cast_nullable_to_non_nullable
              as String?,
      value: freezed == value
          ? _value.value
          : value // ignore: cast_nullable_to_non_nullable
              as String?,
    ));
  }
}

/// @nodoc
@JsonSerializable()
class _$ProductFilterTypeImpl implements _ProductFilterType {
  const _$ProductFilterTypeImpl(
      {@JsonKey(name: "name") this.name, @JsonKey(name: "value") this.value});

  factory _$ProductFilterTypeImpl.fromJson(Map<String, dynamic> json) =>
      _$$ProductFilterTypeImplFromJson(json);

  @override
  @JsonKey(name: "name")
  final String? name;
  @override
  @JsonKey(name: "value")
  final String? value;

  @override
  String toString() {
    return 'ProductFilterType(name: $name, value: $value)';
  }

  @override
  bool operator ==(Object other) {
    return identical(this, other) ||
        (other.runtimeType == runtimeType &&
            other is _$ProductFilterTypeImpl &&
            (identical(other.name, name) || other.name == name) &&
            (identical(other.value, value) || other.value == value));
  }

  @JsonKey(includeFromJson: false, includeToJson: false)
  @override
  int get hashCode => Object.hash(runtimeType, name, value);

  /// Create a copy of ProductFilterType
  /// with the given fields replaced by the non-null parameter values.
  @JsonKey(includeFromJson: false, includeToJson: false)
  @override
  @pragma('vm:prefer-inline')
  _$$ProductFilterTypeImplCopyWith<_$ProductFilterTypeImpl> get copyWith =>
      __$$ProductFilterTypeImplCopyWithImpl<_$ProductFilterTypeImpl>(
          this, _$identity);

  @override
  Map<String, dynamic> toJson() {
    return _$$ProductFilterTypeImplToJson(
      this,
    );
  }
}

abstract class _ProductFilterType implements ProductFilterType {
  const factory _ProductFilterType(
      {@JsonKey(name: "name") final String? name,
      @JsonKey(name: "value") final String? value}) = _$ProductFilterTypeImpl;

  factory _ProductFilterType.fromJson(Map<String, dynamic> json) =
      _$ProductFilterTypeImpl.fromJson;

  @override
  @JsonKey(name: "name")
  String? get name;
  @override
  @JsonKey(name: "value")
  String? get value;

  /// Create a copy of ProductFilterType
  /// with the given fields replaced by the non-null parameter values.
  @override
  @JsonKey(includeFromJson: false, includeToJson: false)
  _$$ProductFilterTypeImplCopyWith<_$ProductFilterTypeImpl> get copyWith =>
      throw _privateConstructorUsedError;
}
