import 'dart:async';
import 'dart:io';
import 'package:dio/dio.dart' as dio;
import 'package:dio/dio.dart';
import 'package:flutter_dotenv/flutter_dotenv.dart';
import 'package:injectable/injectable.dart';
import 'package:insta_closet/bad_request.dart';
import 'package:insta_closet/config/storage.dart';

var rest = dio.Dio();

@injectable
class RestService {
  String? token;
  final AuthStorage storageContract = AuthStorage.instance;

  // next three lines makes this class a Singleton
  RestService.internal() {
    initState();
  }

  static final RestService _instance = RestService.internal();

  factory RestService() => _instance;

  /// Initialize state
  void initState() async {
    token = await getAuthToken();
  }

  /// get request to server
  Future<dynamic> get(String url,
      {Map<String, dynamic>? params,
      Map<String, dynamic>? extraHeaders}) async {
    try {
      dio.Response response = await rest.get(url,
          queryParameters:
              params == null ? null : getTransformQueryParams(params),
          options: await getOptions()
            ..headers?.addAll(extraHeaders ?? {}));
      return response.data;
    } on DioException catch (e) {
      // handleResponse(e);
    }
  }

  Map<String, dynamic> getTransformQueryParams(Map<String, dynamic> params) {
    Map<String, dynamic> transformedQueryParams = {};
    params.forEach((key, value) {
      if (value is List) {
        transformedQueryParams['$key[]'] = value;
      } else {
        transformedQueryParams[key] = value;
      }
    });
    return transformedQueryParams;
  }

  /// post request to server
  Future<dynamic> post(String url,
      {Map? body,
      Map<String, dynamic>? extraHeaders,
      Map<String, dynamic>? queryParams}) async {
    try {
      print(body);
      dio.Response response = await rest.post<Map<String, dynamic>>(
        url,
        data: body,
        options: (await getOptions()
          ..headers?.addAll(extraHeaders ?? {})
          ..validateStatus = (status) {
            return status != null &&
                status < 500; // Accepts all responses except 500+
          }),
        queryParameters: queryParams,
      );

      return response;
    } on DioException catch (e) {
      print('Error: ${e.message}');
      handleResponse(e);
    }
  }

  /// put request to server
  Future<dynamic> put(String url,
      {Object? body, Map<String, dynamic>? queryParams}) async {
    try {
      dio.Response response = await rest.put<Map<String, dynamic>>(url,
          data: body,
          options: await getOptions(),
          queryParameters: queryParams);
      return response;
    } on DioException catch (e) {
      handleResponse(e);
    }
  }

  Future<dynamic> upload(
      String url, Object? body, Map<String, dynamic> headers) async {
    try {
      dio.Response response = await rest.put(
        url,
        data: body,
        options: Options(headers: headers),
      );
      return response.data;
    } on DioException catch (e) {
      handleResponse(e);
    }
  }

  /// delete request to server
  Future<dynamic> delete(String url, {Map? body}) async {
    try {
      dio.Response response = await rest.delete<Map<String, dynamic>>(url,
          data: body, options: await getOptions());
      return response;
    } on DioException catch (e) {
      handleResponse(e);
    }
  }

  // / handle response
  void handleResponse(dio.DioException e) {
    if (e.response != null) {
      if (e.response!.statusCode == 400) {
        throw BadRequest(e.response!.data['errors']);
      } else {
        throw Exception(
            "Oops it seems something went wrong, please try again later");
      }
    } else {
      throw Exception(
          "Oops it seems something went wrong, please try again later");
    }
  }

  Future<Options> getOptions() async {
    return dio.Options(
      headers: await getHeaders(),
      followRedirects: false,
    );
  }

  /// get headers
  Future<Map<String, dynamic>>? getHeaders() async {
    Map<String, dynamic>? headers = {
      HttpHeaders.acceptHeader: ContentType.json
    };
    var token = await storageContract.getAuthToken();
    if (token != null) {
      headers['authorization'] = token;
    }
    return headers;
  }

  Future<String?> getAuthToken() async {
    var token = await storageContract.getAuthToken();
    if (dotenv.env['AUTH_DB_TYPE'] == 'SHARED_PREFERENCES') {
      var token = await getTokenFromSharedPreferences();
      if (token != null) {
        return token;
      }
    }
    if (token != null) {
      return token;
    }
    return null;
  }

  Future<String?> getTokenFromSharedPreferences() async {
    return await storageContract.getAuthToken();
  }

  static void dispose() {
    _instance.initState();
  }
}
