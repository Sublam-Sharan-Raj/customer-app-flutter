import 'package:encrypt/encrypt.dart';
import 'package:flutter_dotenv/flutter_dotenv.dart';

class CryptoService {
  // next three lines makes this class a Singleton
  CryptoService.internal();

  static final CryptoService _instance = CryptoService.internal();

  factory CryptoService() => _instance;

  String encrypt(String text) {
    final key = Key.fromUtf8(dotenv.env['AES_KEY']!);
    final iv = IV.fromLength(16);

    final encrypter = Encrypter(AES(key));

    final encrypted = encrypter.encrypt(text, iv: iv);

    return encrypted.base64;
  }

  String decrypt(String text) {
    final key = Key.fromUtf8(dotenv.env['AES_KEY']!);
    final iv = IV.fromLength(0);

    final encrypter = Encrypter(AES(key));

    return encrypter.decrypt64(text, iv: iv);
  }
}
