import 'package:dio/dio.dart';

import '../../../core/api/api_client.dart';
import '../../../core/api/endpoints.dart';

class ResetPasswordRepository {
  Future<String> resetPassword({
    required String uid,
    required String token,
    required String newPassword,
  }) async {
    try {
      final response = await ApiClient.dio.post(
        Endpoints.resetPassword,
        data: {
          "uid": uid,
          "token": token,

          // IMPORTANT:
          // Django expects "password",
          // NOT "new_password".
          "password": newPassword,
        },
      );

      return response.data["message"]?.toString() ??
          "Password reset successful.";
    } on DioException catch (e) {
      final data = e.response?.data;

      if (data is Map) {
        if (data["message"] != null) {
          throw data["message"].toString();
        }

        if (data["detail"] != null) {
          throw data["detail"].toString();
        }

        if (data["error"] != null) {
          throw data["error"].toString();
        }
      }

      throw "Unable to reset password. Please try again.";
    } catch (e) {
      throw e.toString();
    }
  }
}