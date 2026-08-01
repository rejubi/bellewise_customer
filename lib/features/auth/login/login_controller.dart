import 'package:dio/dio.dart';

import '../../../core/storage/secure_storage.dart';
import 'login_repository.dart';

class LoginController {
  final LoginRepository repository = LoginRepository();
  final SecureStorage storage = SecureStorage();

  Future<bool> login({
    required String email,
    required String password,
  }) async {
    try {
      final response = await repository.login(
        email: email,
        password: password,
      );

      final data = response.data;

      await storage.saveTokens(
        access: data["access"],
        refresh: data["refresh"],
      );

      return true;
    } on DioException {
      return false;
    } catch (_) {
      return false;
    }
  }
}