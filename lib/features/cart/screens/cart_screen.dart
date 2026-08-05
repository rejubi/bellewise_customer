import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';

import '../../../app/theme.dart';
import '../../../core/errors/error_handler.dart';
import '../../../core/widgets/error_view.dart';
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
            return ErrorView(
              message: ErrorHandler.getMessage(
                snapshot.error,
              ),
              onRetry: _reload,
            );
          }

          if (!snapshot.hasData) {
            return ErrorView(
              message: "Unable to load your cart.",
              onRetry: _reload,
            );
          }

          final cart = snapshot.data!;

          if (cart.items.isEmpty) {
            return RefreshIndicator(
              onRefresh: _reload,
              child: ListView(
                physics: const AlwaysScrollableScrollPhysics(),
                padding: const EdgeInsets.symmetric(
                  horizontal: 24,
                ),
                children: [
                  const SizedBox(height: 120),

                  const Icon(
                    Icons.shopping_cart_outlined,
                    size: 90,
                    color: Colors.grey,
                  ),

                  const SizedBox(height: 24),

                  const Center(
                    child: Text(
                      "Your cart is empty",
                      style: TextStyle(
                        fontSize: 22,
                        fontWeight: FontWeight.bold,
                      ),
                    ),
                  ),

                  const SizedBox(height: 10),

                  Center(
                    child: Text(
                      "Browse restaurants and add delicious meals to your cart.",
                      textAlign: TextAlign.center,
                      style: TextStyle(
                        color: Colors.grey.shade600,
                        height: 1.5,
                      ),
                    ),
                  ),

                  const SizedBox(height: 32),

                  SizedBox(
                    width: double.infinity,
                    child: ElevatedButton.icon(
                      style: ElevatedButton.styleFrom(
                        backgroundColor: AppColors.primary,
                        foregroundColor: Colors.white,
                        padding: const EdgeInsets.symmetric(
                          vertical: 16,
                        ),
                        shape: RoundedRectangleBorder(
                          borderRadius: BorderRadius.circular(14),
                        ),
                      ),
                      onPressed: () {
                        context.go("/home");
                      },
                      icon: const Icon(Icons.restaurant_menu),
                      label: const Text(
                        "Start Shopping",
                        style: TextStyle(
                          fontSize: 16,
                          fontWeight: FontWeight.w600,
                        ),
                      ),
                    ),
                  ),
                ],
              ),
            );
          }

          return Column(
            children: [
              Expanded(
                child: RefreshIndicator(
                  onRefresh: _reload,
                  child: ListView(
                    physics:
                    const AlwaysScrollableScrollPhysics(),
                    children: [
                      if (cart.vendor != null)
                        Container(
                          margin:
                          const EdgeInsets.all(16),
                          padding:
                          const EdgeInsets.all(16),
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
                                child: cart.vendor!.logo ==
                                    null
                                    ? const Icon(
                                  Icons.store,
                                )
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

                            await _reload();
                          },
                          onDecrease: () async {
                            if (item.quantity == 1) {
                              await controller.removeItem(
                                item.id,
                              );
                            } else {
                              await controller.updateItem(
                                item.id,
                                item.quantity - 1,
                              );
                            }

                            await _reload();
                          },
                          onRemove: () async {
                            await controller.removeItem(
                              item.id,
                            );

                            await _reload();
                          },
                        ),
                      ),

                      const SizedBox(height: 12),
                    ],
                  ),
                ),
              ),

              CartSummary(
                subtotal: cart.subtotal,
              ),

              CheckoutButton(
                onPressed: () {
                  context.push(
                    "/checkout",
                    extra: cart,
                  );
                },
              ),
            ],
          );
        },
      ),
    );
  }
}