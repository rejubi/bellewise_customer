import 'package:flutter_riverpod/flutter_riverpod.dart';

import '../models/cart_item.dart';

class CartNotifier extends StateNotifier<List<CartItem>> {
  CartNotifier() : super([]);

  String? _currentVendor;

  String? get currentVendor => _currentVendor;

  bool canAddFromVendor(String vendor) {
    if (_currentVendor == null) return true;
    return _currentVendor == vendor;
  }

  void addItem(
      CartItem item, {
        required String vendor,
      }) {
    if (_currentVendor == null) {
      _currentVendor = vendor;
    }

    if (_currentVendor != vendor) {
      return;
    }

    final index = state.indexWhere(
          (e) => e.name == item.name,
    );

    if (index != -1) {
      final updated = [...state];
      updated[index].quantity++;
      state = updated;
      return;
    }

    state = [...state, item];
  }

  void increaseQuantity(int index) {
    final updated = [...state];
    updated[index].quantity++;
    state = updated;
  }

  void decreaseQuantity(int index) {
    final updated = [...state];

    if (updated[index].quantity > 1) {
      updated[index].quantity--;
      state = updated;
    } else {
      updated.removeAt(index);
      state = updated;

      if (state.isEmpty) {
        _currentVendor = null;
      }
    }
  }

  void removeItem(int index) {
    final updated = [...state];
    updated.removeAt(index);

    state = updated;

    if (state.isEmpty) {
      _currentVendor = null;
    }
  }

  void clearCart() {
    state = [];
    _currentVendor = null;
  }

  double get subtotal {
    double total = 0;

    for (final item in state) {
      total += item.total;
    }

    return total;
  }

  int get itemCount {
    int total = 0;

    for (final item in state) {
      total += item.quantity;
    }

    return total;
  }

  bool get isEmpty => state.isEmpty;
}

final cartProvider =
StateNotifierProvider<CartNotifier, List<CartItem>>(
      (ref) => CartNotifier(),
);