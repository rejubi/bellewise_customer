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
      if (e.response?.data is Map) {
        final data = e.response!.data as Map;

        for (final value in data.values) {
          if (value is List && value.isNotEmpty) {
            return value.first.toString();
          }
          return value.toString();
        }
      }

      return "Registration failed.";
    } catch (_) {
      return "Something went wrong.";
    }
  }
}