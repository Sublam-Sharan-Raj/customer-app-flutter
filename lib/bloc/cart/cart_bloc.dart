import 'package:bloc/bloc.dart';
import 'package:flutter/material.dart';
import 'package:insta_closet/bad_request.dart';
import 'package:insta_closet/models/address.dart';
import 'package:insta_closet/models/cart.dart';
import 'package:insta_closet/models/cart_count.dart';
import 'package:insta_closet/models/count.dart';
import 'package:insta_closet/models/favourite.dart' as fav;
import 'package:insta_closet/services/order_service.dart';
import 'package:insta_closet/widgets/loading.dart';

part 'cart_event.dart';
part 'cart_state.dart';

class CartBloc extends Bloc<CartEvent, CartState> {
  CartBloc() : super(CartState.reset()) {
    final OrderService orderService = OrderService();
    on<CartEvent>((event, emit) async {
      if (event is GetCartItemCount) {
        emit(state.copyWith(favouriteCount: state.favouriteCount));
        try {
          emit(state.copyWith(isLoading: true, cartCount: 0));
          final response = await orderService.getCartItemsCount(event.userId!);
          final data = CartCount.fromJson(response);

          emit(state.copyWith(
              cartCount: data.count,
              isLoading: false,
              favouriteCount: state.favouriteCount));
        } catch (e) {
          emit(state.copyWith(
              cartCount: 0,
              isLoading: false,
              favouriteCount: state.favouriteCount));
        }
      }

      if (event is HandleSelectedCartItem) {
        final updatedCartList = List<Item>.from(state.selectedCartList);

        if (event.isChecked == true) {
          // Add the cart item to the selectedCartList
          if (event.cartItem != null &&
              !updatedCartList.contains(event.cartItem)) {
            updatedCartList.add(event.cartItem!);
          }
        } else {
          // Remove the cart item from the selectedCartList
          if (event.cartItem != null) {
            updatedCartList.remove(event.cartItem);
          }
        }

        emit(state.copyWith(selectedCartList: updatedCartList));
      }

      if (event is HandleSelectedFavouriteItem) {
        final updatedFavList =
            List<fav.Favourite>.from(state.selectedFavouriteList);

        if (event.isChecked == true) {
          // Add the cart item to the selectedCartList
          if (event.favouriteItem != null &&
              !updatedFavList.contains(event.favouriteItem)) {
            updatedFavList.add(event.favouriteItem!);
          }
        } else {
          // Remove the cart item from the selectedCartList
          if (event.favouriteItem != null) {
            updatedFavList.remove(event.favouriteItem);
          }
        }

        emit(state.copyWith(selectedFavouriteList: updatedFavList));
      }

      if (event is GetFavouriteItemCount) {
        try {
          emit(state.copyWith(isLoading: true, cartCount: state.cartCount));
          final response =
              await orderService.getFavouriteItemsCount(event.userId!);
          final data = Count.fromJson(response);
          emit(state.copyWith(
              favouriteCount: data.count,
              isLoading: false,
              cartCount: state.cartCount));
        } catch (e) {
          emit(state.copyWith(
              favouriteCount: 0, isLoading: false, cartCount: state.cartCount));
          print(e);
        }
      }

      if (event is FetchCartList) {
        emit(CartState(
            isCartLoading: true,
            isCartError: false,
            favouriteCount: state.favouriteCount));
        try {
          final response = await orderService.fetchCartItems(event.userId!);
          Cart data = Cart.fromJson(response);
          emit(CartState(
              cartList: data,
              selectedCartList: data.items!,
              isCartLoading: false,
              isCartError: false,
              favouriteCount: state.favouriteCount));
        } catch (e) {
          emit(CartState(
              isCartLoading: false,
              isCartError: true,
              favouriteCount: state.favouriteCount));
        }
      }

      if (event is FetchFavourites) {
        emit(CartState(
            isFavouriteLoading: true,
            isFavouriteError: false,
            favouriteCount: state.favouriteCount));
        try {
          final response = await orderService.fetchFavourites(event.userId!);
          final favouriteMap = response as List<dynamic>;
          final data = favouriteMap.map((e) {
            return fav.Favourite.fromJson(e);
          }).toList();
          emit(CartState(
              favouritesList: data,
              isFavouriteLoading: false,
              isFavouriteError: false,
              favouriteCount: state.favouriteCount));
        } catch (e) {
          emit(CartState(
              isFavouriteLoading: false,
              isFavouriteError: true,
              favouriteCount: state.favouriteCount));
        }
      }

      if (event is DeleteCartItem) {
        if (event.context.mounted) {
          LoadingOverlay.show(event.context);
        }

        emit(CartState(
            isDeletedCartItem: false,
            cartList: state.cartList,
            favouriteCount: state.favouriteCount));
        try {
          final response = await orderService.deleteCartItem(
              event.cartId!, event.cartItemId!);

          if (response.statusCode == 200 || response.statusCode == 201) {
            if (event.context.mounted) {
              LoadingOverlay.hide();

              ScaffoldMessenger.of(event.context).showSnackBar(const SnackBar(
                content: Text('Cart item deleted successfully'),
                backgroundColor: Colors.green,
                duration: Duration(seconds: 3),
              ));
            }
            emit(
              CartState(
                  isDeletedCartItem: true,
                  isDeleteCartItemLoading: false,
                  favouriteCount: state.favouriteCount),
            );
          } else {
            if (event.context.mounted) {
              LoadingOverlay.hide();
              ScaffoldMessenger.of(event.context).showSnackBar(SnackBar(
                content:
                    Text('Failed to update cart item: ${response.statusCode}'),
                backgroundColor: Colors.red,
                duration: Duration(seconds: 3),
              ));
            }
          }
        } catch (e) {
          if (event.context.mounted) {
            LoadingOverlay.hide();
            ScaffoldMessenger.of(event.context).showSnackBar(SnackBar(
              content: Text('Error updating cart item: $e'),
              backgroundColor: Colors.red,
              duration: Duration(seconds: 3),
            ));
          }

          LoadingOverlay.hide();
          print("Error updating cart item: $e"); // For debugging purposes
        }
      }

      if (event is UpdateCartItem) {
        if (event.context.mounted) {
          LoadingOverlay.show(event.context);
        }
        emit(CartState(
            isUpdatedCartItem: false,
            cartList: state.cartList,
            favouriteCount: state.favouriteCount));
        try {
          final payload = {"quantity": event.quantity, "size_id": event.sizeId};

          final response = await orderService.updateCartItem(
              payload, event.cartId!, event.cartItemId!);

          if (response.statusCode == 200 || response.statusCode == 201) {
            emit(CartState(
                isUpdatedCartItem: true, favouriteCount: state.favouriteCount));
          } else {
            if (event.context.mounted) {
              LoadingOverlay.hide();
              ScaffoldMessenger.of(event.context).showSnackBar(SnackBar(
                content:
                    Text('Failed to update cart item: ${response.statusCode}'),
                backgroundColor: Colors.red,
                duration: Duration(seconds: 3),
              ));
            }
          }
        } on BadRequest catch (error) {
          if (event.context.mounted) {
            LoadingOverlay.hide();
            ScaffoldMessenger.of(event.context).showSnackBar(SnackBar(
              content: Text('${error.errors![error.errors!.keys.toList()[0]]}'),
              backgroundColor: Colors.red,
              duration: Duration(seconds: 3),
            ));
          }
        } on Exception catch (error) {
          LoadingOverlay.hide();
          if (event.context.mounted) {
            LoadingOverlay.hide();
            ScaffoldMessenger.of(event.context).showSnackBar(SnackBar(
              content: Text(error.toString()),
              backgroundColor: Colors.red,
              duration: Duration(seconds: 3),
            ));
          }
        }
      }

      // if (event is DeleteCartItem) {
      //   if (event.context.mounted) {
      //     LoadingOverlay.show(event.context);
      //   }
      //   try {
      //     final response = await orderService.deleteCartItem(
      //         event.cartId!, event.cartItemId!);

      //     // Ensure the context is still valid and mounted before showing a SnackBar
      //     if (response.statusCode == 200 || response.statusCode == 201) {
      //       if (event.context.mounted) {
      //         LoadingOverlay.hide();
      //         ScaffoldMessenger.of(event.context).showSnackBar(const SnackBar(
      //           content: Text('Cart item deleted successfully'),
      //           backgroundColor: Colors.green,
      //           duration: Duration(seconds: 3),
      //         ));
      //       }
      //     } else {
      //       if (event.context.mounted) {
      //         LoadingOverlay.hide();
      //         ScaffoldMessenger.of(event.context).showSnackBar(SnackBar(
      //           content:
      //               Text('Failed to update cart item: ${response.statusCode}'),
      //           backgroundColor: Colors.red,
      //           duration: Duration(seconds: 3),
      //         ));
      //       }
      //     }
      //   } on BadRequest catch (error) {
      //     if (event.context.mounted) {
      //       LoadingOverlay.hide();
      //       ScaffoldMessenger.of(event.context).showSnackBar(SnackBar(
      //         content: Text('${error.errors![error.errors!.keys.toList()[0]]}'),
      //         backgroundColor: Colors.red,
      //         duration: Duration(seconds: 3),
      //       ));
      //     }
      //   } on Exception catch (error) {
      //     if (event.context.mounted) {
      //       LoadingOverlay.hide();
      //       ScaffoldMessenger.of(event.context).showSnackBar(SnackBar(
      //         content: Text(error.toString()),
      //         backgroundColor: Colors.red,
      //         duration: Duration(seconds: 3),
      //       ));
      //     }
      //   }
      // }

      if (event is DeleteFavouriteItem) {
        emit(CartState(
          isDeletedFavouriteItem: false,
          favouritesList: state.favouritesList,
        ));
        try {
          final response =
              await orderService.deleteFavourite(event.favouriteId!);

          if (response.statusCode == 200 || response.statusCode == 201) {
            emit(CartState(isDeletedFavouriteItem: true));
          } else {
            if (response.data.containsKey('errors')) {
              if (event.context.mounted) {
                LoadingOverlay.hide();
                ScaffoldMessenger.of(event.context).showSnackBar(SnackBar(
                  content: Text('${response.data['message']}'),
                  backgroundColor: Colors.red,
                  duration: Duration(seconds: 3),
                ));
              }
            } else {
              if (event.context.mounted) {
                LoadingOverlay.hide();
                ScaffoldMessenger.of(event.context).showSnackBar(SnackBar(
                  content: Text('Unknown error occurred'),
                  backgroundColor: Colors.red,
                  duration: Duration(seconds: 3),
                ));
              }
            }
          }
        } on BadRequest catch (error) {
          if (event.context.mounted) {
            LoadingOverlay.hide();
            ScaffoldMessenger.of(event.context).showSnackBar(SnackBar(
              content: Text('${error.errors![error.errors!.keys.toList()[0]]}'),
              backgroundColor: Colors.red,
              duration: Duration(seconds: 3),
            ));
          }
        } on Exception catch (error) {
          if (event.context.mounted) {
            LoadingOverlay.hide();
            ScaffoldMessenger.of(event.context).showSnackBar(SnackBar(
              content: Text(error.toString()),
              backgroundColor: Colors.red,
              duration: Duration(seconds: 3),
            ));
          }
        }
      }

      if (event is CreateOrder) {
        if (event.context.mounted) {
          LoadingOverlay.show(event.context);
        }
        emit(CartState(isCreatedOrder: false));
        try {
          final payload = {
            "customer_id": event.customerId,
            "address_id": event.addressId,
            "items": event.items,
            "geo_coordinates": event.geoCoordinates
          };

          final response = await orderService.createOrder(payload);

          if (response.statusCode == 200 || response.statusCode == 201) {
            LoadingOverlay.hide();
            emit(CartState(isCreatedOrder: true));
          } else {
            if (event.context.mounted) {
              LoadingOverlay.hide();
              ScaffoldMessenger.of(event.context).showSnackBar(SnackBar(
                content:
                    Text('Failed to update cart item: ${response.statusCode}'),
                backgroundColor: Colors.red,
                duration: Duration(seconds: 3),
              ));
            }
          }
        } on BadRequest catch (error) {
          if (event.context.mounted) {
            LoadingOverlay.hide();
            ScaffoldMessenger.of(event.context).showSnackBar(SnackBar(
              content: Text('${error.errors![error.errors!.keys.toList()[0]]}'),
              backgroundColor: Colors.red,
              duration: Duration(seconds: 3),
            ));
          }
        } on Exception catch (error) {
          if (event.context.mounted) {
            LoadingOverlay.hide();
            ScaffoldMessenger.of(event.context).showSnackBar(SnackBar(
              content: Text(error.toString()),
              backgroundColor: Colors.red,
              duration: Duration(seconds: 3),
            ));
          }
        }
      }
    });
  }
}
