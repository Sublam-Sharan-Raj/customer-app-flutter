// To parse this JSON data, do
//
//     final itemExist = itemExistFromJson(jsonString);

import 'package:freezed_annotation/freezed_annotation.dart';
import 'dart:convert';

part 'item_exist.freezed.dart';
part 'item_exist.g.dart';

ItemExist itemExistFromJson(String str) => ItemExist.fromJson(json.decode(str));

String itemExistToJson(ItemExist data) => json.encode(data.toJson());

@freezed
class ItemExist with _$ItemExist {
  const factory ItemExist({
    @JsonKey(name: "exists") bool? exists,
    @JsonKey(name: "added_on") dynamic addedOn,
  }) = _ItemExist;

  factory ItemExist.fromJson(Map<String, dynamic> json) =>
      _$ItemExistFromJson(json);
}
