import 'package:dio/dio.dart';

import '../../../core/api/api_client.dart';
import '../../../core/api/endpoints.dart';

class LoginRepository {
  Future<Response> login({
    required String email,
    required String password,
  }) {
    return ApiClient.dio.post(
      Endpoints.login,
      data: {
        "email": email,
        "password": password,
      },
    );
  }
}