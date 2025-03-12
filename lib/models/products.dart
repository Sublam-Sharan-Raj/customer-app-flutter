// To parse this JSON data, do
//
//     final products = productsFromJson(jsonString);

import 'package:freezed_annotation/freezed_annotation.dart';
import 'dart:convert';

part 'products.freezed.dart';
part 'products.g.dart';

List<Products> productsFromJson(String str) =>
    List<Products>.from(json.decode(str).map((x) => Products.fromJson(x)));

String productsToJson(List<Products> data) =>
    json.encode(List<dynamic>.from(data.map((x) => x.toJson())));

@freezed
class Products with _$Products {
  const factory Products({
    @JsonKey(name: "id") String? id,
    @JsonKey(name: "name") String? name,
    @JsonKey(name: "description") String? description,
    @JsonKey(name: "category") Category? category,
    @JsonKey(name: "brand") dynamic brand,
    @JsonKey(name: "variants") List<Variant>? variants,
  }) = _Products;

  factory Products.fromJson(Map<String, dynamic> json) =>
      _$ProductsFromJson(json);
}

@freezed
class Category with _$Category {
  const factory Category({
    @JsonKey(name: "id") String? id,
    @JsonKey(name: "name") String? name,
    @JsonKey(name: "priority") int? priority,
    @JsonKey(name: "images") List<dynamic>? images,
    @JsonKey(name: "parent") String? parent,
  }) = _Category;

  factory Category.fromJson(Map<String, dynamic> json) =>
      _$CategoryFromJson(json);
}

@freezed
class Variant with _$Variant {
  const factory Variant({
    @JsonKey(name: "id") String? id,
    @JsonKey(name: "color") String? color,
    @JsonKey(name: "order") int? order,
    @JsonKey(name: "sizes") List<Size>? sizes,
    @JsonKey(name: "images") List<Image>? images,
  }) = _Variant;

  factory Variant.fromJson(Map<String, dynamic> json) =>
      _$VariantFromJson(json);
}

@freezed
class Image with _$Image {
  const factory Image({
    @JsonKey(name: "id") String? id,
    @JsonKey(name: "url") String? url,
    @JsonKey(name: "order") int? order,
  }) = _Image;

  factory Image.fromJson(Map<String, dynamic> json) => _$ImageFromJson(json);
}

@freezed
class Size with _$Size {
  const factory Size({
    @JsonKey(name: "id") String? id,
    @JsonKey(name: "name") String? name,
    @JsonKey(name: "price") double? price,
    @JsonKey(name: "order") int? order,
  }) = _Size;

  factory Size.fromJson(Map<String, dynamic> json) => _$SizeFromJson(json);
}
