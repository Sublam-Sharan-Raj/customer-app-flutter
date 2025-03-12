// coverage:ignore-file
// GENERATED CODE - DO NOT MODIFY BY HAND
// ignore_for_file: type=lint
// ignore_for_file: unused_element, deprecated_member_use, deprecated_member_use_from_same_package, use_function_type_syntax_for_parameters, unnecessary_const, avoid_init_to_null, invalid_override_different_default_values_named, prefer_expression_function_bodies, annotate_overrides, invalid_annotation_target, unnecessary_question_mark

part of 'item_exist.dart';

// **************************************************************************
// FreezedGenerator
// **************************************************************************

T _$identity<T>(T value) => value;

final _privateConstructorUsedError = UnsupportedError(
    'It seems like you constructed your class using `MyClass._()`. This constructor is only meant to be used by freezed and you are not supposed to need it nor use it.\nPlease check the documentation here for more information: https://github.com/rrousselGit/freezed#adding-getters-and-methods-to-our-models');

ItemExist _$ItemExistFromJson(Map<String, dynamic> json) {
  return _ItemExist.fromJson(json);
}

/// @nodoc
mixin _$ItemExist {
  @JsonKey(name: "exists")
  bool? get exists => throw _privateConstructorUsedError;
  @JsonKey(name: "added_on")
  dynamic get addedOn => throw _privateConstructorUsedError;

  /// Serializes this ItemExist to a JSON map.
  Map<String, dynamic> toJson() => throw _privateConstructorUsedError;

  /// Create a copy of ItemExist
  /// with the given fields replaced by the non-null parameter values.
  @JsonKey(includeFromJson: false, includeToJson: false)
  $ItemExistCopyWith<ItemExist> get copyWith =>
      throw _privateConstructorUsedError;
}

/// @nodoc
abstract class $ItemExistCopyWith<$Res> {
  factory $ItemExistCopyWith(ItemExist value, $Res Function(ItemExist) then) =
      _$ItemExistCopyWithImpl<$Res, ItemExist>;
  @useResult
  $Res call(
      {@JsonKey(name: "exists") bool? exists,
      @JsonKey(name: "added_on") dynamic addedOn});
}

/// @nodoc
class _$ItemExistCopyWithImpl<$Res, $Val extends ItemExist>
    implements $ItemExistCopyWith<$Res> {
  _$ItemExistCopyWithImpl(this._value, this._then);

  // ignore: unused_field
  final $Val _value;
  // ignore: unused_field
  final $Res Function($Val) _then;

  /// Create a copy of ItemExist
  /// with the given fields replaced by the non-null parameter values.
  @pragma('vm:prefer-inline')
  @override
  $Res call({
    Object? exists = freezed,
    Object? addedOn = freezed,
  }) {
    return _then(_value.copyWith(
      exists: freezed == exists
          ? _value.exists
          : exists // ignore: cast_nullable_to_non_nullable
              as bool?,
      addedOn: freezed == addedOn
          ? _value.addedOn
          : addedOn // ignore: cast_nullable_to_non_nullable
              as dynamic,
    ) as $Val);
  }
}

/// @nodoc
abstract class _$$ItemExistImplCopyWith<$Res>
    implements $ItemExistCopyWith<$Res> {
  factory _$$ItemExistImplCopyWith(
          _$ItemExistImpl value, $Res Function(_$ItemExistImpl) then) =
      __$$ItemExistImplCopyWithImpl<$Res>;
  @override
  @useResult
  $Res call(
      {@JsonKey(name: "exists") bool? exists,
      @JsonKey(name: "added_on") dynamic addedOn});
}

/// @nodoc
class __$$ItemExistImplCopyWithImpl<$Res>
    extends _$ItemExistCopyWithImpl<$Res, _$ItemExistImpl>
    implements _$$ItemExistImplCopyWith<$Res> {
  __$$ItemExistImplCopyWithImpl(
      _$ItemExistImpl _value, $Res Function(_$ItemExistImpl) _then)
      : super(_value, _then);

  /// Create a copy of ItemExist
  /// with the given fields replaced by the non-null parameter values.
  @pragma('vm:prefer-inline')
  @override
  $Res call({
    Object? exists = freezed,
    Object? addedOn = freezed,
  }) {
    return _then(_$ItemExistImpl(
      exists: freezed == exists
          ? _value.exists
          : exists // ignore: cast_nullable_to_non_nullable
              as bool?,
      addedOn: freezed == addedOn
          ? _value.addedOn
          : addedOn // ignore: cast_nullable_to_non_nullable
              as dynamic,
    ));
  }
}

/// @nodoc
@JsonSerializable()
class _$ItemExistImpl implements _ItemExist {
  const _$ItemExistImpl(
      {@JsonKey(name: "exists") this.exists,
      @JsonKey(name: "added_on") this.addedOn});

  factory _$ItemExistImpl.fromJson(Map<String, dynamic> json) =>
      _$$ItemExistImplFromJson(json);

  @override
  @JsonKey(name: "exists")
  final bool? exists;
  @override
  @JsonKey(name: "added_on")
  final dynamic addedOn;

  @override
  String toString() {
    return 'ItemExist(exists: $exists, addedOn: $addedOn)';
  }

  @override
  bool operator ==(Object other) {
    return identical(this, other) ||
        (other.runtimeType == runtimeType &&
            other is _$ItemExistImpl &&
            (identical(other.exists, exists) || other.exists == exists) &&
            const DeepCollectionEquality().equals(other.addedOn, addedOn));
  }

  @JsonKey(includeFromJson: false, includeToJson: false)
  @override
  int get hashCode => Object.hash(
      runtimeType, exists, const DeepCollectionEquality().hash(addedOn));

  /// Create a copy of ItemExist
  /// with the given fields replaced by the non-null parameter values.
  @JsonKey(includeFromJson: false, includeToJson: false)
  @override
  @pragma('vm:prefer-inline')
  _$$ItemExistImplCopyWith<_$ItemExistImpl> get copyWith =>
      __$$ItemExistImplCopyWithImpl<_$ItemExistImpl>(this, _$identity);

  @override
  Map<String, dynamic> toJson() {
    return _$$ItemExistImplToJson(
      this,
    );
  }
}

abstract class _ItemExist implements ItemExist {
  const factory _ItemExist(
      {@JsonKey(name: "exists") final bool? exists,
      @JsonKey(name: "added_on") final dynamic addedOn}) = _$ItemExistImpl;

  factory _ItemExist.fromJson(Map<String, dynamic> json) =
      _$ItemExistImpl.fromJson;

  @override
  @JsonKey(name: "exists")
  bool? get exists;
  @override
  @JsonKey(name: "added_on")
  dynamic get addedOn;

  /// Create a copy of ItemExist
  /// with the given fields replaced by the non-null parameter values.
  @override
  @JsonKey(includeFromJson: false, includeToJson: false)
  _$$ItemExistImplCopyWith<_$ItemExistImpl> get copyWith =>
      throw _privateConstructorUsedError;
}
