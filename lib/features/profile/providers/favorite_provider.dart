import 'package:flutter_riverpod/flutter_riverpod.dart';

import '../models/favorite_model.dart';

final favoriteProvider =
StateNotifierProvider<FavoriteNotifier, List<FavoriteModel>>(
      (ref) => FavoriteNotifier(),
);

class FavoriteNotifier extends StateNotifier<List<FavoriteModel>> {
  FavoriteNotifier() : super([]);

  bool isFavorite(String name) {
    return state.any((item) => item.name == name);
  }

  void toggleFavorite(FavoriteModel item) {
    if (isFavorite(item.name)) {
      state = state.where((e) => e.name != item.name).toList();
    } else {
      state = [...state, item];
    }
  }
}