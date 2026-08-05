import 'package:dio/dio.dart';

import '../../../core/api/api_client.dart';
import '../../../core/api/endpoints.dart';

class ForgotPasswordRepository {
  Future<String> sendResetLink({
    required String email,
  }) async {
    try {
      final response = await ApiClient.dio.post(
        Endpoints.forgotPassword,
        data: {
          "email": email.trim(),
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

      throw "Unable to send password reset email. Please try again.";
    } catch (_) {
      throw "Something went wrong. Please try again.";
    }
  }
}