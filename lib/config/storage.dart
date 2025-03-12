import 'dart:convert';
import 'package:flutter/material.dart';
import 'package:flutter_dotenv/flutter_dotenv.dart';
import 'package:flutter_secure_storage/flutter_secure_storage.dart';
import 'package:insta_closet/models/auth.dart';
import 'package:insta_closet/services/crypto_service.dart';
import 'package:shared_preferences/shared_preferences.dart';

class AuthStorage {
  late StorageContract _storage;
  String? _storageKey;
  String? _tokenKey;
  String? _refreshTokenKey;
  Auth auth = const Auth();

  static AuthStorage? _instance;

  static AuthStorage get instance => _instance ??= AuthStorage._internal();
  final CryptoService _cryptoService = CryptoService();

  AuthStorage._internal() {
    _storageKey = dotenv.env['USER_STORAGE_KEY'];
    _tokenKey = dotenv.env['AUTH_TOKEN_STORAGE_KEY'];
    if (dotenv.env['AUTH_DB_TYPE'] == 'SHARED_PREFERENCES') {
      _storage = SharedPreferencesStorage();
    }
  }

  prepareAuth() async {
    var pref = await SharedPreferences.getInstance();
    final hasUser = await _storage.containsKey(_storageKey);
    if (hasUser) {
      Map<String, dynamic> data = (await _storage.get(_storageKey))!;
      if (data.containsKey('user') && data.containsKey('token')) {
        auth = Auth.fromJson(data);
      } else {
        auth = auth.copyWith(
          user: User.fromJson(data),
          token: await getAuthToken(),
        );
      }
    } else if (pref.containsKey(_storageKey!)) {
      Map<String, dynamic> data =
          json.decode(_cryptoService.decrypt(pref.get(_storageKey!) as String));
      auth = Auth.fromJson(data);
      pref.remove(_storageKey!);
      _storage.save(_storageKey, data);
    }
  }

  Future<String?> getAuthToken() async {
    var pref = await SharedPreferences.getInstance();
    String? token;
    if (pref.containsKey(_tokenKey!)) {
      token = _cryptoService.decrypt(pref.getString(_tokenKey!)!);
      pref.remove(_tokenKey!);
      _storage.saveString(_tokenKey, token);
    } else {
      token = await _storage.getString(_tokenKey);
    }
    return token;
  }

  Future<String?> getUserId(String key) async {
    return await _storage.getString(key);
  }

  Future<void> saveAuthToken(String token) async {
    _storage.saveString(_tokenKey, token);
  }

  Future<void> save(Auth auth) async {
    print("auth, $auth");

    _storage.saveString(_tokenKey, auth.token);
    _storage.save(_storageKey, auth.toJson());
  }

  Future<void> delete() async {
    await Future.wait([
      _storage.delete(_storageKey),
      _storage.delete(_tokenKey),
    ]);
  }

  Future<bool> containsKey(String key) async {
    return await _storage.containsKey(key);
  }
}

abstract class StorageContract {
  void save(String? key, Map<String, dynamic> data);
  Future<void> saveString(String? key, String? data);

  Future<void> saveUserData(String? key, String? data);

  Future<bool> containsKey(String? key);

  Future<Map<String, dynamic>?> get(String? key);

  Future<String?> getString(String? key);

  Future<void> delete(String? key);
}

class SharedPreferencesStorage implements StorageContract {
  final FlutterSecureStorage _secureStorage = const FlutterSecureStorage();

  @override
  save(String? key, Map<String, dynamic> data) async {
    await _secureStorage.write(key: key!, value: jsonEncode(data));
  }

  @override
  saveString(String? key, String? data) async {
    debugPrint("Saving : $key");
    await _secureStorage.write(key: key!, value: data);
  }

  @override
  saveUserData(String? key, String? data) async {
    debugPrint("Saving : $key");
    await _secureStorage.write(key: key!, value: data);
  }

  @override
  Future<Map<String, dynamic>?> get(String? key) async {
    if (await _secureStorage.containsKey(key: key!)) {
      try {
        return jsonDecode((await _secureStorage.read(key: key))!);
      } catch (e) {
        return null;
      }
    }
    return null;
  }

  @override
  delete(String? key) async {
    _secureStorage.delete(key: key!);
  }

  @override
  Future<String?> getString(String? key) async {
    return _secureStorage.read(key: key!);
  }

  @override
  Future<bool> containsKey(String? key) async {
    return await _secureStorage.containsKey(key: key!);
  }
}
