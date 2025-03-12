// coverage:ignore-file
// GENERATED CODE - DO NOT MODIFY BY HAND
// ignore_for_file: type=lint
// ignore_for_file: unused_element, deprecated_member_use, deprecated_member_use_from_same_package, use_function_type_syntax_for_parameters, unnecessary_const, avoid_init_to_null, invalid_override_different_default_values_named, prefer_expression_function_bodies, annotate_overrides, invalid_annotation_target, unnecessary_question_mark

part of 'save_cart_item.dart';

// **************************************************************************
// FreezedGenerator
// **************************************************************************

T _$identity<T>(T value) => value;

final _privateConstructorUsedError = UnsupportedError(
    'It seems like you constructed your class using `MyClass._()`. This constructor is only meant to be used by freezed and you are not supposed to need it nor use it.\nPlease check the documentation here for more information: https://github.com/rrousselGit/freezed#adding-getters-and-methods-to-our-models');

SaveCartItem _$SaveCartItemFromJson(Map<String, dynamic> json) {
  return _SaveCartItem.fromJson(json);
}

/// @nodoc
mixin _$SaveCartItem {
  @JsonKey(name: "user_id")
  String? get userId => throw _privateConstructorUsedError;
  @JsonKey(name: "product_id")
  String? get productId => throw _privateConstructorUsedError;
  @JsonKey(name: "variant_id")
  String? get variantId => throw _privateConstructorUsedError;
  @JsonKey(name: "size_id")
  String? get sizeId => throw _privateConstructorUsedError;
  @JsonKey(name: "quantity")
  int? get quantity => throw _privateConstructorUsedError;

  /// Serializes this SaveCartItem to a JSON map.
  Map<String, dynamic> toJson() => throw _privateConstructorUsedError;

  /// Create a copy of SaveCartItem
  /// with the given fields replaced by the non-null parameter values.
  @JsonKey(includeFromJson: false, includeToJson: false)
  $SaveCartItemCopyWith<SaveCartItem> get copyWith =>
      throw _privateConstructorUsedError;
}

/// @nodoc
abstract class $SaveCartItemCopyWith<$Res> {
  factory $SaveCartItemCopyWith(
          SaveCartItem value, $Res Function(SaveCartItem) then) =
      _$SaveCartItemCopyWithImpl<$Res, SaveCartItem>;
  @useResult
  $Res call(
      {@JsonKey(name: "user_id") String? userId,
      @JsonKey(name: "product_id") String? productId,
      @JsonKey(name: "variant_id") String? variantId,
      @JsonKey(name: "size_id") String? sizeId,
      @JsonKey(name: "quantity") int? quantity});
}

/// @nodoc
class _$SaveCartItemCopyWithImpl<$Res, $Val extends SaveCartItem>
    implements $SaveCartItemCopyWith<$Res> {
  _$SaveCartItemCopyWithImpl(this._value, this._then);

  // ignore: unused_field
  final $Val _value;
  // ignore: unused_field
  final $Res Function($Val) _then;

  /// Create a copy of SaveCartItem
  /// with the given fields replaced by the non-null parameter values.
  @pragma('vm:prefer-inline')
  @override
  $Res call({
    Object? userId = freezed,
    Object? productId = freezed,
    Object? variantId = freezed,
    Object? sizeId = freezed,
    Object? quantity = freezed,
  }) {
    return _then(_value.copyWith(
      userId: freezed == userId
          ? _value.userId
          : userId // ignore: cast_nullable_to_non_nullable
              as String?,
      productId: freezed == productId
          ? _value.productId
          : productId // ignore: cast_nullable_to_non_nullable
              as String?,
      variantId: freezed == variantId
          ? _value.variantId
          : variantId // ignore: cast_nullable_to_non_nullable
              as String?,
      sizeId: freezed == sizeId
          ? _value.sizeId
          : sizeId // ignore: cast_nullable_to_non_nullable
              as String?,
      quantity: freezed == quantity
          ? _value.quantity
          : quantity // ignore: cast_nullable_to_non_nullable
              as int?,
    ) as $Val);
  }
}

/// @nodoc
abstract class _$$SaveCartItemImplCopyWith<$Res>
    implements $SaveCartItemCopyWith<$Res> {
  factory _$$SaveCartItemImplCopyWith(
          _$SaveCartItemImpl value, $Res Function(_$SaveCartItemImpl) then) =
      __$$SaveCartItemImplCopyWithImpl<$Res>;
  @override
  @useResult
  $Res call(
      {@JsonKey(name: "user_id") String? userId,
      @JsonKey(name: "product_id") String? productId,
      @JsonKey(name: "variant_id") String? variantId,
      @JsonKey(name: "size_id") String? sizeId,
      @JsonKey(name: "quantity") int? quantity});
}

