import '../data/category_products_repository.dart';
import '../models/category_products_model.dart';

class CategoryProductsController {
  final CategoryProductsRepository repository =
  CategoryProductsRepository();

  Future<CategoryProductsModel> loadCategory(
      int categoryId,
      ) {
    return repository.loadCategory(
      categoryId,
    );
  }
}