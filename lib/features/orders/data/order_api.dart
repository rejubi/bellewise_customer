import 'package:dio/dio.dart';

import '../../../core/api/api_client.dart';
import '../../../core/api/endpoints.dart';

class OrderApi {
  Future<Response> getOrders() {
    return ApiClient.dio.get(
      Endpoints.orders,
    );
  }

  Future<Response> getOrder(
      int orderId,
      ) {
    return ApiClient.dio.get(
      Endpoints.orderDetail(orderId),
    );
  }

  Future<Response> cancelOrder(
      int orderId,
      ) {
    return ApiClient.dio.patch(
      Endpoints.cancelOrder(orderId),
    );
  }
}