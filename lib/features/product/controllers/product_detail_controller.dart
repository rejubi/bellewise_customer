import '../models/product_detail_model.dart';
import '../repository/product_detail_repository.dart';

class ProductDetailController {
  final ProductDetailRepository repository =
  ProductDetailRepository();

  Future<ProductDetailModel> loadProduct(
      int id) {
    return repository.loadProduct(id);
  }
}