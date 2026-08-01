import 'package:flutter_secure_storage/flutter_secure_storage.dart';

class SessionService {
  SessionService._();

  static final SessionService instance =
  SessionService._();

  static const FlutterSecureStorage storage =
  FlutterSecureStorage();

  ///==================================================
  /// ACCESS TOKEN
  ///==================================================

  Future<void> saveAccessToken(
      String token,
      ) async {
    await storage.write(
      key: "access_token",
      value: token,
    );
  }

  Future<String?> getAccessToken() async {
    return await storage.read(
      key: "access_token",
    );
  }

  Future<void> deleteAccessToken() async {
    await storage.delete(
      key: "access_token",
    );
  }

  ///==================================================
  /// REFRESH TOKEN
  ///==================================================

  Future<void> saveRefreshToken(
      String token,
      ) async {
    await storage.write(
      key: "refresh_token",
      value: token,
    );
  }

  Future<String?> getRefreshToken() async {
    return await storage.read(
      key: "refresh_token",
    );
  }

  Future<void> deleteRefreshToken() async {
    await storage.delete(
      key: "refresh_token",
    );
  }

  ///==================================================
  /// LOGIN STATUS
  ///==================================================

  Future<bool> isLoggedIn() async {
    final token =
    await getAccessToken();

    return token != null &&
        token.isNotEmpty;
  }

  ///==================================================
  /// LOGOUT
  ///==================================================

  Future<void> logout() async {
    await deleteAccessToken();
    await deleteRefreshToken();
  }
}