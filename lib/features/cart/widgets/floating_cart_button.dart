import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';

import '../../../app/theme.dart';
import '../controllers/cart_state.dart';

class FloatingCartButton extends StatelessWidget {
  const FloatingCartButton({
    super.key,
  });

  @override
  Widget build(BuildContext context) {
    final cart = CartState.instance;

    return AnimatedSwitcher(
      duration: const Duration(milliseconds: 300),
      child: cart.isEmpty
          ? const SizedBox.shrink()
          : Positioned(
        left: 16,
        right: 16,
        bottom: 82,
        child: SafeArea(
          child: Material(
            color: Colors.transparent,
            child: InkWell(
              borderRadius: BorderRadius.circular(18),
              onTap: () async {
                await context.push("/cart");

                if (context.mounted) {
                  await cart.refresh();
                }
              },
              child: Ink(
                decoration: BoxDecoration(
                  color: AppColors.primary,
                  borderRadius:
                  BorderRadius.circular(18),
                  boxShadow: [
                    BoxShadow(
                      color: Colors.black26,
                      blurRadius: 12,
                      offset: const Offset(0, 5),
                    ),
                  ],
                ),
                child: Padding(
                  padding:
                  const EdgeInsets.symmetric(
                    horizontal: 20,
                    vertical: 16,
                  ),
                  child: Row(
                    children: [
                      const Icon(
                        Icons.shopping_bag,
                        color: Colors.white,
                      ),

                      const SizedBox(width: 14),

                      const Expanded(
                        child: Text(
                          "View Cart",
                          style: TextStyle(
                            color: Colors.white,
                            fontWeight:
                            FontWeight.bold,
                            fontSize: 17,
                          ),
                        ),
                      ),

                      Column(
                        crossAxisAlignment:
                        CrossAxisAlignment.end,
                        children: [
                          Text(
                            "${cart.itemCount} item${cart.itemCount == 1 ? "" : "s"}",
                            style:
                            const TextStyle(
                              color: Colors.white70,
                              fontSize: 12,
                            ),
                          ),

                          Text(
                            "₦${cart.total.toStringAsFixed(0)}",
                            style:
                            const TextStyle(
                              color: Colors.white,
                              fontWeight:
                              FontWeight.bold,
                              fontSize: 18,
                            ),
                          ),
                        ],
                      ),

                      const SizedBox(width: 12),

                      const Icon(
                        Icons.arrow_forward_ios,
                        color: Colors.white,
                        size: 18,
                      ),
                    ],
                  ),
                ),
              ),
            ),
          ),
        ),
      ),
    );
  }
}