import '../../../core/api/api_client.dart';

class ProductDetailApi {
  Future<dynamic> getProduct(int id) async {
    return await ApiClient.dio.get(
      "/catalog/products/$id/",
    );
  }
}