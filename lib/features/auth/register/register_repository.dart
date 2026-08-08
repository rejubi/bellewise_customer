import 'package:dio/dio.dart';

import '../../../core/api/endpoints.dart';

class RegisterRepository {
  final Dio _dio = Dio(
    BaseOptions(
      baseUrl: Endpoints.baseUrl,
      connectTimeout: const Duration(seconds: 30),
      receiveTimeout: const Duration(seconds: 30),
      headers: {
        "Accept": "application/json",
        "Content-Type": "application/json",
      },
    ),
  );

  Future<Response> register({
    required String firstName,
    required String lastName,
    required String email,
    required String phoneNumber,
    required String password,
    required String confirmPassword,
  }) {
    return _dio.post(
      Endpoints.register,
      data: {
        "first_name": firstName,
        "last_name": lastName,
        "email": email,
        "phone_number": phoneNumber,
        "password": password,
        "confirm_password": confirmPassword,
      },
    );
  }
}