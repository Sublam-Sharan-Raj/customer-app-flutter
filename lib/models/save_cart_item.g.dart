// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'save_cart_item.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

_$SaveCartItemImpl _$$SaveCartItemImplFromJson(Map<String, dynamic> json) =>
    _$SaveCartItemImpl(
      userId: json['user_id'] as String?,
      productId: json['product_id'] as String?,
      variantId: json['variant_id'] as String?,
      sizeId: json['size_id'] as String?,
      quantity: (json['quantity'] as num?)?.toInt(),
    );

Map<String, dynamic> _$$SaveCartItemImplToJson(_$SaveCartItemImpl instance) =>
    <String, dynamic>{
      'user_id': instance.userId,
      'product_id': instance.productId,
      'variant_id': instance.variantId,
      'size_id': instance.sizeId,
      'quantity': instance.quantity,
    };
