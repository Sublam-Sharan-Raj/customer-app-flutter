// To parse this JSON data, do
//
//     final saveCartItem = saveCartItemFromJson(jsonString);

import 'package:freezed_annotation/freezed_annotation.dart';
import 'dart:convert';

part 'save_cart_item.freezed.dart';
part 'save_cart_item.g.dart';

List<SaveCartItem> saveCartItemFromJson(String str) => List<SaveCartItem>.from(
    json.decode(str).map((x) => SaveCartItem.fromJson(x)));

String saveCartItemToJson(List<SaveCartItem> data) =>
    json.encode(List<dynamic>.from(data.map((x) => x.toJson())));

@freezed
class SaveCartItem with _$SaveCartItem {
  const factory SaveCartItem({
    @JsonKey(name: "user_id") String? userId,
    @JsonKey(name: "product_id") String? productId,
    @JsonKey(name: "variant_id") String? variantId,
    @JsonKey(name: "size_id") String? sizeId,
    @JsonKey(name: "quantity") int? quantity,
  }) = _SaveCartItem;

  factory SaveCartItem.fromJson(Map<String, dynamic> json) =>
      _$SaveCartItemFromJson(json);
}
