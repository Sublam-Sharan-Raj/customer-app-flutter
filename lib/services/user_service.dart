import 'package:flutter_dotenv/flutter_dotenv.dart';
import 'package:insta_closet/constants.dart';
import 'package:insta_closet/services/rest_service.dart';

class UserService {
  late RestService _rest;
  String? _baseAuthUrl = '';

  UserService.internal() {
    _rest = RestService();
    _rest.initState();
    _baseAuthUrl = dotenv.env['USER_MANAGEMENT_BASE_URL'];
  }
  static final UserService _instance = UserService.internal();
  factory UserService() => _instance;

  Future<dynamic> generateVerificationCode(Map<String, dynamic> body) async {
    try {
      final response = await (_rest.post(
          _baseAuthUrl! + Constants.restRoutes['generateVerificationCode'],
          body: body));
      return response;
    } catch (e) {
      throw Exception(e);
    }
  }

  Future<dynamic> validateVerificationCode(Map<String, dynamic> body) async {
    try {
      final response = await (_rest.post(
          _baseAuthUrl! + Constants.restRoutes['validateVerificationCode'],
          body: body));
      return response;
    } catch (e) {
      throw Exception(e);
    }
  }

  Future<dynamic> createNewAccount(Map<String, dynamic> body) async {
    try {
      final response = await (_rest.post(
          _baseAuthUrl! + Constants.restRoutes['createNewAccount'],
          body: body));
      return response;
    } catch (e) {
      throw Exception(e);
    }
  }

  Future<dynamic> saveAddress(String id, Map<String, dynamic> body) async {
    try {
      final response = await (_rest.post(
          _baseAuthUrl! +
              Constants.printf(Constants.restRoutes['saveAddress'], {
                'userId': id,
              })!,
          body: body));
      return response;
    } catch (e) {
      throw Exception(e);
    }
  }

  Future<dynamic> fetchBrandStores(Map<String, dynamic> params, brandId) async {
    try {
      final response = await (_rest.get(
          _baseAuthUrl! +
              Constants.printf(Constants.restRoutes['fetchBrandStores'], {
                'brandId': brandId,
              })!,
          params: params));

      return response;
    } catch (e) {
      throw Exception(e);
    }
  }

  Future<dynamic> fetchAddresses(String id) async {
    try {
      final response = await (_rest.get(
        _baseAuthUrl! +
            Constants.printf(Constants.restRoutes['fetchAddress'], {
              'userId': id,
            })!,
      ));

      return response;
    } catch (e) {
      throw Exception(e);
    }
  }
}
