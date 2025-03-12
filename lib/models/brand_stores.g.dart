// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'brand_stores.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

_$BrandStoresImpl _$$BrandStoresImplFromJson(Map<String, dynamic> json) =>
    _$BrandStoresImpl(
      id: json['id'] as String?,
      name: json['name'] as String?,
      address: json['address'] == null
          ? null
          : Address.fromJson(json['address'] as Map<String, dynamic>),
      documents: (json['documents'] as List<dynamic>?)
          ?.map((e) => Document.fromJson(e as Map<String, dynamic>))
          .toList(),
    );

Map<String, dynamic> _$$BrandStoresImplToJson(_$BrandStoresImpl instance) =>
    <String, dynamic>{
      'id': instance.id,
      'name': instance.name,
      'address': instance.address,
      'documents': instance.documents,
    };

_$AddressImpl _$$AddressImplFromJson(Map<String, dynamic> json) =>
    _$AddressImpl(
      id: json['id'] as String?,
      type: json['type'] as String?,
      line: json['line'] as String?,
      landmark: json['landmark'] as String?,
      pincode: (json['pincode'] as num?)?.toInt(),
      geoCoordinates: json['geo_coordinates'] == null
          ? null
          : GeoCoordinates.fromJson(
              json['geo_coordinates'] as Map<String, dynamic>),
    );

Map<String, dynamic> _$$AddressImplToJson(_$AddressImpl instance) =>
    <String, dynamic>{
      'id': instance.id,
      'type': instance.type,
      'line': instance.line,
      'landmark': instance.landmark,
      'pincode': instance.pincode,
      'geo_coordinates': instance.geoCoordinates,
    };

_$GeoCoordinatesImpl _$$GeoCoordinatesImplFromJson(Map<String, dynamic> json) =>
    _$GeoCoordinatesImpl(
      latitude: (json['latitude'] as num?)?.toDouble(),
      longitude: (json['longitude'] as num?)?.toDouble(),
    );

Map<String, dynamic> _$$GeoCoordinatesImplToJson(
        _$GeoCoordinatesImpl instance) =>
    <String, dynamic>{
      'latitude': instance.latitude,
      'longitude': instance.longitude,
    };

_$DocumentImpl _$$DocumentImplFromJson(Map<String, dynamic> json) =>
    _$DocumentImpl(
      id: json['id'] as String?,
      url: json['url'] as String?,
      type: json['type'] as String?,
    );

Map<String, dynamic> _$$DocumentImplToJson(_$DocumentImpl instance) =>
    <String, dynamic>{
      'id': instance.id,
      'url': instance.url,
      'type': instance.type,
    };
