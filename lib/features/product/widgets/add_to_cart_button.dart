import 'package:flutter/material.dart';

import '../../../app/theme.dart';
import '../../cart/controllers/cart_state.dart';

class AddToCartButton extends StatelessWidget {
  final int productId;
  final double unitPrice;
  final Future<void> Function() onAdd;

  const AddToCartButton({
    super.key,
    required this.productId,
    required this.unitPrice,
    required this.onAdd,
  });

  @override
  Widget build(BuildContext context) {
    return AnimatedBuilder(
      animation: CartState.instance,
      builder: (context, _) {
        final cart = CartState.instance;

        final quantity = cart.quantityForProduct(productId);

        final totalPrice = quantity == 0
            ? unitPrice
            : unitPrice * quantity;

        return SafeArea(
          top: false,
          child: Container(
            padding: const EdgeInsets.fromLTRB(
              18,
              14,
              18,
              18,
            ),
            decoration: BoxDecoration(
              color: Colors.white,
              borderRadius: const BorderRadius.vertical(
                top: Radius.circular(26),
              ),
              boxShadow: [
                BoxShadow(
                  color: Colors.black.withAlpha(25),
                  blurRadius: 18,
                  offset: const Offset(0, -4),
                ),
              ],
            ),
            child: Row(
              children: [
                // ==================================================
                // TOTAL PRICE
                // ==================================================

                Expanded(
                  child: Column(
                    crossAxisAlignment:
                    CrossAxisAlignment.start,
                    mainAxisSize: MainAxisSize.min,
                    children: [
                      const Text(
                        "Total",
                        style: TextStyle(
                          color: Colors.grey,
                          fontSize: 13,
                        ),
                      ),

                      const SizedBox(height: 4),

                      Text(
                        "₦${totalPrice.toStringAsFixed(0)}",
                        style: const TextStyle(
                          fontSize: 28,
                          fontWeight: FontWeight.bold,
                          color: AppColors.primary,
                        ),
                      ),
                    ],
                  ),
                ),

                const SizedBox(width: 16),

                // ==================================================
                // CART ACTION
                // ==================================================

                Expanded(
                  flex: 2,
                  child: SizedBox(
                    height: 58,
                    child: quantity == 0
                        ? ElevatedButton.icon(
                      onPressed: () async {
                        await onAdd();
                      },
                      icon: const Icon(
                        Icons.shopping_cart_checkout,
                        color: Colors.white,
                      ),
                      label: const Text(
                        "Add to Cart",
                        style: TextStyle(
                          color: Colors.white,
                          fontSize: 17,
                          fontWeight: FontWeight.bold,
                        ),
                      ),
                      style: ElevatedButton.styleFrom(
                        backgroundColor:
                        AppColors.primary,
                        elevation: 0,
                        shape: RoundedRectangleBorder(
                          borderRadius:
                          BorderRadius.circular(18),
                        ),
                      ),
                    )
                        : Container(
                      decoration: BoxDecoration(
                        color: AppColors.primary,
                        borderRadius:
                        BorderRadius.circular(18),
                      ),
                      child: Row(
                        children: [
                          // ----------------------------------
                          // DECREASE
                          // ----------------------------------

                          Expanded(
                            child: IconButton(
                              onPressed: () {
                                cart.decreaseProduct(
                                  productId,
                                );
                              },
                              icon: const Icon(
                                Icons.remove,
                                color: Colors.white,
                              ),
                            ),
                          ),

                          // ----------------------------------
                          // QUANTITY
                          // ----------------------------------

                          Text(
                            "$quantity",
                            style: const TextStyle(
                              color: Colors.white,
                              fontWeight:
                              FontWeight.bold,
                              fontSize: 20,
                            ),
                          ),

                          // ----------------------------------
                          // INCREASE
                          // ----------------------------------

                          Expanded(
                            child: IconButton(
                              onPressed: () {
                                cart.increaseProduct(
                                  productId,
                                );
                              },
                              icon: const Icon(
                                Icons.add,
                                color: Colors.white,
                              ),
                            ),
                          ),
                        ],
                      ),
                    ),
                  ),
                ),
              ],
            ),
          ),
        );
      },
    );
  }
}