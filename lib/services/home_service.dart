import 'package:flutter_dotenv/flutter_dotenv.dart';
import 'package:insta_closet/constants.dart';
import 'package:insta_closet/services/rest_service.dart';

class HomeService {
  late RestService _rest;
  String? _baseAuthUrl = '';

  HomeService.internal() {
    _rest = RestService();
    _rest.initState();
    _baseAuthUrl = dotenv.env['PRODUCT_MANAGEMENT_BASE_URL'];
  }
  static final HomeService _instance = HomeService.internal();
  factory HomeService() => _instance;

  Future<dynamic> fetchCategories(Map<String, dynamic> params) async {
    try {
      final response = await (_rest.get(
          _baseAuthUrl! + Constants.restRoutes['fetchCategories'],
          params: params));

      return response;
    } catch (e) {
      throw Exception(e);
    }
  }

  Future<dynamic> fetchBrands(Map<String, dynamic> params) async {
    try {
      final response = await (_rest.get(
          _baseAuthUrl! + Constants.restRoutes['fetchBrands'],
          params: params));

      return response;
    } catch (e) {
      throw Exception(e);
    }
  }

  Future<dynamic> fetchProducts(Map<String, dynamic> params) async {
    try {
      final response = await (_rest.get(
          _baseAuthUrl! + Constants.restRoutes['fetchProducts'],
          params: params));
      print("reponse, $response");
      return response;
    } catch (e) {
      print("ex,$e");
      throw Exception(e);
    }
  }

  Future<dynamic> fetchProductFilterByType(String type) async {
    try {
      final response = await (_rest.get(
        _baseAuthUrl! +
            Constants.printf(Constants.restRoutes['fetchProductFilterByType'], {
              'type': type,
            })!,
      ));

      return response;
    } catch (e) {
      throw Exception(e);
    }
  }

  Future<dynamic> fetchProductTypes(Map<String, dynamic>? params) async {
    try {
      final response = await (_rest.get(
          _baseAuthUrl! + Constants.restRoutes['fetchProductFilterTypes'],
          params: params));
      return response;
    } catch (e) {
      throw Exception(e);
    }
  }

  Future<dynamic> getProductById(String id) async {
    try {
      final response = await (_rest.get(
        _baseAuthUrl! +
            Constants.printf(Constants.restRoutes['getProductById'], {
              'productId': id,
            })!,
      ));

      return response;
    } catch (e) {
      throw Exception(e);
    }
  }
}
