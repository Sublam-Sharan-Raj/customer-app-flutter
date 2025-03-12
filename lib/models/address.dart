// To parse this JSON data, do
//
//     final address = addressFromJson(jsonString);

import 'package:freezed_annotation/freezed_annotation.dart';
import 'dart:convert';

part 'address.freezed.dart';
part 'address.g.dart';

List<Address> addressFromJson(String str) =>
    List<Address>.from(json.decode(str).map((x) => Address.fromJson(x)));

String addressToJson(List<Address> data) =>
    json.encode(List<dynamic>.from(data.map((x) => x.toJson())));

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

  factory GeoCoordinates.fromMap(Map<String, Object?> map) {
    return GeoCoordinates(
      latitude: map['latitude'] as double,
      longitude: map['longitude'] as double,
    );
  }
  factory GeoCoordinates.fromJson(Map<String, dynamic> json) =>
      _$GeoCoordinatesFromJson(json);
}
