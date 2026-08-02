import '../data/cart_repository.dart';
import '../models/cart_model.dart';

class CartController {
  final CartRepository repository = CartRepository();

  Future<CartModel> loadCart() async {
    final response = await repository.loadCart();

    return CartModel.fromJson(
      response.data,
    );
  }

  Future<CartModel> addToCart({
    required int productId,
    int quantity = 1,
  }) async {
    final response = await repository.addToCart(
      productId: productId,
      quantity: quantity,
    );

    return CartModel.fromJson(
      response.data,
    );
  }

  Future<CartModel> updateItem(
      int itemId,
      int quantity,
      ) async {
    final response = await repository.updateItem(
      itemId: itemId,
      quantity: quantity,
    );

    return CartModel.fromJson(
      response.data,
    );
  }

  Future<CartModel> removeItem(
      int itemId,
      ) async {
    final response = await repository.removeItem(
      itemId,
    );

    return CartModel.fromJson(
      response.data,
    );
  }

  Future<void> clearCart() async {
    await repository.clearCart();
  }
}