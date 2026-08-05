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
          "new_password": newPassword,
        },
      );

      return response.data["message"] as String;
    } on DioException catch (e) {
      if (e.response != null &&
          e.response!.data is Map &&
          e.response!.data["message"] != null) {
        throw e.response!.data["message"];
      }

      if (e.response != null &&
          e.response!.data is Map &&
          e.response!.data["detail"] != null) {
        throw e.response!.data["detail"];
      }

      if (e.response != null &&
          e.response!.data is Map &&
          e.response!.data["error"] != null) {
        throw e.response!.data["error"];
      }

      throw "Unable to reset password. Please try again.";
    } catch (_) {
      throw "Something went wrong. Please try again.";
    }
  }
}