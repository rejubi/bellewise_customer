import '../api/vendor_product_api.dart';
import '../models/vendor_product_model.dart';

class VendorProductRepository {
  final VendorProductApi api = VendorProductApi();

  Future<List<VendorProductModel>> getVendorProducts(
      int vendorId,
      ) async {
    final response = await api.getVendorProducts(vendorId);

    return (response.data as List)
        .map(
          (e) => VendorProductModel.fromJson(e),
    )
        .toList();
  }
}