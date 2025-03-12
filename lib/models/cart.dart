// To parse this JSON data, do
//
//     final cart = cartFromJson(jsonString);

import 'package:freezed_annotation/freezed_annotation.dart';
import 'dart:convert';

part 'cart.freezed.dart';
part 'cart.g.dart';

Cart cartFromJson(String str) => Cart.fromJson(json.decode(str));

String cartToJson(Cart data) => json.encode(data.toJson());

@freezed
class Cart with _$Cart {
  const factory Cart({
    @JsonKey(name: "id") String? id,
    @JsonKey(name: "items") List<Item>? items,
    @JsonKey(name: "summary") Summary? summary,
  }) = _Cart;

  factory Cart.fromJson(Map<String, dynamic> json) => _$CartFromJson(json);
}

@freezed
class Item with _$Item {
  const factory Item({
    @JsonKey(name: "id") String? id,
    @JsonKey(name: "quantity") int? quantity,
    @JsonKey(name: "price") int? price,
    @JsonKey(name: "itemAmount") int? itemAmount,
    @JsonKey(name: "discount") dynamic discount,
    @JsonKey(name: "tax") dynamic tax,
    @JsonKey(name: "totalAmount") int? totalAmount,
    @JsonKey(name: "product") Product? product,
  }) = _Item;

  factory Item.fromJson(Map<String, dynamic> json) => _$ItemFromJson(json);
}

@freezed
class Product with _$Product {
  const factory Product({
    @JsonKey(name: "id") String? id,
    @JsonKey(name: "name") String? name,
    @JsonKey(name: "description") String? description,
    @JsonKey(name: "category") Category? category,
    @JsonKey(name: "brand") Brand? brand,
    @JsonKey(name: "variants") List<Variant>? variants,
  }) = _Product;

  factory Product.fromJson(Map<String, dynamic> json) =>
      _$ProductFromJson(json);
}

@freezed
class Brand with _$Brand {
  const factory Brand({
    @JsonKey(name: "id") String? id,
    @JsonKey(name: "name") String? name,
    @JsonKey(name: "description") String? description,
    @JsonKey(name: "offers") List<Offer>? offers,
  }) = _Brand;

  factory Brand.fromJson(Map<String, dynamic> json) => _$BrandFromJson(json);
}

@freezed
class Offer with _$Offer {
  const factory Offer({
    @JsonKey(name: "id") String? id,
    @JsonKey(name: "url") String? url,
    @JsonKey(name: "order") int? order,
  }) = _Offer;

  factory Offer.fromJson(Map<String, dynamic> json) => _$OfferFromJson(json);
}

@freezed
class Category with _$Category {
  const factory Category({
    @JsonKey(name: "id") String? id,
    @JsonKey(name: "name") String? name,
    @JsonKey(name: "priority") int? priority,
    @JsonKey(name: "images") List<Offer>? images,
    @JsonKey(name: "parent") dynamic parent,
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
    @JsonKey(name: "images") List<Offer>? images,
  }) = _Variant;

  factory Variant.fromJson(Map<String, dynamic> json) =>
      _$VariantFromJson(json);
}

@freezed
class Size with _$Size {
  const factory Size({
    @JsonKey(name: "id") String? id,
    @JsonKey(name: "name") String? name,
    @JsonKey(name: "price") int? price,
    @JsonKey(name: "discount") dynamic discount,
    @JsonKey(name: "order") int? order,
  }) = _Size;

  factory Size.fromJson(Map<String, dynamic> json) => _$SizeFromJson(json);
}

@freezed
class Summary with _$Summary {
  const factory Summary({
    @JsonKey(name: "discount") int? discount,
    @JsonKey(name: "total_item_value") int? totalItemValue,
    @JsonKey(name: "platform_fee") int? platformFee,
    @JsonKey(name: "shipping_fee") int? shippingFee,
    @JsonKey(name: "tax_amount") int? taxAmount,
    @JsonKey(name: "total_amount") int? totalAmount,
  }) = _Summary;

  factory Summary.fromJson(Map<String, dynamic> json) =>
      _$SummaryFromJson(json);
}
