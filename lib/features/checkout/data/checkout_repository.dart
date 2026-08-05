import 'package:dio/dio.dart';

import '../../../core/api/api_client.dart';
import '../../../core/api/endpoints.dart';
import '../models/checkout_request_model.dart';

class CheckoutRepository {
  Future<Response> createOrder(
      CheckoutRequestModel request,
      ) {
    return ApiClient.dio.post(
      Endpoints.createOrder,
      data: request.toJson(),
    );
  }
}