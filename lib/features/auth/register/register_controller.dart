import 'package:dio/dio.dart';

import 'register_repository.dart';

class RegisterController {
  final RegisterRepository repository = RegisterRepository();

  Future<String?> register({
    required String firstName,
    required String lastName,
    required String email,
    required String phoneNumber,
    required String password,
    required String confirmPassword,
  }) async {
    try {
      await repository.register(
        firstName: firstName,
        lastName: lastName,
        email: email,
        phoneNumber: phoneNumber,
        password: password,
        confirmPassword: confirmPassword,
      );

      return null;
    } on DioException catch (e) {
      final data = e.response?.data;

      if (data is Map<String, dynamic>) {
        for (final value in data.values) {
          if (value is List && value.isNotEmpty) {
            return value.first.toString();
          }

          if (value is String) {
            return value;
          }
        }
      }

      return e.response?.statusMessage ?? "Registration failed.";
    } catch (_) {
      return "Something went wrong.";
    }
  }
}