import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';

import '../../../app/theme.dart';
import '../../cart/controllers/cart_state.dart';
import '../models/vendor_product_model.dart';

class VendorProductCard extends StatefulWidget {
  final VendorProductModel product;

  const VendorProductCard({
    super.key,
    required this.product,
  });

  @override
  State<VendorProductCard> createState() =>
      _VendorProductCardState();
}

class _VendorProductCardState
    extends State<VendorProductCard> {
  final CartState cart = CartState.instance;

  bool _adding = false;

  String get unavailableText {
    switch (widget.product.unavailableReason) {
      case "shop_closed":
        return "Shop Closed";

      case "holiday":
        return "On Holiday";

      case "vendor_unavailable":
        return "Unavailable";

      default:
        return "Unavailable";
    }
  }

  Future<void> _addToCart() async {
    if (!widget.product.isPurchaseable || _adding) {
      return;
    }

    setState(() {
      _adding = true;
    });

    try {
      await cart.addProduct(
        productId: widget.product.id,
      );

      if (!mounted) return;

      ScaffoldMessenger.of(context).showSnackBar(
        SnackBar(
          content: Text(
            "${widget.product.name} added to cart",
          ),
          duration: const Duration(milliseconds: 900),
        ),
      );
    } finally {
      if (mounted) {
        setState(() {
          _adding = false;
        });
      }
    }
  }

  @override
  Widget build(BuildContext context) {
    final product = widget.product;

    final bool canPurchase =
        product.isPurchaseable;

    return Card(
      elevation: 2,
      clipBehavior: Clip.antiAlias,
      shape: RoundedRectangleBorder(
        borderRadius: BorderRadius.circular(16),
      ),
      child: Column(
        crossAxisAlignment:
        CrossAxisAlignment.start,
        children: [

          // ==================================================
          // PRODUCT IMAGE
          // Tapping the image opens product detail
          // ==================================================

          Expanded(
            flex: 5,
            child: InkWell(
              onTap: () {
                context.push(
                  "/product/${product.id}",
                );
              },
              child: SizedBox(
                width: double.infinity,
                child: Image.network(
                  product.image,
                  fit: BoxFit.cover,
                  errorBuilder: (_, __, ___) {
                    return Container(
                      color: Colors.grey.shade200,
                      child: const Center(
                        child: Icon(
                          Icons.fastfood,
                          size: 40,
                        ),
                      ),
                    );
                  },
                ),
              ),
            ),
          ),

          // ==================================================
          // PRODUCT DETAILS
          // ==================================================

          Expanded(
            flex: 5,
            child: Padding(
              padding: const EdgeInsets.fromLTRB(
                10,
                8,
                10,
                8,
              ),
              child: Column(
                crossAxisAlignment:
                CrossAxisAlignment.start,
                children: [

                  // ------------------------------------------
                  // NAME
                  // ------------------------------------------

                  InkWell(
                    onTap: () {
                      context.push(
                        "/product/${product.id}",
                      );
                    },
                    child: Text(
                      product.name,
                      maxLines: 1,
                      overflow:
                      TextOverflow.ellipsis,
                      style: const TextStyle(
                        fontWeight:
                        FontWeight.bold,
                        fontSize: 15,
                      ),
                    ),
                  ),

                  const SizedBox(height: 4),

                  // ------------------------------------------
                  // DESCRIPTION
                  // ------------------------------------------

                  Expanded(
                    child: Text(
                      product.description,
                      maxLines: 2,
                      overflow:
                      TextOverflow.ellipsis,
                      style: TextStyle(
                        color: Colors.grey.shade600,
                        fontSize: 12,
                      ),
                    ),
                  ),

                  const SizedBox(height: 5),

                  // ------------------------------------------
                  // PRICE
                  // ------------------------------------------

                  if (product.discountPrice != null)
                    Row(
                      children: [
                        Text(
                          "₦${product.discountPrice!.toStringAsFixed(0)}",
                          style: const TextStyle(
                            color:
                            AppColors.primary,
                            fontWeight:
                            FontWeight.bold,
                            fontSize: 15,
                          ),
                        ),

                        const SizedBox(width: 6),

                        Expanded(
                          child: Text(
                            "₦${product.price.toStringAsFixed(0)}",
                            overflow:
                            TextOverflow.ellipsis,
                            style: const TextStyle(
                              color: Colors.grey,
                              fontSize: 12,
                              decoration:
                              TextDecoration
                                  .lineThrough,
                            ),
                          ),
                        ),
                      ],
                    )
                  else
                    Text(
                      "₦${product.price.toStringAsFixed(0)}",
                      style: const TextStyle(
                        color:
                        AppColors.primary,
                        fontWeight:
                        FontWeight.bold,
                        fontSize: 15,
                      ),
                    ),

                  const SizedBox(height: 5),

                  // ------------------------------------------
                  // PREPARATION TIME
                  // ------------------------------------------

                  Row(
                    children: [
                      const Icon(
                        Icons.schedule,
                        size: 14,
                        color: Colors.grey,
                      ),

                      const SizedBox(width: 4),

                      Text(
                        "${product.preparationTime} mins",
                        style: const TextStyle(
                          fontSize: 11,
                          color: Colors.grey,
                        ),
                      ),
                    ],
                  ),

                  const SizedBox(height: 7),

                  // ------------------------------------------
                  // ADD TO CART / UNAVAILABLE
                  // ------------------------------------------

                  SizedBox(
                    width: double.infinity,
                    height: 42,
                    child: Material(
                      color: canPurchase
                          ? AppColors.primary
                          : Colors.grey.shade300,
                      borderRadius:
                      BorderRadius.circular(10),
                      child: InkWell(
                        borderRadius:
                        BorderRadius.circular(10),

                        // IMPORTANT:
                        // This handles the button tap itself
                        // instead of allowing the product
                        // detail tap to happen.
                        onTap: canPurchase
                            ? _addToCart
                            : null,

                        child: Center(
                          child: _adding
                              ? const SizedBox(
                            width: 20,
                            height: 20,
                            child:
                            CircularProgressIndicator(
                              strokeWidth: 2,
                              color:
                              Colors.white,
                            ),
                          )
                              : Text(
                            canPurchase
                                ? "Add to Cart"
                                : unavailableText,
                            style: TextStyle(
                              color: canPurchase
                                  ? Colors.white
                                  : Colors
                                  .grey
                                  .shade700,
                              fontWeight:
                              FontWeight.bold,
                              fontSize: 12,
                            ),
                          ),
                        ),
                      ),
                    ),
                  ),
                ],
              ),
            ),
          ),
        ],
      ),
    );
  }
}