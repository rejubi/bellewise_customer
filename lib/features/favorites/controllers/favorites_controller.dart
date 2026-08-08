import 'package:flutter/foundation.dart';

class FavoritesController extends ChangeNotifier {
  FavoritesController._();

  static final FavoritesController instance =
  FavoritesController._();

  final Set<int> _favoriteIds = {};

  bool isFavorite(int productId) {
    return _favoriteIds.contains(productId);
  }

  void toggleFavorite(int productId) {
    if (_favoriteIds.contains(productId)) {
      _favoriteIds.remove(productId);
    } else {
      _favoriteIds.add(productId);
    }

    notifyListeners();
  }

  List<int> get favoriteIds {
    return List.unmodifiable(_favoriteIds);
  }

  int get count => _favoriteIds.length;

  void clear() {
    _favoriteIds.clear();
    notifyListeners();
  }
}