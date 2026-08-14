import 'dart:convert';

import 'package:flutter/foundation.dart';
import 'package:shared_preferences/shared_preferences.dart';

import '../../home/models/meal_model.dart';
import '../../product/models/product_detail_model.dart';

class FavoritesStore extends ChangeNotifier {
  FavoritesStore._();

  static final FavoritesStore instance =
  FavoritesStore._();

  // ============================================================
  // STORAGE
  // ============================================================

  static const String _storageKey =
      'bellewise_favorites';

  // ============================================================
  // FAVORITES
  // ============================================================

  final List<MealModel> _favorites = [];

  bool _initialized = false;

  Future<void>? _initializationFuture;

  // ============================================================
  // GETTERS
  // ============================================================

  List<MealModel> get favorites =>
      List.unmodifiable(_favorites);

  int get count => _favorites.length;

  bool get isInitialized => _initialized;

  // ============================================================
  // INITIALIZE
  // ============================================================

  Future<void> initialize() {
    _initializationFuture ??= _loadFavorites();

    return _initializationFuture!;
  }

  // ============================================================
  // LOAD FAVORITES
  // ============================================================

  Future<void> _loadFavorites() async {
    try {
      final prefs =
      await SharedPreferences.getInstance();

      final storedData =
      prefs.getString(_storageKey);

      if (storedData == null ||
          storedData.isEmpty) {
        _initialized = true;
        return;
      }

      final decoded = jsonDecode(storedData);

      if (decoded is! List) {
        _initialized = true;
        return;
      }

      _favorites.clear();

      for (final item in decoded) {
        if (item is! Map) {
          continue;
        }

        try {
          final meal = _mealFromJson(
            Map<String, dynamic>.from(item),
          );

          _favorites.add(meal);
        } catch (e) {
          debugPrint(
            'FAVORITE LOAD ITEM ERROR: $e',
          );
        }
      }

      _initialized = true;

      notifyListeners();
    } catch (e) {
      debugPrint(
        'FAVORITES LOAD ERROR: $e',
      );

      _initialized = true;
    }
  }

  // ============================================================
  // SAVE FAVORITES
  // ============================================================

  Future<void> _saveFavorites() async {
    try {
      final prefs =
      await SharedPreferences.getInstance();

      final data = _favorites
          .map(_mealToJson)
          .toList();

      await prefs.setString(
        _storageKey,
        jsonEncode(data),
      );
    } catch (e) {
      debugPrint(
        'FAVORITES SAVE ERROR: $e',
      );
    }
  }

  // ============================================================
  // CHECK FAVORITE
  // ============================================================

  bool isFavorite(int productId) {
    return _favorites.any(
          (meal) => meal.id == productId,
    );
  }

  // ============================================================
  // TOGGLE MEAL
  // ============================================================

  Future<void> toggleMeal(
      MealModel meal,
      ) async {
    await initialize();

    final index = _favorites.indexWhere(
          (item) => item.id == meal.id,
    );

    if (index >= 0) {
      _favorites.removeAt(index);
    } else {
      _favorites.add(meal);
    }

    notifyListeners();

    await _saveFavorites();
  }

  // ============================================================
  // TOGGLE PRODUCT
  // ============================================================

  Future<void> toggleProduct(
      ProductDetailModel product,
      ) async {
    await initialize();

    final index = _favorites.indexWhere(
          (item) => item.id == product.id,
    );

    if (index >= 0) {
      _favorites.removeAt(index);
    } else {
      _favorites.add(
        MealModel(
          id: product.id,

          // ====================================================
          // VENDOR
          // ====================================================

          vendor: product.vendorName,
          vendorId: product.vendorId,

          // ====================================================
          // CATEGORY
          // ====================================================

          category: product.category,
          categoryId: 0,

          // ====================================================
          // PRODUCT
          // ====================================================

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

    await _saveFavorites();
  }

  // ============================================================
  // REMOVE
  // ============================================================

  Future<void> remove(
      int productId,
      ) async {
    await initialize();

    _favorites.removeWhere(
          (meal) => meal.id == productId,
    );

    notifyListeners();

    await _saveFavorites();
  }

  // ============================================================
  // CLEAR ALL FAVORITES
  // ============================================================

  Future<void> clear() async {
    await initialize();

    _favorites.clear();

    notifyListeners();

    await _saveFavorites();
  }

  // ============================================================
  // CONVERT MEAL → JSON
  // ============================================================

  Map<String, dynamic> _mealToJson(
      MealModel meal,
      ) {
    return {
      'id': meal.id,

      // Vendor
      'vendor': meal.vendor,
      'vendorId': meal.vendorId,

      // Category
      'category': meal.category,
      'categoryId': meal.categoryId,

      // Product
      'name': meal.name,
      'description': meal.description,
      'price': meal.price,
      'discountPrice': meal.discountPrice,
      'image': meal.image,
      'preparationTime': meal.preparationTime,
      'available': meal.available,
      'featured': meal.featured,
    };
  }

  // ============================================================
  // CONVERT JSON → MEAL
  // ============================================================

  MealModel _mealFromJson(
      Map<String, dynamic> json,
      ) {
    return MealModel(
      id: (json['id'] as num).toInt(),

      // ========================================================
      // VENDOR
      // ========================================================

      vendor:
      json['vendor']?.toString() ?? '',

      vendorId:
      (json['vendorId'] as num?)?.toInt() ?? 0,

      // ========================================================
      // CATEGORY
      // ========================================================

      category:
      json['category']?.toString() ?? '',

      categoryId:
      (json['categoryId'] as num?)?.toInt() ?? 0,

      // ========================================================
      // PRODUCT
      // ========================================================

      name:
      json['name']?.toString() ?? '',

      description:
      json['description']?.toString() ?? '',

      price:
      (json['price'] as num?)?.toDouble() ?? 0,

      discountPrice:
      json['discountPrice'] == null
          ? null
          : (json['discountPrice'] as num)
          .toDouble(),

      image:
      json['image']?.toString(),

      preparationTime:
      (json['preparationTime'] as num?)
          ?.toInt() ??
          0,

      available:
      json['available'] == true,

      featured:
      json['featured'] == true,
    );
  }
}