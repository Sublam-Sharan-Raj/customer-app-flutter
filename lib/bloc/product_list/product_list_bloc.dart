import 'package:bloc/bloc.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:insta_closet/bloc/cart/cart_bloc.dart';
import 'package:insta_closet/models/item_exist.dart';
import 'package:insta_closet/models/products.dart';
import 'package:insta_closet/services/order_service.dart';
import 'package:insta_closet/services/home_service.dart';
import 'package:insta_closet/widgets/loading.dart';

part 'product_list_event.dart';
part 'product_list_state.dart';

class ProductListBloc extends Bloc<ProductListEvent, ProductListState> {
  final CartBloc cartBloc;
  ProductListBloc({required this.cartBloc}) : super(ProductListState.reset()) {
    final HomeService homeService = HomeService();
    final OrderService orderService = OrderService();
    on<ProductListEvent>((event, emit) async {
      if (event is FetchProducts) {
        emit(
            ProductListState(isLoading: true, isError: false, productList: []));
        try {
          final params = {
            "category_id": event.categoryId,
            "brand_id": event.brandId,
            "supplier_id": event.storeId,
            "q": event.search
          };
          final response = await homeService.fetchProducts(params);
          final productMap = response as List<dynamic>;

          final data = productMap.map((e) {
            return Products.fromJson(e);
          }).toList();
          emit(ProductListState(
              productList: data, isLoading: false, isError: false));
        } catch (e) {
          print("$e, e");
          emit(ProductListState(isLoading: false, isError: true));
        }
      }

      if (event is GetProductDetailsById) {
        emit(ProductListState(
            isLoading: true,
            isError: false,
            selectedProductDetails: null,
            productList: state.productList,
            itemExistInCart: state.itemExistInCart,
            itemExistInFavourite: state.itemExistInFavourite));
        try {
          print("${state.productList}, productList");
          final response = await homeService.getProductById(event.id!);
          Products product = Products.fromJson(response);

          emit(ProductListState(
              selectedProductDetails: product,
              selectedVariant: product.variants![0],
              selectedSize: product.variants![0].sizes![0],
              isLoading: false,
              productList: state.productList,
              isError: false,
              itemExistInCart: state.itemExistInCart,
              itemExistInFavourite: state.itemExistInFavourite));
        } catch (e) {
          print("$e, e");
          emit(ProductListState(
            isLoading: false,
            isError: true,
            productList: state.productList,
          ));
        }
      }

      if (event is SaveFavourite) {
        if (event.context.mounted) {
          emit(ProductListState(
              productList: state.productList,
              itemExistInCart: state.itemExistInCart,
              itemExistInFavourite: state.itemExistInFavourite));
          LoadingOverlay.show(event.context);
        }

        try {
          final payload = {
            "user_id": event.userId,
            "product_id": event.productId,
            "variant_id": event.variantId,
            "size_id": event.sizeId
          };

          final response = await orderService.saveFavourite(payload);

          if (response.statusCode == 200 || response.statusCode == 201) {
            if (event.context.mounted) {
              emit(ProductListState(
                  productList: state.productList,
                  itemExistInCart: state.itemExistInCart,
                  itemExistInFavourite: true));
              event.context
                  .read<ProductListBloc>()
                  .add(GetProductDetailsById(event.productId));

              cartBloc.add(GetCartItemCount(event.userId!));
              cartBloc.add(GetFavouriteItemCount(event.userId!));
              LoadingOverlay.hide();
              ScaffoldMessenger.of(event.context).showSnackBar(SnackBar(
                content: Text('Item added to Favourite successfully}'),
                backgroundColor: Colors.green,
                duration: Duration(seconds: 3),
              ));
            }
          } else {
            if (response.data.containsKey('errors')) {
              if (event.context.mounted) {
                LoadingOverlay.hide();
                ScaffoldMessenger.of(event.context).showSnackBar(SnackBar(
                  content: Text('${response.data['message']}'),
                  backgroundColor: Colors.red,
                  duration: Duration(seconds: 3),
                ));
                emit(ProductListState(productList: state.productList));
              }
            } else {
              if (event.context.mounted) {
                LoadingOverlay.hide();
                ScaffoldMessenger.of(event.context).showSnackBar(SnackBar(
                  content: Text('Unknown error occurred'),
                  backgroundColor: Colors.red,
                  duration: Duration(seconds: 3),
                ));
                emit(ProductListState(productList: state.productList));
              }
            }
          }
        } catch (e) {}
      }

      if (event is CheckItemExistCartInCart) {
        try {
          final response = await orderService.checkItemExistsInCart(
              event.userId, event.sizeId);
          final data = ItemExist.fromJson(response);
          emit(state.copyWith(
            itemExistInCart: data.exists,
          ));
        } catch (e) {
          emit(state.copyWith(
            itemExistInCart: false,
          ));
          print(e);
        }
      }

      if (event is CheckItemExistCartInFavourite) {
        try {
          final response = await orderService.checkItemExistsInFavourite(
              event.userId, event.variantId);
          final data = ItemExist.fromJson(response);
          emit(state.copyWith(
            itemExistInFavourite: data.exists,
          ));
        } catch (e) {
          emit(state.copyWith(
            itemExistInFavourite: false,
          ));
          print(e);
        }
      }

      if (event is SaveItemInCart) {
        if (event.context.mounted) {
          LoadingOverlay.show(event.context);
        }
        emit(ProductListState(
            productList: state.productList,
            itemExistInCart: state.itemExistInCart,
            itemExistInFavourite: state.itemExistInFavourite));

        print("${state.itemExistInFavourite}, ${state.itemExistInCart}, 1");

        try {
          // final payload = {
          //   "user_id": event.userId,
          //   "product_id": event.productId,
          //   "variant_id": event.variantId,
          //   "size_id": event.sizeId,
          //   "quantity": event.quantity
          // };

          final response = await orderService.saveItemToCart(event.item!);

          if (response.statusCode == 200 || response.statusCode == 201) {
            if (event.context.mounted) {
              event.context
                  .read<ProductListBloc>()
                  .add(GetProductDetailsById(event.item!['product_id']!));

              print(
                  "${state.itemExistInFavourite}, ${state.itemExistInCart}, 10");
              emit(ProductListState(
                  productList: state.productList,
                  itemExistInCart: true,
                  itemExistInFavourite: state.itemExistInFavourite));

              cartBloc.add(GetCartItemCount(event.item!['user_id']!));
              cartBloc.add(GetFavouriteItemCount(event.item!['user_id']!));
              LoadingOverlay.hide();
              ScaffoldMessenger.of(event.context).showSnackBar(SnackBar(
                content: Text('Added successfully to cart'),
                backgroundColor: Colors.green,
                duration: Duration(seconds: 3),
              ));
            }
          } else {
            if (response.data.containsKey('errors')) {
              if (event.context.mounted) {
                LoadingOverlay.hide();
                ScaffoldMessenger.of(event.context).showSnackBar(SnackBar(
                  content: Text('${response.data['message']}'),
                  backgroundColor: Colors.red,
                  duration: Duration(seconds: 3),
                ));
                emit(ProductListState(productList: state.productList));
              }
            } else {
              if (event.context.mounted) {
                LoadingOverlay.hide();
                ScaffoldMessenger.of(event.context).showSnackBar(SnackBar(
                  content: Text('Unknown error occurred'),
                  backgroundColor: Colors.red,
                  duration: Duration(seconds: 3),
                ));
                emit(ProductListState(productList: state.productList));
              }
            }
          }
        } catch (e) {
          print(e);
        }
      }

      if (event is UpdateSelectedVariant) {
        emit(ProductListState(
            selectedVariant: event.variant,
            productList: state.productList,
            selectedSize: event.variant!.sizes![0]));
      }
      if (event is UpdateSelectedSize) {
        emit(ProductListState(
            selectedSize: event.size, productList: state.productList));
      }
    });
  }
}
