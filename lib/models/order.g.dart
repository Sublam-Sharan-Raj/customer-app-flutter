// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'order.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

_$OrderImpl _$$OrderImplFromJson(Map<String, dynamic> json) => _$OrderImpl(
      id: json['id'] as String?,
      address: json['address'] == null
          ? null
          : Address.fromJson(json['address'] as Map<String, dynamic>),
      items: (json['items'] as List<dynamic>?)
          ?.map((e) => Item.fromJson(e as Map<String, dynamic>))
          .toList(),
      createdAt: json['created_at'] == null
          ? null
          : DateTime.parse(json['created_at'] as String),
    );

Map<String, dynamic> _$$OrderImplToJson(_$OrderImpl instance) =>
    <String, dynamic>{
      'id': instance.id,
      'address': instance.address,
      'items': instance.items,
      'created_at': instance.createdAt?.toIso8601String(),
    };

_$AddressImpl _$$AddressImplFromJson(Map<String, dynamic> json) =>
    _$AddressImpl(
      type: json['type'] as String?,
      line: json['line'] as String?,
      landmark: json['landmark'] as String?,
      city: json['city'],
      state: json['state'],
      pincode: (json['pincode'] as num?)?.toInt(),
    );

Map<String, dynamic> _$$AddressImplToJson(_$AddressImpl instance) =>
    <String, dynamic>{
      'type': instance.type,
      'line': instance.line,
      'landmark': instance.landmark,
      'city': instance.city,
      'state': instance.state,
      'pincode': instance.pincode,
    };

_$ItemImpl _$$ItemImplFromJson(Map<String, dynamic> json) => _$ItemImpl(
      id: json['id'] as String?,
      product: json['product'] as String?,
      color: json['color'] as String?,
      size: json['size'] as String?,
      productId: json['productId'] as String?,
      variantId: json['variantId'] as String?,
      sizeId: json['sizeId'] as String?,
      image: json['image'] as String?,
      quantity: (json['quantity'] as num?)?.toInt(),
      price: (json['price'] as num?)?.toInt(),
      totalPrice: (json['totalPrice'] as num?)?.toInt(),
    );

Map<String, dynamic> _$$ItemImplToJson(_$ItemImpl instance) =>
    <String, dynamic>{
      'id': instance.id,
      'product': instance.product,
      'color': instance.color,
      'size': instance.size,
      'productId': instance.productId,
      'variantId': instance.variantId,
      'sizeId': instance.sizeId,
      'image': instance.image,
      'quantity': instance.quantity,
      'price': instance.price,
      'totalPrice': instance.totalPrice,
    };
