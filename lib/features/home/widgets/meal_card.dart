import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';

import '../../../app/theme.dart';
import '../../cart/controllers/cart_state.dart';
import '../../cart/widgets/single_vendor_dialog.dart';
import '../models/meal_model.dart';

class MealCard extends StatefulWidget {
  final MealModel meal;

  const MealCard({
    super.key,
    required this.meal,
  });

  @override
  State<MealCard> createState() => _MealCardState();
}

class _MealCardState extends State<MealCard> {
  final CartState cart = CartState.instance;

  bool _adding = false;

  @override
  void initState() {
    super.initState();

    cart.addListener(_refresh);

    if (!cart.isLoaded) {
      cart.load();
    }
  }

  @override
  void dispose() {
    cart.removeListener(_refresh);
    super.dispose();
  }

  void _refresh() {
    if (mounted) {
      setState(() {});
    }
  }

  // ==========================================================
  // UNAVAILABLE TEXT
  // ==========================================================

  String get unavailableText {
    switch (widget.meal.unavailableReason) {
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

  // ==========================================================
  // ADD TO CART
  // ==========================================================

  Future<void> _add() async {
    if (_adding) return;

    // Product/vendor cannot currently accept orders.
    if (!widget.meal.isPurchaseable ||
        !widget.meal.available) {
      return;
    }

    // Make sure cart is loaded before checking vendor.
    if (!cart.isLoaded) {
      await cart.load();
    }

    if (!mounted) return;

    // ========================================================
    // CHECK FOR DIFFERENT VENDOR
    // ========================================================

    if (cart.cart != null &&
        cart.cart!.vendor != null &&
        cart.cart!.vendor!.id != widget.meal.vendorId) {
      final replace =
      await SingleVendorDialog.show(
        context: context,
        currentVendor:
        cart.cart!.vendor!.businessName,
        newVendor: widget.meal.vendor,
      );

      if (!mounted) return;

      if (!replace) {
        return;
      }

      await cart.clearCart();
    }

    // ========================================================
    // ADD PRODUCT
    // ========================================================

    setState(() {
      _adding = true;
    });

    try {
      await cart.addProduct(
        productId: widget.meal.id,
      );

      if (!mounted) return;

      ScaffoldMessenger.of(context).showSnackBar(
        SnackBar(
          content: Text(
            "${widget.meal.name} added to cart",
          ),
          backgroundColor: Colors.green,
          duration:
          const Duration(milliseconds: 900),
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

  // ==========================================================
  // INCREASE
  // ==========================================================

  Future<void> _increase() async {
    await cart.increaseProduct(
      widget.meal.id,
    );
  }

  // ==========================================================
  // DECREASE
  // ==========================================================

  Future<void> _decrease() async {
    await cart.decreaseProduct(
      widget.meal.id,
    );
  }

  // ==========================================================
  // OPEN PRODUCT
  // ==========================================================

  void _openProduct() {
    context.push(
      "/product/${widget.meal.id}",
    );
  }

  // ==========================================================
  // BUILD
  // ==========================================================

  @override
  Widget build(BuildContext context) {
    final meal = widget.meal;

    final quantity =
    cart.quantityForProduct(meal.id);

    final double currentPrice =
        meal.discountPrice ?? meal.price;

    final bool hasDiscount =
        meal.discountPrice != null &&
            meal.discountPrice! < meal.price;

    final bool canPurchase =
        meal.isPurchaseable &&
            meal.available;

    return SizedBox(
      width: 185,
      child: Card(
        elevation: 2,
        clipBehavior: Clip.antiAlias,
        shape: RoundedRectangleBorder(
          borderRadius:
          BorderRadius.circular(16),
        ),
        child: Column(
          crossAxisAlignment:
          CrossAxisAlignment.start,
          children: [
            // ==================================================
            // IMAGE
            // ==================================================

            Expanded(
              flex: 7,
              child: InkWell(
                onTap: _openProduct,
                child: ClipRRect(
                  borderRadius:
                  const BorderRadius.vertical(
                    top: Radius.circular(16),
                  ),
                  child: meal.image == null ||
                      meal.image!.isEmpty
                      ? const Center(
                    child: Icon(
                      Icons.fastfood,
                      size: 50,
                    ),
                  )
                      : CachedNetworkImage(
                    imageUrl: meal.image!,
                    width:
                    double.infinity,
                    fit: BoxFit.cover,
                    errorWidget:
                        (
                        context,
                        url,
                        error,
                        ) {
                      return const Center(
                        child: Icon(
                          Icons.fastfood,
                          size: 50,
                        ),
                      );
                    },
                  ),
                ),
              ),
            ),

            // ==================================================
            // NAME
            // ==================================================

            InkWell(
              onTap: _openProduct,
              child: Padding(
                padding:
                const EdgeInsets.fromLTRB(
                  10,
                  10,
                  10,
                  4,
                ),
                child: Text(
                  meal.name,
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
            ),

            // ==================================================
            // PRICE + CART ACTION
            // ==================================================

            Padding(
              padding:
              const EdgeInsets.symmetric(
                horizontal: 10,
              ),
              child: Row(
                children: [
                  // ==========================================
                  // PRICE
                  // ==========================================

                  Expanded(
                    child: Column(
                      crossAxisAlignment:
                      CrossAxisAlignment.start,
                      mainAxisSize:
                      MainAxisSize.min,
                      children: [
                        Text(
                          "₦${currentPrice.toStringAsFixed(0)}",
                          style:
                          const TextStyle(
                            color:
                            AppColors.primary,
                            fontWeight:
                            FontWeight.bold,
                            fontSize: 16,
                          ),
                        ),

                        if (hasDiscount)
                          Text(
                            "₦${meal.price.toStringAsFixed(0)}",
                            style:
                            const TextStyle(
                              color: Colors.grey,
                              fontSize: 12,
                              decoration:
                              TextDecoration
                                  .lineThrough,
                              decorationColor:
                              Colors.grey,
                            ),
                          ),
                      ],
                    ),
                  ),

                  // ==========================================
                  // UNAVAILABLE
                  // ==========================================

                  if (!canPurchase)
                    Container(
                      height: 34,
                      padding:
                      const EdgeInsets
                          .symmetric(
                        horizontal: 10,
                      ),
                      decoration:
                      BoxDecoration(
                        color:
                        Colors.grey.shade300,
                        borderRadius:
                        BorderRadius.circular(
                          20,
                        ),
                      ),
                      alignment:
                      Alignment.center,
                      child: Text(
                        unavailableText,
                        style:
                        TextStyle(
                          color:
                          Colors.grey.shade700,
                          fontWeight:
                          FontWeight.bold,
                          fontSize: 11,
                        ),
                      ),
                    )

                  // ==========================================
                  // ADD TO CART
                  // ==========================================

                  else if (quantity == 0)
                    SizedBox(
                      height: 34,
                      child: ElevatedButton(
                        onPressed:
                        _adding
                            ? null
                            : _add,
                        style:
                        ElevatedButton
                            .styleFrom(
                          backgroundColor:
                          AppColors.primary,
                          foregroundColor:
                          Colors.white,
                          disabledBackgroundColor:
                          AppColors.primary
                              .withOpacity(
                            .6,
                          ),
                          padding:
                          const EdgeInsets
                              .symmetric(
                            horizontal: 14,
                          ),
                          shape:
                          RoundedRectangleBorder(
                            borderRadius:
                            BorderRadius
                                .circular(
                              20,
                            ),
                          ),
                        ),
                        child: _adding
                            ? const SizedBox(
                          width: 16,
                          height: 16,
                          child:
                          CircularProgressIndicator(
                            strokeWidth: 2,
                            color:
                            Colors.white,
                          ),
                        )
                            : const Text(
                          "Add to Cart",
                        ),
                      ),
                    )

                  // ==========================================
                  // QUANTITY
                  // ==========================================

                  else
                    Container(
                      decoration:
                      BoxDecoration(
                        color:
                        AppColors.primary,
                        borderRadius:
                        BorderRadius.circular(
                          20,
                        ),
                      ),
                      child: Row(
                        mainAxisSize:
                        MainAxisSize.min,
                        children: [
                          IconButton(
                            onPressed:
                            _decrease,
                            icon:
                            const Icon(
                              Icons.remove,
                              color:
                              Colors.white,
                              size: 18,
                            ),
                          ),
                          Text(
                            "$quantity",
                            style:
                            const TextStyle(
                              color:
                              Colors.white,
                              fontWeight:
                              FontWeight.bold,
                            ),
                          ),
                          IconButton(
                            onPressed:
                            _increase,
                            icon:
                            const Icon(
                              Icons.add,
                              color:
                              Colors.white,
                              size: 18,
                            ),
                          ),
                        ],
                      ),
                    ),
                ],
              ),
            ),

            const SizedBox(height: 12),
          ],
        ),
      ),
    );
  }
}