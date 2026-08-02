import '../../../core/api/api_client.dart';
import '../../../core/api/endpoints.dart';

class CartApi {
  Future<dynamic> getCart() async {
    final response = await ApiClient.dio.get(
      Endpoints.cart,
    );

    return response.data;
  }

  Future<dynamic> updateItem({
    required int itemId,
    required int quantity,
  }) async {
    final response = await ApiClient.dio.patch(
      "${Endpoints.cart}/item/$itemId/",
      data: {
        "quantity": quantity,
      },
    );

    return response.data;
  }

  Future<dynamic> removeItem(
      int itemId,
      ) async {
    final response = await ApiClient.dio.delete(
      "${Endpoints.cart}/item/$itemId/delete/",
    );

    return response.data;
  }
}