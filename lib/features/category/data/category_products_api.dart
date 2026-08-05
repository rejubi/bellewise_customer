import 'package:dio/dio.dart';

import '../../../core/api/api_client.dart';

class CategoryProductsApi {
  Future<Response> getCategoryProducts(
      int categoryId,
      ) async {
    return await ApiClient.dio.get(
      "/catalog/categories/$categoryId/products/",
    );
  }
}