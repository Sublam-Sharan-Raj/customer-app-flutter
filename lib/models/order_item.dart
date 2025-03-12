// To parse this JSON data, do
//
//     final orderItem = orderItemFromJson(jsonString);

import 'package:freezed_annotation/freezed_annotation.dart';
import 'dart:convert';

part 'order_item.freezed.dart';
part 'order_item.g.dart';

OrderItem orderItemFromJson(String str) => OrderItem.fromJson(json.decode(str));

String orderItemToJson(OrderItem data) => json.encode(data.toJson());

@freezed
class OrderItem with _$OrderItem {
  const factory OrderItem({
    @JsonKey(name: "size_id") String? sizeId,
    @JsonKey(name: "quantity") int? quantity,
  }) = _OrderItem;

  factory OrderItem.fromMap(Map<String, Object?> map) {
    return OrderItem(
      sizeId: map['size_id'] as String,
      quantity: map['quantity'] as int,
    );
  }

  factory OrderItem.fromJson(Map<String, dynamic> json) =>
      _$OrderItemFromJson(json);
}
