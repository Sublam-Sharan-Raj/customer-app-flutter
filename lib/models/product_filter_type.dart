// To parse this JSON data, do
//
//     final productFilterType = productFilterTypeFromJson(jsonString);

import 'package:freezed_annotation/freezed_annotation.dart';
import 'dart:convert';

part 'product_filter_type.freezed.dart';
part 'product_filter_type.g.dart';

List<ProductFilterType> productFilterTypeFromJson(String str) =>
    List<ProductFilterType>.from(
        json.decode(str).map((x) => ProductFilterType.fromJson(x)));

String productFilterTypeToJson(List<ProductFilterType> data) =>
    json.encode(List<dynamic>.from(data.map((x) => x.toJson())));

@freezed
class ProductFilterType with _$ProductFilterType {
  const factory ProductFilterType({
    @JsonKey(name: "name") String? name,
    @JsonKey(name: "value") String? value,
  }) = _ProductFilterType;

  factory ProductFilterType.fromJson(Map<String, dynamic> json) =>
      _$ProductFilterTypeFromJson(json);
}
