import 'package:dio/dio.dart';

import 'auth_interceptor.dart';
import 'endpoints.dart';

class ApiClient {
  static final Dio dio = Dio(
    BaseOptions(
      baseUrl: Endpoints.baseUrl,
      connectTimeout: const Duration(seconds: 30),
      receiveTimeout: const Duration(seconds: 30),
      headers: {
        "Content-Type": "application/json",
      },
    ),
  )..interceptors.add(AuthInterceptor());
}