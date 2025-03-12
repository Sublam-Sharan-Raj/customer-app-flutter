part of 'cart_bloc.dart';

@immutable
sealed class CartEvent {}

class FetchFavourites extends CartEvent {
  final String? userId;
  FetchFavourites(this.userId);
}

class FetchCartList extends CartEvent {
  final String? userId;
  FetchCartList(this.userId);
}

class GetCartItemCount extends CartEvent {
  final String? userId;
  GetCartItemCount(this.userId);
}

class HandleSelectedCartItem extends CartEvent {
  final Item? cartItem;
  final bool? isChecked;

  HandleSelectedCartItem(this.cartItem, this.isChecked);
}

class HandleSelectedFavouriteItem extends CartEvent {
  final fav.Favourite? favouriteItem;
  final bool? isChecked;

  HandleSelectedFavouriteItem(this.favouriteItem, this.isChecked);
}

class GetFavouriteItemCount extends CartEvent {
  final String? userId;
  GetFavouriteItemCount(this.userId);
}

class SaveItemIntoCart extends CartEvent {
  final String? userId;
  final String? productId;
  final String? variantId;
  final String? sizeId;
  final String? quantity;

  SaveItemIntoCart(
      {this.userId,
      this.productId,
      this.variantId,
      this.sizeId,
      this.quantity});
}

class DeleteFavouriteItem extends CartEvent {
  final String? favouriteId;
  final BuildContext context;

  DeleteFavouriteItem({this.favouriteId, required this.context});
}

class DeleteCartItem extends CartEvent {
  final String? userId;
  final String? cartItemId;
  final String? cartId;
  final BuildContext context;

  DeleteCartItem(
      {this.userId, this.cartId, this.cartItemId, required this.context});
}

class CreateOrder extends CartEvent {
  final String? customerId;
  final String? addressId;
  final List<dynamic>? items;
  final GeoCoordinates? geoCoordinates;
  final BuildContext context;

  CreateOrder(
      {this.customerId,
      this.addressId,
      this.items,
      this.geoCoordinates,
      required this.context});
}

class UpdateCartItem extends CartEvent {
  final String? userId;
  final String? quantity;
  final String? sizeId;
  final String? cartId;
  final String? cartItemId;
  final BuildContext context;

  UpdateCartItem(
      {this.userId,
      this.quantity,
      this.sizeId,
      this.cartId,
      this.cartItemId,
      required this.context});
}