/// @nodoc
class __$$SaveCartItemImplCopyWithImpl<$Res>
    extends _$SaveCartItemCopyWithImpl<$Res, _$SaveCartItemImpl>
    implements _$$SaveCartItemImplCopyWith<$Res> {
  __$$SaveCartItemImplCopyWithImpl(
      _$SaveCartItemImpl _value, $Res Function(_$SaveCartItemImpl) _then)
      : super(_value, _then);

  /// Create a copy of SaveCartItem
  /// with the given fields replaced by the non-null parameter values.
  @pragma('vm:prefer-inline')
  @override
  $Res call({
    Object? userId = freezed,
    Object? productId = freezed,
    Object? variantId = freezed,
    Object? sizeId = freezed,
    Object? quantity = freezed,
  }) {
    return _then(_$SaveCartItemImpl(
      userId: freezed == userId
          ? _value.userId
          : userId // ignore: cast_nullable_to_non_nullable
              as String?,
      productId: freezed == productId
          ? _value.productId
          : productId // ignore: cast_nullable_to_non_nullable
              as String?,
      variantId: freezed == variantId
          ? _value.variantId
          : variantId // ignore: cast_nullable_to_non_nullable
              as String?,
      sizeId: freezed == sizeId
          ? _value.sizeId
          : sizeId // ignore: cast_nullable_to_non_nullable
              as String?,
      quantity: freezed == quantity
          ? _value.quantity
          : quantity // ignore: cast_nullable_to_non_nullable
              as int?,
    ));
  }
}

/// @nodoc
@JsonSerializable()
class _$SaveCartItemImpl implements _SaveCartItem {
  const _$SaveCartItemImpl(
      {@JsonKey(name: "user_id") this.userId,
      @JsonKey(name: "product_id") this.productId,
      @JsonKey(name: "variant_id") this.variantId,
      @JsonKey(name: "size_id") this.sizeId,
      @JsonKey(name: "quantity") this.quantity});

  factory _$SaveCartItemImpl.fromJson(Map<String, dynamic> json) =>
      _$$SaveCartItemImplFromJson(json);

  @override
  @JsonKey(name: "user_id")
  final String? userId;
  @override
  @JsonKey(name: "product_id")
  final String? productId;
  @override
  @JsonKey(name: "variant_id")
  final String? variantId;
  @override
  @JsonKey(name: "size_id")
  final String? sizeId;
  @override
  @JsonKey(name: "quantity")
  final int? quantity;

  @override
  String toString() {
    return 'SaveCartItem(userId: $userId, productId: $productId, variantId: $variantId, sizeId: $sizeId, quantity: $quantity)';
  }

  @override
  bool operator ==(Object other) {
    return identical(this, other) ||
        (other.runtimeType == runtimeType &&
            other is _$SaveCartItemImpl &&
            (identical(other.userId, userId) || other.userId == userId) &&
            (identical(other.productId, productId) ||
                other.productId == productId) &&
            (identical(other.variantId, variantId) ||
                other.variantId == variantId) &&
            (identical(other.sizeId, sizeId) || other.sizeId == sizeId) &&
            (identical(other.quantity, quantity) ||
                other.quantity == quantity));
  }

  @JsonKey(includeFromJson: false, includeToJson: false)
  @override
  int get hashCode =>
      Object.hash(runtimeType, userId, productId, variantId, sizeId, quantity);

  /// Create a copy of SaveCartItem
  /// with the given fields replaced by the non-null parameter values.
  @JsonKey(includeFromJson: false, includeToJson: false)
  @override
  @pragma('vm:prefer-inline')
  _$$SaveCartItemImplCopyWith<_$SaveCartItemImpl> get copyWith =>
      __$$SaveCartItemImplCopyWithImpl<_$SaveCartItemImpl>(this, _$identity);

  @override
  Map<String, dynamic> toJson() {
    return _$$SaveCartItemImplToJson(
      this,
    );
  }
}

abstract class _SaveCartItem implements SaveCartItem {
  const factory _SaveCartItem(
      {@JsonKey(name: "user_id") final String? userId,
      @JsonKey(name: "product_id") final String? productId,
      @JsonKey(name: "variant_id") final String? variantId,
      @JsonKey(name: "size_id") final String? sizeId,
      @JsonKey(name: "quantity") final int? quantity}) = _$SaveCartItemImpl;

  factory _SaveCartItem.fromJson(Map<String, dynamic> json) =
      _$SaveCartItemImpl.fromJson;

  @override
  @JsonKey(name: "user_id")
  String? get userId;
  @override
  @JsonKey(name: "product_id")
  String? get productId;
  @override
  @JsonKey(name: "variant_id")
  String? get variantId;
  @override
  @JsonKey(name: "size_id")
  String? get sizeId;
  @override
  @JsonKey(name: "quantity")
  int? get quantity;

  /// Create a copy of SaveCartItem
  /// with the given fields replaced by the non-null parameter values.
  @override
  @JsonKey(includeFromJson: false, includeToJson: false)
  _$$SaveCartItemImplCopyWith<_$SaveCartItemImpl> get copyWith =>
      throw _privateConstructorUsedError;
}
