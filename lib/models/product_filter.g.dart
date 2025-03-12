// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'product_filter.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

_$ProductFilterImpl _$$ProductFilterImplFromJson(Map<String, dynamic> json) =>
    _$ProductFilterImpl(
      id: json['id'] as String?,
      name: json['name'] as String?,
      type: json['type'] as String?,
      order: (json['order'] as num?)?.toInt(),
      queryId: json['query_id'] as String?,
    );

Map<String, dynamic> _$$ProductFilterImplToJson(_$ProductFilterImpl instance) =>
    <String, dynamic>{
      'id': instance.id,
      'name': instance.name,
      'type': instance.type,
      'order': instance.order,
      'query_id': instance.queryId,
    };
