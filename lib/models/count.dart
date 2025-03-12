// To parse this JSON data, do
//
//     final count = countFromJson(jsonString);

import 'package:freezed_annotation/freezed_annotation.dart';
import 'dart:convert';

part 'count.freezed.dart';
part 'count.g.dart';

Count countFromJson(String str) => Count.fromJson(json.decode(str));

String countToJson(Count data) => json.encode(data.toJson());

@freezed
class Count with _$Count {
  const factory Count({
    @JsonKey(name: "count") int? count,
  }) = _Count;

  factory Count.fromJson(Map<String, dynamic> json) => _$CountFromJson(json);
}
