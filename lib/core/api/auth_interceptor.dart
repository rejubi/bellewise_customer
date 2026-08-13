import 'package:dio/dio.dart';

import '../storage/secure_storage.dart';
import 'api_client.dart';
import 'endpoints.dart';

class AuthInterceptor extends Interceptor {
  AuthInterceptor();

  final SecureStorage storage = SecureStorage();

  /// Prevent multiple refresh requests from happening
  /// at the same time.
  static Future<bool>? _refreshFuture;

  // ==========================================================
  // REQUEST
  // ==========================================================

  @override
  Future<void> onRequest(
      RequestOptions options,
      RequestInterceptorHandler handler,
      ) async {
    final isPublicEndpoint =
        options.path == Endpoints.login ||
            options.path == Endpoints.register ||
            options.path == Endpoints.forgotPassword ||
            options.path == Endpoints.resetPassword ||
            options.path == Endpoints.refresh;

    if (!isPublicEndpoint) {
      final accessToken =
      await storage.getAccessToken();

      if (accessToken != null &&
          accessToken.isNotEmpty) {
        options.headers["Authorization"] =
        "Bearer $accessToken";
      }
    }

    handler.next(options);
  }

  // ==========================================================
  // ERROR / TOKEN REFRESH
  // ==========================================================

  @override
  Future<void> onError(
      DioException err,
      ErrorInterceptorHandler handler,
      ) async {
    // --------------------------------------------------------
    // Only handle 401 Unauthorized.
    // --------------------------------------------------------

    if (err.response?.statusCode != 401) {
      return handler.next(err);
    }

    final request = err.requestOptions;

    // --------------------------------------------------------
    // Never refresh the refresh endpoint itself.
    // --------------------------------------------------------

    if (request.path == Endpoints.refresh) {
      await _clearSession();

      return handler.next(err);
    }

    // --------------------------------------------------------
    // Public authentication endpoints must never
    // trigger token refresh.
    // --------------------------------------------------------

    final isPublicEndpoint =
        request.path == Endpoints.login ||
            request.path == Endpoints.register ||
            request.path == Endpoints.forgotPassword ||
            request.path == Endpoints.resetPassword ||
            request.path == Endpoints.refresh;

    if (isPublicEndpoint) {
      return handler.next(err);
    }

    // --------------------------------------------------------
    // Prevent infinite refresh/retry loops.
    // --------------------------------------------------------

    final alreadyRetried =
        request.extra["auth_retry"] == true;

    if (alreadyRetried) {
      await _clearSession();

      return handler.next(err);
    }

    // --------------------------------------------------------
    // Mark request before attempting refresh.
    // --------------------------------------------------------

    request.extra["auth_retry"] = true;

    // --------------------------------------------------------
    // REFRESH TOKEN
    // --------------------------------------------------------

    final refreshed =
    await _refreshAccessToken();

    if (!refreshed) {
      await _clearSession();

      return handler.next(err);
    }

    // --------------------------------------------------------
    // GET NEW ACCESS TOKEN
    // --------------------------------------------------------

    final newAccessToken =
    await storage.getAccessToken();

    if (newAccessToken == null ||
        newAccessToken.isEmpty) {
      await _clearSession();

      return handler.next(err);
    }

    // --------------------------------------------------------
    // UPDATE ORIGINAL REQUEST
    // --------------------------------------------------------

    request.headers["Authorization"] =
    "Bearer $newAccessToken";

    // --------------------------------------------------------
    // RETRY ORIGINAL REQUEST
    // --------------------------------------------------------

    try {
      final response =
      await ApiClient.dio.fetch(request);

      return handler.resolve(response);
    } on DioException catch (e) {
      return handler.next(e);
    }
  }

  // ==========================================================
  // REFRESH ACCESS TOKEN
  // ==========================================================

  Future<bool> _refreshAccessToken() async {
    // --------------------------------------------------------
    // If another request is already refreshing the token,
    // wait for that same refresh operation.
    // --------------------------------------------------------

    if (_refreshFuture != null) {
      return await _refreshFuture!;
    }

    _refreshFuture =
        _performRefresh();

    try {
      return await _refreshFuture!;
    } finally {
      _refreshFuture = null;
    }
  }

  // ==========================================================
  // ACTUAL REFRESH REQUEST
  // ==========================================================

  Future<bool> _performRefresh() async {
    try {
      final refreshToken =
      await storage.getRefreshToken();

      if (refreshToken == null ||
          refreshToken.isEmpty) {
        return false;
      }

      // ------------------------------------------------------
      // IMPORTANT:
      //
      // Use a completely separate Dio instance.
      //
      // This prevents the refresh request from entering
      // this interceptor again.
      // ------------------------------------------------------

      final refreshDio = Dio(
        BaseOptions(
          baseUrl: Endpoints.baseUrl,
          connectTimeout:
          const Duration(seconds: 30),
          receiveTimeout:
          const Duration(seconds: 30),
          headers: {
            "Accept": "application/json",
            "Content-Type": "application/json",
          },
        ),
      );

      final response =
      await refreshDio.post(
        Endpoints.refresh,
        data: {
          "refresh": refreshToken,
        },
      );

      if (response.statusCode != 200) {
        return false;
      }

      if (response.data
      is! Map<String, dynamic>) {
        return false;
      }

      final data =
      response.data as Map<String, dynamic>;

      // ------------------------------------------------------
      // NEW ACCESS TOKEN
      // ------------------------------------------------------

      final newAccessToken =
      data["access"]?.toString();

      if (newAccessToken == null ||
          newAccessToken.isEmpty) {
        return false;
      }

      // ------------------------------------------------------
      // NEW ROTATED REFRESH TOKEN
      // ------------------------------------------------------
      //
      // Django may return a new refresh token because:
      //
      // ROTATE_REFRESH_TOKENS = True
      // BLACKLIST_AFTER_ROTATION = True
      //
      // If Django sends one, replace the old token.
      //

      final newRefreshToken =
      data["refresh"]?.toString();

      // ------------------------------------------------------
      // SAVE TOKENS
      // ------------------------------------------------------

      if (newRefreshToken != null &&
          newRefreshToken.isNotEmpty) {
        await storage.saveTokens(
          access: newAccessToken,
          refresh: newRefreshToken,
        );
      } else {
        await storage.saveAccessToken(
          newAccessToken,
        );
      }

      return true;
    } on DioException {
      return false;
    } catch (_) {
      return false;
    }
  }

  // ==========================================================
  // CLEAR SESSION
  // ==========================================================

  Future<void> _clearSession() async {
    await storage.clear();
  }
}