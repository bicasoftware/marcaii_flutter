import 'package:flutter/foundation.dart';
import 'package:flutter_secure_storage/flutter_secure_storage.dart';

class Vault {
  Vault();

  static const String TOKEN = "token";
  static const String REFRESH_TOKEN = "refresh_token";
  static const String EMAIL = "marcaii_email";

  FlutterSecureStorage _getStorage() {
    return const FlutterSecureStorage();
  }

  Future<Map<String, dynamic>> _getAllValues() async {
    final storage = _getStorage();
    return await storage.readAll();
  }

  Future<bool> hasSetToken() async {
    final allValues = await _getAllValues();
    return allValues.containsKey(TOKEN);
  }

  Future<bool> hasSetRefreshToken() async {
    final v = await _getAllValues();
    return v.containsKey(REFRESH_TOKEN);
  }

  Future<void> setToken(String token) async {
    final store = _getStorage();
    return store.write(
      key: TOKEN,
      value: token,
    );
  }

  Future<void> setRefreshToken(String refreshToken) {
    final store = _getStorage();
    return store.write(
      key: REFRESH_TOKEN,
      value: refreshToken,
    );
  }

  Future<void> setEmail(String email) {
    final storage = _getStorage();
    return storage.write(key: EMAIL, value: email);
  }

  Future<void> setAuthData({
    @required String email,
    @required String token,
    @required String refreshToken,
  }) async {
    await Future.wait([
      setToken(token),
      setRefreshToken(refreshToken),
      setEmail(email),
    ]);
  }

  Future<String> getToken() async {
    final store = _getStorage();
    return await store.read(key: TOKEN) ?? "";
  }

  Future<String> getRefreshToken() async {
    final store = _getStorage();
    return await store.read(key: REFRESH_TOKEN);
  }

  Future<String> getEmail() async {
    final store = _getStorage();
    return await store.read(key: EMAIL);
  }
}
