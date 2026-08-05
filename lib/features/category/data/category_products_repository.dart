import '../models/category_products_model.dart';
import 'category_products_api.dart';

class CategoryProductsRepository {
  final CategoryProductsApi api =
  CategoryProductsApi();

  Future<CategoryProductsModel> loadCategory(
      int categoryId,
      ) async {
    final response =
    await api.getCategoryProducts(categoryId);

    return CategoryProductsModel.fromJson(
      response.data,
    );
  }
}