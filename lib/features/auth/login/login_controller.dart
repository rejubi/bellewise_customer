import 'package:dio/dio.dart';

import '../../../core/services/notification_service.dart';
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

      // Save JWT tokens
      await storage.saveTokens(
        access: data["access"],
        refresh: data["refresh"],
      );

      // Start notification setup in the background.
      // Do not wait for it and do not let it interrupt login.
      Future(() async {
        try {
          await NotificationService.instance.initialize();
        } catch (_) {
          // Ignore notification errors.
        }
      });

      return true;
    } on DioException {
      return false;
    } catch (_) {
      return false;
    }
  }
}