// To parse this JSON data, do
//
//     final brandStores = brandStoresFromJson(jsonString);

import 'package:freezed_annotation/freezed_annotation.dart';
import 'dart:convert';

part 'brand_stores.freezed.dart';
part 'brand_stores.g.dart';

List<BrandStores> brandStoresFromJson(String str) => List<BrandStores>.from(
    json.decode(str).map((x) => BrandStores.fromJson(x)));

String brandStoresToJson(List<BrandStores> data) =>
    json.encode(List<dynamic>.from(data.map((x) => x.toJson())));

@freezed
class BrandStores with _$BrandStores {
  const factory BrandStores({
    @JsonKey(name: "id") String? id,
    @JsonKey(name: "name") String? name,
    @JsonKey(name: "address") Address? address,
    @JsonKey(name: "documents") List<Document>? documents,
  }) = _BrandStores;

  factory BrandStores.fromJson(Map<String, dynamic> json) =>
      _$BrandStoresFromJson(json);
}

@freezed
class Address with _$Address {
  const factory Address({
    @JsonKey(name: "id") String? id,
    @JsonKey(name: "type") String? type,
    @JsonKey(name: "line") String? line,
    @JsonKey(name: "landmark") String? landmark,
    @JsonKey(name: "pincode") int? pincode,
    @JsonKey(name: "geo_coordinates") GeoCoordinates? geoCoordinates,
  }) = _Address;

  factory Address.fromJson(Map<String, dynamic> json) =>
      _$AddressFromJson(json);
}

@freezed
class GeoCoordinates with _$GeoCoordinates {
  const factory GeoCoordinates({
    @JsonKey(name: "latitude") double? latitude,
    @JsonKey(name: "longitude") double? longitude,
  }) = _GeoCoordinates;

  factory GeoCoordinates.fromJson(Map<String, dynamic> json) =>
      _$GeoCoordinatesFromJson(json);
}

@freezed
class Document with _$Document {
  const factory Document({
    @JsonKey(name: "id") String? id,
    @JsonKey(name: "url") String? url,
    @JsonKey(name: "type") String? type,
  }) = _Document;

  factory Document.fromJson(Map<String, dynamic> json) =>
      _$DocumentFromJson(json);
}
