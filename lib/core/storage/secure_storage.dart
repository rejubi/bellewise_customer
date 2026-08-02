import 'package:flutter_secure_storage/flutter_secure_storage.dart';

class SecureStorage {
  static const FlutterSecureStorage _storage = FlutterSecureStorage();

  static const String _accessKey = "access_token";
  static const String _refreshKey = "refresh_token";

  Future<void> saveAccessToken(String token) async {
    await _storage.write(
      key: _accessKey,
      value: token,
    );
  }

  Future<void> saveRefreshToken(String token) async {
    await _storage.write(
      key: _refreshKey,
      value: token,
    );
  }

  Future<void> saveTokens({
    required String access,
    required String refresh,
  }) async {
    await saveAccessToken(access);
    await saveRefreshToken(refresh);
  }

  Future<String?> getAccessToken() async {
    return _storage.read(key: _accessKey);
  }

  Future<String?> getRefreshToken() async {
    return _storage.read(key: _refreshKey);
  }

  Future<void> clear() async {
    await _storage.deleteAll();
  }
}