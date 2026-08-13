import 'package:dio/dio.dart';

import '../../../core/api/api_client.dart';
import '../../../core/api/endpoints.dart';

class ChangePasswordRepository {
  Future<String> changePassword({
    required String oldPassword,
    required String newPassword,
    required String confirmPassword,
  }) async {
    try {
      final response = await ApiClient.dio.post(
        Endpoints.changePassword,
        data: {
          "old_password": oldPassword,
          "new_password": newPassword,
          "confirm_password": confirmPassword,
        },
      );

      return response.data["message"]?.toString() ??
          "Password changed successfully.";
    } on DioException catch (e) {
      final data = e.response?.data;

      if (data is Map) {
        if (data["detail"] != null) {
          throw data["detail"].toString();
        }

        if (data["old_password"] != null) {
          throw data["old_password"].toString();
        }

        if (data["new_password"] != null) {
          throw data["new_password"].toString();
        }

        if (data["confirm_password"] != null) {
          throw data["confirm_password"].toString();
        }

        if (data["message"] != null) {
          throw data["message"].toString();
        }
      }

      throw "Unable to change password. Please try again.";
    } catch (e) {
      throw e.toString();
    }
  }
}