import 'package:dio/dio.dart';

import '../storage/secure_storage.dart';
import 'api_client.dart';
import 'endpoints.dart';

class AuthInterceptor extends Interceptor {
  final SecureStorage storage = SecureStorage();

  @override
  Future<void> onRequest(
      RequestOptions options,
      RequestInterceptorHandler handler,
      ) async {
    final token = await storage.getAccessToken();

    // Public authentication endpoints do not need
    // an Authorization header.
    final isPublicEndpoint =
        options.path == Endpoints.login ||
            options.path == Endpoints.register ||
            options.path == Endpoints.forgotPassword ||
            options.path == Endpoints.resetPassword ||
            options.path == Endpoints.refresh;

    if (!isPublicEndpoint &&
        token != null &&
        token.isNotEmpty) {
      options.headers["Authorization"] = "Bearer $token";
    }

    handler.next(options);
  }

  @override
  Future<void> onError(
      DioException err,
      ErrorInterceptorHandler handler,
      ) async {
    // Only handle 401 responses.
    if (err.response?.statusCode != 401) {
      return handler.next(err);
    }

    final request = err.requestOptions;

    // Never try to refresh a token for public authentication
    // endpoints. A 401 from registration/login/etc. should
    // simply be returned to the caller.
    final isPublicEndpoint =
        request.path == Endpoints.login ||
            request.path == Endpoints.register ||
            request.path == Endpoints.forgotPassword ||
            request.path == Endpoints.resetPassword ||
            request.path == Endpoints.refresh;

    if (isPublicEndpoint) {
      return handler.next(err);
    }

    try {
      final refresh = await storage.getRefreshToken();

      if (refresh == null || refresh.isEmpty) {
        await storage.clear();
        return handler.next(err);
      }

      // Use a separate Dio instance so the refresh request
      // does not trigger this interceptor again.
      final refreshDio = Dio();

      final refreshResponse = await refreshDio.post(
        "${Endpoints.baseUrl}${Endpoints.refresh}",
        data: {
          "refresh": refresh,
        },
        options: Options(
          headers: {
            "Accept": "application/json",
            "Content-Type": "application/json",
          },
        ),
      );

      if (refreshResponse.statusCode != 200) {
        await storage.clear();
        return handler.next(err);
      }

      final newAccess =
      refreshResponse.data["access"] as String?;

      if (newAccess == null || newAccess.isEmpty) {
        await storage.clear();
        return handler.next(err);
      }

      final newRefresh =
          refreshResponse.data["refresh"] as String? ??
              refresh;

      await storage.saveTokens(
        access: newAccess,
        refresh: newRefresh,
      );

      // Retry the original request with the new access token.
      request.headers["Authorization"] =
      "Bearer $newAccess";

      final response =
      await ApiClient.dio.fetch(request);

      return handler.resolve(response);
    } catch (_) {
      await storage.clear();
      return handler.next(err);
    }
  }
}