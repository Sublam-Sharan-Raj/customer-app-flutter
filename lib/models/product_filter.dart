// To parse this JSON data, do
//
//     final productFilter = productFilterFromJson(jsonString);

import 'package:freezed_annotation/freezed_annotation.dart';
import 'dart:convert';

part 'product_filter.freezed.dart';
part 'product_filter.g.dart';

List<ProductFilter> productFilterFromJson(String str) =>
    List<ProductFilter>.from(
        json.decode(str).map((x) => ProductFilter.fromJson(x)));

String productFilterToJson(List<ProductFilter> data) =>
    json.encode(List<dynamic>.from(data.map((x) => x.toJson())));

@freezed
class ProductFilter with _$ProductFilter {
  const factory ProductFilter({
    @JsonKey(name: "id") String? id,
    @JsonKey(name: "name") String? name,
    @JsonKey(name: "type") String? type,
    @JsonKey(name: "order") int? order,
    @JsonKey(name: "query_id") String? queryId,
  }) = _ProductFilter;

  factory ProductFilter.fromJson(Map<String, dynamic> json) =>
      _$ProductFilterFromJson(json);
}
