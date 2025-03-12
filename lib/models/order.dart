// To parse this JSON data, do
//
//     final order = orderFromJson(jsonString);

import 'package:freezed_annotation/freezed_annotation.dart';
import 'dart:convert';

part 'order.freezed.dart';
part 'order.g.dart';

List<Order> orderFromJson(String str) =>
    List<Order>.from(json.decode(str).map((x) => Order.fromJson(x)));

String orderToJson(List<Order> data) =>
    json.encode(List<dynamic>.from(data.map((x) => x.toJson())));

@freezed
class Order with _$Order {
  const factory Order({
    @JsonKey(name: "id") String? id,
    @JsonKey(name: "address") Address? address,
    @JsonKey(name: "items") List<Item>? items,
    @JsonKey(name: "created_at") DateTime? createdAt,
  }) = _Order;

  factory Order.fromJson(Map<String, dynamic> json) => _$OrderFromJson(json);
}

@freezed
class Address with _$Address {
  const factory Address({
    @JsonKey(name: "type") String? type,
    @JsonKey(name: "line") String? line,
    @JsonKey(name: "landmark") String? landmark,
    @JsonKey(name: "city") dynamic city,
    @JsonKey(name: "state") dynamic state,
    @JsonKey(name: "pincode") int? pincode,
  }) = _Address;

  factory Address.fromJson(Map<String, dynamic> json) =>
      _$AddressFromJson(json);
}

@freezed
class Item with _$Item {
  const factory Item({
    @JsonKey(name: "id") String? id,
    @JsonKey(name: "product") String? product,
    @JsonKey(name: "color") String? color,
    @JsonKey(name: "size") String? size,
    @JsonKey(name: "productId") String? productId,
    @JsonKey(name: "variantId") String? variantId,
    @JsonKey(name: "sizeId") String? sizeId,
    @JsonKey(name: "image") String? image,
    @JsonKey(name: "quantity") int? quantity,
    @JsonKey(name: "price") int? price,
    @JsonKey(name: "totalPrice") int? totalPrice,
  }) = _Item;

  factory Item.fromJson(Map<String, dynamic> json) => _$ItemFromJson(json);
}
