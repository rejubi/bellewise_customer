import '../../../core/api/api_client.dart';

class VendorProductApi {
  Future<dynamic> getVendorProducts(int vendorId) async {
    return await ApiClient.dio.get(
      "/catalog/vendors/$vendorId/products/",
    );
  }
}