part of 'product_list_bloc.dart';

@immutable
sealed class ProductListEvent {}

class FetchProducts extends ProductListEvent {
  final String? categoryId;
  final String? brandId;
  final String? storeId;
  final String? search;

  FetchProducts(this.categoryId, this.brandId, this.storeId, this.search);
}

class GetProductDetailsById extends ProductListEvent {
  final String? id;
  GetProductDetailsById(this.id);
}

class UpdateSelectedVariant extends ProductListEvent {
  final Variant? variant;
  UpdateSelectedVariant(this.variant);
}

class UpdateSelectedSize extends ProductListEvent {
  final Size? size;
  UpdateSelectedSize(this.size);
}

class SaveItemInCart extends ProductListEvent {
  final Map<String, dynamic>? item;
  final BuildContext context;

  SaveItemInCart({this.item, required this.context});
}

class CheckItemExistCartInCart extends ProductListEvent {
  final String userId;
  final String sizeId;
  CheckItemExistCartInCart({required this.userId, required this.sizeId});
}

class CheckItemExistCartInFavourite extends ProductListEvent {
  final String userId;
  final String variantId;
  CheckItemExistCartInFavourite(
      {required this.userId, required this.variantId});
}

class SaveFavourite extends ProductListEvent {
  final String? userId;
  final String? productId;
  final String? variantId;
  final String? sizeId;
  final BuildContext context;

  SaveFavourite(
      {this.userId,
      this.productId,
      this.variantId,
      this.sizeId,
      required this.context});
}
