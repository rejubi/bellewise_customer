import 'package:flutter/foundation.dart';

import '../controllers/cart_controller.dart';
import '../models/cart_item_model.dart';
import '../models/cart_model.dart';

class CartState extends ChangeNotifier {
  CartState._();

  static final CartState instance = CartState._();

  final CartController _controller = CartController();

  CartModel? _cart;

  CartModel? get cart => _cart;

  bool get isLoaded => _cart != null;

  bool get isEmpty => _cart == null || _cart!.items.isEmpty;

  int? get vendorId => _cart?.vendor?.id;

  bool get vendorIsOpen =>
      _cart?.vendor?.isOpen ?? false;

  bool get vendorIsClosed =>
      _cart?.vendor != null &&
          !_cart!.vendor!.isOpen;

  String get vendorName =>
      _cart?.vendor?.businessName ?? "";

  int get itemCount {
    if (_cart == null) {
      return 0;
    }

    return _cart!.items.fold(
      0,
          (sum, item) => sum + item.quantity,
    );
  }

  /// Product subtotal only
  double get subtotal => _cart?.subtotal ?? 0;

  /// Grand total (subtotal + delivery + service)
  double get total => _cart?.total ?? 0;

  double get deliveryFee =>
      _cart?.deliveryFee ?? 0;

  double get serviceFee =>
      _cart?.serviceFee ?? 0;

  Future<void> load() async {
    _cart = await _controller.loadCart();
    notifyListeners();
  }

  Future<void> refresh() async {
    await load();
  }

  Future<void> addProduct({
    required int productId,
    int quantity = 1,
  }) async {
    _cart = await _controller.addToCart(
      productId: productId,
      quantity: quantity,
    );

    notifyListeners();
  }

  Future<void> increaseProduct(
      int productId,
      ) async {
    final item = itemForProduct(productId);

    if (item == null) {
      await addProduct(
        productId: productId,
      );
      return;
    }

    _cart = await _controller.updateItem(
      item.id,
      item.quantity + 1,
    );

    notifyListeners();
  }

  Future<void> decreaseProduct(
      int productId,
      ) async {
    final item = itemForProduct(productId);

    if (item == null) {
      return;
    }

    if (item.quantity <= 1) {
      _cart = await _controller.removeItem(
        item.id,
      );
    } else {
      _cart = await _controller.updateItem(
        item.id,
        item.quantity - 1,
      );
    }

    notifyListeners();
  }

  Future<void> clearCart() async {
    await _controller.clearCart();

    _cart = null;

    notifyListeners();
  }

  bool containsProduct(
      int productId,
      ) {
    if (_cart == null) {
      return false;
    }

    return _cart!.containsProduct(
      productId,
    );
  }

  int quantityForProduct(
      int productId,
      ) {
    return _cart?.quantityForProduct(
      productId,
    ) ??
        0;
  }

  int? cartItemIdForProduct(
      int productId,
      ) {
    return itemForProduct(
      productId,
    )?.id;
  }

  CartItemModel? itemForProduct(
      int productId,
      ) {
    if (_cart == null) {
      return null;
    }

    return _cart!.itemForProduct(
      productId,
    );
  }

  bool hasDifferentVendor(
      int vendorId,
      ) {
    if (_cart == null) {
      return false;
    }

    return _cart!.belongsToAnotherVendor(
      vendorId,
    );
  }

  Future<void> clearAndReload() async {
    _cart = await _controller.loadCart();

    notifyListeners();
  }
}