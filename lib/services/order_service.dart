import 'package:flutter_dotenv/flutter_dotenv.dart';
import 'package:insta_closet/constants.dart';
import 'package:insta_closet/models/cart.dart';
import 'package:insta_closet/services/rest_service.dart';

class OrderService {
  late RestService _rest;
  String? _baseAuthUrl = '';

  OrderService.internal() {
    _rest = RestService();
    _rest.initState();
    _baseAuthUrl = dotenv.env['ORDER_MANAGEMENT_BASE_URL'];
  }
  static final OrderService _instance = OrderService.internal();
  factory OrderService() => _instance;

  Future<dynamic> fetchFavourites(String id) async {
    try {
      final response = await (_rest.get(
        _baseAuthUrl! +
            Constants.printf(Constants.restRoutes['fetchFavourites'], {
              'userId': id,
            })!,
      ));

      return response;
    } catch (e) {
      throw Exception(e);
    }
  }

  Future<dynamic> fetchOrders(Map<String, dynamic> params) async {
    try {
      final response = await (_rest.get(
          _baseAuthUrl! + Constants.restRoutes['fetchOrders'],
          params: params));

      return response;
    } catch (e) {
      throw Exception(e);
    }
  }

  Future<dynamic> saveFavourite(Map<String, dynamic> body) async {
    try {
      final response = await (_rest.post(
          _baseAuthUrl! + Constants.restRoutes['saveFavourite'],
          body: body));
      return response;
    } catch (e) {
      throw Exception(e);
    }
  }

  Future<dynamic> deleteFavourite(String id) async {
    try {
      final response = await (_rest.delete(
        _baseAuthUrl! +
            Constants.printf(Constants.restRoutes['deleteFavourite'], {
              'favouriteId': id,
            })!,
      ));
      return response;
    } catch (e) {
      throw Exception(e);
    }
  }

  // Future<dynamic> fetchCartItems(String id) async {
  //   try {
  //     final response = await (_rest.get(
  //       _baseAuthUrl! +
  //           Constants.printf(Constants.restRoutes['fetchCartProducts'], {
  //             'userId': id,
  //           })!,
  //     ));

  //     return response;
  //   } catch (e) {
  //     throw Exception(e);
  //   }
  // }

  Future<dynamic> fetchCartItems(String id) async {
    try {
      final response = await (_rest.get(
        _baseAuthUrl! +
            Constants.printf(Constants.restRoutes['fetchCartProducts'], {
              'userId': id,
            })!,
      ));

      return response;
    } catch (e) {
      throw Exception(e);
    }
  }

  Future<dynamic> getCartItemsCount(String id) async {
    try {
      final response = await (_rest.get(
        _baseAuthUrl! +
            Constants.printf(Constants.restRoutes['cartItemCount'], {
              'userId': id,
            })!,
      ));

      return response;
    } catch (e) {
      throw Exception(e);
    }
  }

  Future<dynamic> checkItemExistsInCart(String userId, String sizeId) async {
    try {
      final response = await (_rest.get(
        _baseAuthUrl! +
            Constants.printf(Constants.restRoutes['itemExistInCart'],
                {'userId': userId, 'sizeId': sizeId})!,
      ));

      return response;
    } catch (e) {
      throw Exception(e);
    }
  }

  Future<dynamic> checkItemExistsInFavourite(
      String userId, String variantId) async {
    try {
      final response = await (_rest.get(
        _baseAuthUrl! +
            Constants.printf(Constants.restRoutes['itemExistInFavourite'],
                {'userId': userId, 'variantId': variantId})!,
      ));

      return response;
    } catch (e) {
      throw Exception(e);
    }
  }

  Future<dynamic> getFavouriteItemsCount(String id) async {
    try {
      final response = await (_rest.get(
        _baseAuthUrl! +
            Constants.printf(Constants.restRoutes['favouriteItemCount'], {
              'userId': id,
            })!,
      ));

      return response;
    } catch (e) {
      throw Exception(e);
    }
  }

  Future<dynamic> saveItemToCart(Map<String, dynamic> body) async {
    try {
      final response = await (_rest.post(
          _baseAuthUrl! + Constants.restRoutes['saveItemToCart'],
          body: body));
      return response;
    } catch (e) {
      throw Exception(e);
    }
  }

  Future<dynamic> createOrder(Map<String, dynamic> body) async {
    try {
      final response = await (_rest.post(
          _baseAuthUrl! + Constants.restRoutes['createOrder'],
          body: body));
      return response;
    } catch (e) {
      throw Exception(e);
    }
  }

  Future<dynamic> updateCartItem(
      Map<String, dynamic> body, String cartId, String cartItemId) async {
    try {
      final response = await (_rest.put(
          _baseAuthUrl! +
              Constants.printf(Constants.restRoutes['updateCartProduct'],
                  {'cartId': cartId, 'cartItemId': cartItemId})!,
          body: body));
      print(response);
      return response;
    } catch (e) {
      throw Exception(e);
    }
  }

  Future<dynamic> deleteCartItem(String cartId, String cartItemId) async {
    try {
      final response = await (_rest.delete(
        _baseAuthUrl! +
            Constants.printf(Constants.restRoutes['deleteCartItem'],
                {'cartId': cartId, 'cartItemId': cartItemId})!,
      ));

      return response;
    } catch (e) {
      throw Exception(e);
    }
  }
}
