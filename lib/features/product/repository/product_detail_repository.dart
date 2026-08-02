import '../models/product_detail_model.dart';
import '../services/product_detail_api.dart';

class ProductDetailRepository {
  final ProductDetailApi api =
  ProductDetailApi();

  Future<ProductDetailModel> loadProduct(
      int id) async {
    final response = await api.getProduct(id);

    return ProductDetailModel.fromJson(
      response.data,
    );
  }
}