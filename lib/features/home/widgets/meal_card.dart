import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';

import '../../../app/theme.dart';
import '../../cart/controllers/cart_state.dart';
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
  // ADD TO CART
  // ==========================================================

  Future<void> _add() async {
    if (_adding) return;

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
  // OPEN PRODUCT DETAIL
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

    return SizedBox(
      width: 185,
      child: Card(
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
            // IMAGE
            // Tap image → Product Detail
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
                  child: meal.image == null
                      ? const Center(
                    child: Icon(
                      Icons.fastfood,
                      size: 50,
                    ),
                  )
                      : CachedNetworkImage(
                    imageUrl: meal.image!,
                    width: double.infinity,
                    fit: BoxFit.cover,
                    errorWidget:
                        (
                        context,
                        url,
                        error,
                        ) =>
                    const Center(
                      child: Icon(
                        Icons.fastfood,
                        size: 50,
                      ),
                    ),
                  ),
                ),
              ),
            ),

            // ==================================================
            // NAME
            // Tap name → Product Detail
            // ==================================================

            InkWell(
              onTap: _openProduct,
              child: Padding(
                padding: const EdgeInsets.fromLTRB(
                  10,
                  10,
                  10,
                  4,
                ),
                child: Text(
                  meal.name,
                  maxLines: 1,
                  overflow: TextOverflow.ellipsis,
                  style: const TextStyle(
                    fontWeight: FontWeight.bold,
                    fontSize: 15,
                  ),
                ),
              ),
            ),

            // ==================================================
            // PRICE + CART
            // ==================================================

            Padding(
              padding: const EdgeInsets.symmetric(
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
                      mainAxisSize: MainAxisSize.min,
                      children: [

                        Text(
                          "₦${currentPrice.toStringAsFixed(0)}",
                          style: const TextStyle(
                            color: AppColors.primary,
                            fontWeight: FontWeight.bold,
                            fontSize: 16,
                          ),
                        ),

                        if (hasDiscount)
                          Text(
                            "₦${meal.price.toStringAsFixed(0)}",
                            style: const TextStyle(
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
                  // ADD / QUANTITY
                  // ==========================================

                  if (quantity == 0)
                    SizedBox(
                      height: 34,
                      child: ElevatedButton(
                        onPressed:
                        _adding ? null : _add,
                        style:
                        ElevatedButton.styleFrom(
                          backgroundColor:
                          AppColors.primary,
                          foregroundColor:
                          Colors.white,
                          disabledBackgroundColor:
                          AppColors.primary
                              .withOpacity(.6),
                          padding:
                          const EdgeInsets.symmetric(
                            horizontal: 14,
                          ),
                          shape:
                          RoundedRectangleBorder(
                            borderRadius:
                            BorderRadius.circular(
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
                            color: Colors.white,
                          ),
                        )
                            : const Text(
                          "Add to Cart",
                        ),
                      ),
                    )
                  else
                    Container(
                      decoration: BoxDecoration(
                        color: AppColors.primary,
                        borderRadius:
                        BorderRadius.circular(20),
                      ),
                      child: Row(
                        mainAxisSize:
                        MainAxisSize.min,
                        children: [

                          IconButton(
                            onPressed: _decrease,
                            icon: const Icon(
                              Icons.remove,
                              color: Colors.white,
                              size: 18,
                            ),
                          ),

                          Text(
                            "$quantity",
                            style: const TextStyle(
                              color: Colors.white,
                              fontWeight:
                              FontWeight.bold,
                            ),
                          ),

                          IconButton(
                            onPressed: _increase,
                            icon: const Icon(
                              Icons.add,
                              color: Colors.white,
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