import 'package:dio/dio.dart';

import '../../../core/api/api_client.dart';
import '../../../core/api/endpoints.dart';

class HomeApi {
  Future<Response> getHomeData() async {
    try {
      return await ApiClient.dio.get(
        Endpoints.home,
      );
    } on DioException catch (e) {
      print("=================================");
      print("STATUS: ${e.response?.statusCode}");
      print("BODY: ${e.response?.data}");
      print("=================================");
      rethrow;
    }
  }
}