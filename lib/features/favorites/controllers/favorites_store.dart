import 'package:flutter/foundation.dart';

import '../../home/models/meal_model.dart';
import '../../product/models/product_detail_model.dart';

class FavoritesStore extends ChangeNotifier {
  FavoritesStore._();

  static final FavoritesStore instance =
  FavoritesStore._();

  final List<MealModel> _favorites = [];

  List<MealModel> get favorites =>
      List.unmodifiable(_favorites);

  bool isFavorite(int productId) {
    return _favorites.any(
          (meal) => meal.id == productId,
    );
  }

  void toggleMeal(MealModel meal) {
    final index = _favorites.indexWhere(
          (item) => item.id == meal.id,
    );

    if (index >= 0) {
      _favorites.removeAt(index);
    } else {
      _favorites.add(meal);
    }

    notifyListeners();
  }

  void toggleProduct(ProductDetailModel product) {
    final index = _favorites.indexWhere(
          (item) => item.id == product.id,
    );

    if (index >= 0) {
      _favorites.removeAt(index);
    } else {
      _favorites.add(
        MealModel(
          id: product.id,
          vendor: product.vendorName,
          category: product.category,
          categoryId: 0,
          name: product.name,
          description: product.description,
          price: product.price,
          discountPrice: product.discountPrice,
          image: product.image,
          preparationTime: product.preparationTime,
          available: product.available,
          featured: false,
        ),
      );
    }

    notifyListeners();
  }

  void remove(int productId) {
    _favorites.removeWhere(
          (meal) => meal.id == productId,
    );

    notifyListeners();
  }

  void clear() {
    _favorites.clear();
    notifyListeners();
  }
}