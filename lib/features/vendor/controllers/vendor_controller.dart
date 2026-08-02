import '../models/vendor_model.dart';
import '../repository/vendor_repository.dart';

class VendorController {
  final VendorRepository repository =
  VendorRepository();

  Future<VendorModel> loadVendor(int id) {
    return repository.loadVendor(id);
  }
}