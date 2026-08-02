import '../models/vendor_product_model.dart';
import '../repository/vendor_product_repository.dart';

class VendorProductController {
  final VendorProductRepository repository =
  VendorProductRepository();

  Future<List<VendorProductModel>> loadProducts(
      int vendorId,
      ) {
    return repository.getVendorProducts(
      vendorId,
    );
  }
}