import 'package:flutter/material.dart';

import '../../../app/theme.dart';
import '../controllers/cart_controller.dart';
import '../models/cart_model.dart';
import '../widgets/cart_item_card.dart';
import '../widgets/cart_summary.dart';
import '../widgets/checkout_button.dart';

class CartScreen extends StatefulWidget {
  const CartScreen({super.key});

  @override
  State<CartScreen> createState() => _CartScreenState();
}

class _CartScreenState extends State<CartScreen> {
  final CartController controller = CartController();

  late Future<CartModel> _cartFuture;

  @override
  void initState() {
    super.initState();
    _cartFuture = controller.loadCart();
  }

  Future<void> _reload() async {
    setState(() {
      _cartFuture = controller.loadCart();
    });

    await _cartFuture;
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: AppColors.background,

      appBar: AppBar(
        title: const Text("My Cart"),
        centerTitle: true,
      ),

      body: FutureBuilder<CartModel>(
        future: _cartFuture,
        builder: (context, snapshot) {
          if (snapshot.connectionState ==
              ConnectionState.waiting) {
            return const Center(
              child: CircularProgressIndicator(),
            );
          }

          if (snapshot.hasError) {
            return Center(
              child: Text(snapshot.error.toString()),
            );
          }

          if (!snapshot.hasData) {
            return const Center(
              child: Text("Unable to load cart."),
            );
          }

          final cart = snapshot.data!;

          if (cart.items.isEmpty) {
            return RefreshIndicator(
              onRefresh: _reload,
              child: ListView(
                children: const [
                  SizedBox(height: 150),
                  Icon(
                    Icons.shopping_cart_outlined,
                    size: 90,
                    color: Colors.grey,
                  ),
                  SizedBox(height: 20),
                  Center(
                    child: Text(
                      "Your cart is empty",
                      style: TextStyle(
                        fontSize: 20,
                        fontWeight: FontWeight.bold,
                      ),
                    ),
                  ),
                  SizedBox(height: 8),
                  Center(
                    child: Text(
                      "Add meals to begin your order.",
                    ),
                  ),
                ],
              ),
            );
          }

          return RefreshIndicator(
            onRefresh: _reload,
            child: ListView(
              padding: const EdgeInsets.only(bottom: 120),
              children: [
                if (cart.vendor != null)
                  Container(
                    margin: const EdgeInsets.all(16),
                    padding: const EdgeInsets.all(16),
                    decoration: BoxDecoration(
                      color: Colors.white,
                      borderRadius:
                      BorderRadius.circular(16),
                    ),
                    child: Row(
                      children: [
                        CircleAvatar(
                          radius: 26,
                          backgroundImage:
                          cart.vendor!.logo != null
                              ? NetworkImage(
                            cart.vendor!.logo!,
                          )
                              : null,
                          child: cart.vendor!.logo == null
                              ? const Icon(Icons.store)
                              : null,
                        ),

                        const SizedBox(width: 14),

                        Expanded(
                          child: Text(
                            cart.vendor!.businessName,
                            style: const TextStyle(
                              fontWeight:
                              FontWeight.bold,
                              fontSize: 17,
                            ),
                          ),
                        ),
                      ],
                    ),
                  ),

                ...cart.items.map(
                      (item) => CartItemCard(
                    item: item,
                    onIncrease: () async {
                      await controller.updateItem(
                        item.id,
                        item.quantity + 1,
                      );
                      _reload();
                    },
                    onDecrease: () async {
                      await controller.updateItem(
                        item.id,
                        item.quantity - 1,
                      );
                      _reload();
                    },
                    onRemove: () async {
                      await controller.removeItem(
                        item.id,
                      );
                      _reload();
                    },
                  ),
                ),

                CartSummary(
                  subtotal: cart.total,
                ),
              ],
            ),
          );
        },
      ),

      bottomNavigationBar: CheckoutButton(
        onPressed: () {
          // TODO:
          // Navigate to Checkout
        },
      ),
    );
  }
}