import 'package:flutter_secure_storage/flutter_secure_storage.dart';

class SecureStorage {
  static const FlutterSecureStorage _storage =
  FlutterSecureStorage();

  static const String _accessKey = "access_token";
  static const String _refreshKey = "refresh_token";
  static const String _onboardingKey =
      "onboarding_completed";

  // ============================================================
  // ACCESS TOKEN
  // ============================================================

  Future<void> saveAccessToken(String token) async {
    await _storage.write(
      key: _accessKey,
      value: token,
    );
  }

  Future<String?> getAccessToken() async {
    return _storage.read(
      key: _accessKey,
    );
  }

  // ============================================================
  // REFRESH TOKEN
  // ============================================================

  Future<void> saveRefreshToken(String token) async {
    await _storage.write(
      key: _refreshKey,
      value: token,
    );
  }

  Future<String?> getRefreshToken() async {
    return _storage.read(
      key: _refreshKey,
    );
  }

  // ============================================================
  // SAVE BOTH TOKENS
  // ============================================================

  Future<void> saveTokens({
    required String access,
    required String refresh,
  }) async {
    await saveAccessToken(access);
    await saveRefreshToken(refresh);
  }

  // ============================================================
  // ONBOARDING
  // ============================================================

  Future<void> setOnboardingCompleted() async {
    await _storage.write(
      key: _onboardingKey,
      value: "true",
    );
  }

  Future<bool> isOnboardingCompleted() async {
    final value = await _storage.read(
      key: _onboardingKey,
    );

    return value == "true";
  }

  // ============================================================
  // LOGOUT
  // ============================================================

  /// Clears authentication only.
  ///
  /// The onboarding state is intentionally preserved.
  Future<void> clear() async {
    await _storage.delete(
      key: _accessKey,
    );

    await _storage.delete(
      key: _refreshKey,
    );
  }

  // ============================================================
  // COMPLETE RESET
  // ============================================================

  /// Makes the app behave like a brand-new installation.
  ///
  /// Only use this intentionally, for example during
  /// development/testing.
  Future<void> clearEverything() async {
    await _storage.deleteAll();
  }
}