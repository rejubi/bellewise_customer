import 'package:dio/dio.dart';

import '../../../core/api/api_client.dart';
import '../../../core/api/endpoints.dart';

class CartRepository {
  Future<Response> loadCart() {
    return ApiClient.dio.get(
      Endpoints.cart,
    );
  }

  Future<Response> addToCart({
    required int productId,
    int quantity = 1,
  }) {
    return ApiClient.dio.post(
      Endpoints.addToCart,
      data: {
        "product_id": productId,
        "quantity": quantity,
      },
    );
  }

  Future<Response> updateItem({
    required int itemId,
    required int quantity,
  }) {
    return ApiClient.dio.patch(
      "${Endpoints.cartItem}/$itemId/",
      data: {
        "quantity": quantity,
      },
    );
  }

  Future<Response> removeItem(
      int itemId,
      ) {
    return ApiClient.dio.delete(
      "${Endpoints.cartItem}/$itemId/delete/",
    );
  }

  /// NEW
  Future<void> clearCart() async {
    await ApiClient.dio.delete(
      "${Endpoints.cart}clear/",
    );
  }
}