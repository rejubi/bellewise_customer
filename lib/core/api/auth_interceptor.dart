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

    if (token != null && token.isNotEmpty) {
      options.headers["Authorization"] = "Bearer $token";
    }

    handler.next(options);
  }

  @override
  Future<void> onError(
      DioException err,
      ErrorInterceptorHandler handler,
      ) async {
    // Only attempt refresh for Unauthorized responses.
    if (err.response?.statusCode != 401) {
      return handler.next(err);
    }

    try {
      final refresh = await storage.getRefreshToken();

      if (refresh == null || refresh.isEmpty) {
        await storage.clear();
        return handler.next(err);
      }

      // Use a fresh Dio instance to avoid recursive interception.
      final refreshResponse = await Dio().post(
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

      final String newAccess = refreshResponse.data["access"];

      // JWT rotation may or may not return a new refresh token.
      final String newRefresh =
          refreshResponse.data["refresh"] ?? refresh;

      await storage.saveTokens(
        access: newAccess,
        refresh: newRefresh,
      );

      // Retry the original request with the new access token.
      final request = err.requestOptions;

      request.headers["Authorization"] = "Bearer $newAccess";

      final response = await ApiClient.dio.fetch(request);

      return handler.resolve(response);
    } catch (e) {
      await storage.clear();
      return handler.next(err);
    }
  }
}