// To parse this JSON data, do
//
//     final cartCount = cartCountFromJson(jsonString);

import 'package:freezed_annotation/freezed_annotation.dart';
import 'dart:convert';

part 'cart_count.freezed.dart';
part 'cart_count.g.dart';

CartCount cartCountFromJson(String str) => CartCount.fromJson(json.decode(str));

String cartCountToJson(CartCount data) => json.encode(data.toJson());

@freezed
class CartCount with _$CartCount {
  const factory CartCount({
    @JsonKey(name: "count") int? count,
  }) = _CartCount;

  factory CartCount.fromJson(Map<String, dynamic> json) =>
      _$CartCountFromJson(json);
}
