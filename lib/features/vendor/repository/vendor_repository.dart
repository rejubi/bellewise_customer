import '../models/vendor_model.dart';
import '../services/vendor_api.dart';

class VendorRepository {
  final VendorApi api = VendorApi();

  Future<VendorModel> loadVendor(int id) async {
    final response = await api.getVendor(id);

    return VendorModel.fromJson(
      response.data,
    );
  }
}