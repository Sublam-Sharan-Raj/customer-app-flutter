// To parse this JSON data, do
//
//     final favourite = favouriteFromJson(jsonString);

import 'package:freezed_annotation/freezed_annotation.dart';
import 'dart:convert';

part 'favourite.freezed.dart';
part 'favourite.g.dart';

List<Favourite> favouriteFromJson(String str) =>
    List<Favourite>.from(json.decode(str).map((x) => Favourite.fromJson(x)));

String favouriteToJson(List<Favourite> data) =>
    json.encode(List<dynamic>.from(data.map((x) => x.toJson())));

@freezed
class Favourite with _$Favourite {
  const factory Favourite({
    @JsonKey(name: "id") String? id,
    @JsonKey(name: "product") Product? product,
  }) = _Favourite;

  factory Favourite.fromJson(Map<String, dynamic> json) =>
      _$FavouriteFromJson(json);
}

@freezed
class Product with _$Product {
  const factory Product({
    @JsonKey(name: "id") String? id,
    @JsonKey(name: "name") String? name,
    @JsonKey(name: "description") String? description,
    @JsonKey(name: "category") Category? category,
    @JsonKey(name: "brand") dynamic brand,
    @JsonKey(name: "variants") List<Variant>? variants,
  }) = _Product;

  factory Product.fromJson(Map<String, dynamic> json) =>
      _$ProductFromJson(json);
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
    @JsonKey(name: "price") int? price,
    @JsonKey(name: "order") int? order,
  }) = _Size;

  factory Size.fromJson(Map<String, dynamic> json) => _$SizeFromJson(json);
}
