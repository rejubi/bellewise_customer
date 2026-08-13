import 'package:dio/dio.dart';

import 'auth_interceptor.dart';
import 'endpoints.dart';

class ApiClient {
  static final Dio dio = Dio(
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

  static bool _initialized = false;

  static void initialize() {
    if (_initialized) {
      return;
    }

    dio.interceptors.add(
      AuthInterceptor(),
    );

    _initialized = true;
  }
}