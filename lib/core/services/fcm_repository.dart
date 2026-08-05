import 'package:dio/dio.dart';

import '../api/api_client.dart';
import '../api/endpoints.dart';

class FcmRepository {
  const FcmRepository();

  Future<void> registerToken(
      String token,
      ) async {
    try {
      await ApiClient.dio.post(
        Endpoints.registerFcmToken,
        data: {
          "token": token,
        },
      );
    } on DioException {
      rethrow;
    }
  }
}