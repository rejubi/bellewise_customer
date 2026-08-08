import 'package:dio/dio.dart';

import '../../../core/api/api_client.dart';
import '../../../core/api/endpoints.dart';
import '../models/checkout_request_model.dart';

class CheckoutRepository {
  Future<Response> createOrder(
      CheckoutRequestModel request,
      ) async {
    try {
      final response = await ApiClient.dio.post(
        Endpoints.createOrder,
        data: request.toJson(),
      );

      print('========== CREATE ORDER SUCCESS ==========');
      print('STATUS: ${response.statusCode}');
      print('DATA: ${response.data}');
      print('==========================================');

      return response;
    } on DioException catch (e) {
      print('========== CREATE ORDER ERROR ==========');
      print('STATUS: ${e.response?.statusCode}');
      print('DATA: ${e.response?.data}');
      print('REQUEST DATA: ${request.toJson()}');
      print('URL: ${e.requestOptions.uri}');
      print('=========================================');

      rethrow;
    }
  }
}