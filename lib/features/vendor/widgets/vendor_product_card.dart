import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';

import '../../../app/theme.dart';
import '../../cart/controllers/cart_state.dart';
import '../../cart/widgets/single_vendor_dialog.dart';
import '../models/vendor_product_model.dart';

class VendorProductCard extends StatefulWidget {
  final VendorProductModel product;
  final int vendorId;
  final String vendorName;

  const VendorProductCard({
    super.key,
    required this.product,
    required this.vendorId,
    required this.vendorName,
  });

  @override
  State<VendorProductCard> createState() =>
      _VendorProductCardState();
}

class _VendorProductCardState
    extends State<VendorProductCard> {
  final CartState cart = CartState.instance;

  bool _adding = false;

  // ==========================================================
  // UNAVAILABLE TEXT
  // ==========================================================

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

  // ==========================================================
  // ADD PRODUCT
  // ==========================================================

  Future<void> _addToCart() async {
    if (!widget.product.isPurchaseable || _adding) {
      return;
    }

    setState(() {
      _adding = true;
    });

    try {
      // --------------------------------------------------------
      // LOAD CART
      // --------------------------------------------------------

      if (!cart.isLoaded) {
        await cart.load();
      }

      if (!mounted) return;

      // --------------------------------------------------------
      // CHECK FOR DIFFERENT VENDOR
      // --------------------------------------------------------

      if (cart.cart != null &&
          cart.cart!.vendor != null &&
          cart.cart!.vendor!.id != widget.vendorId) {
        final replace = await SingleVendorDialog.show(
          context: context,
          currentVendor:
          cart.cart!.vendor!.businessName,
          newVendor:
          widget.vendorName,
        );

        if (!mounted) return;

        // Customer chose not to replace
        if (!replace) {
          return;
        }

        // Customer agreed to replace vendor
        await cart.clearCart();
      }

      // --------------------------------------------------------
      // ADD PRODUCT
      // --------------------------------------------------------

      await cart.addProduct(
        productId: widget.product.id,
      );

      if (!mounted) return;

      ScaffoldMessenger.of(context).showSnackBar(
        SnackBar(
          content: Text(
            "${widget.product.name} added to cart",
          ),
          duration: const Duration(
            milliseconds: 900,
          ),
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
  // INCREASE QUANTITY
  // ==========================================================

  void _increaseQuantity() {
    cart.increaseProduct(
      widget.product.id,
    );
  }

  // ==========================================================
  // DECREASE QUANTITY
  // ==========================================================

  void _decreaseQuantity() {
    cart.decreaseProduct(
      widget.product.id,
    );
  }

  // ==========================================================
  // BUILD
  // ==========================================================

  @override
  Widget build(BuildContext context) {
    final product = widget.product;

    final bool canPurchase =
        product.isPurchaseable;

    return AnimatedBuilder(
      animation: cart,
      builder: (context, _) {
        // ======================================================
        // GET CURRENT QUANTITY FROM CART STATE
        // ======================================================

        final int quantity =
        cart.quantityForProduct(
          product.id,
        );

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
                  padding:
                  const EdgeInsets.fromLTRB(
                    10,
                    8,
                    10,
                    8,
                  ),
                  child: Column(
                    crossAxisAlignment:
                    CrossAxisAlignment.start,
                    children: [

                      // ==========================================
                      // NAME
                      // ==========================================

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

                      // ==========================================
                      // DESCRIPTION
                      // ==========================================

                      Expanded(
                        child: Text(
                          product.description,
                          maxLines: 2,
                          overflow:
                          TextOverflow.ellipsis,
                          style: TextStyle(
                            color:
                            Colors.grey.shade600,
                            fontSize: 12,
                          ),
                        ),
                      ),

                      const SizedBox(height: 5),

                      // ==========================================
                      // PRICE
                      // ==========================================

                      if (product.discountPrice != null)
                        Row(
                          children: [
                            Text(
                              "₦${product.discountPrice!.toStringAsFixed(0)}",
                              style:
                              const TextStyle(
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
                                style:
                                const TextStyle(
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

                      // ==========================================
                      // PREPARATION TIME
                      // ==========================================

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
                            style:
                            const TextStyle(
                              fontSize: 11,
                              color: Colors.grey,
                            ),
                          ),
                        ],
                      ),

                      const SizedBox(height: 7),

                      // ==========================================
                      // CART ACTION
                      // ==========================================

                      SizedBox(
                        width: double.infinity,
                        height: 42,
                        child: !canPurchase
                            ? _buildUnavailableButton()
                            : quantity == 0
                            ? _buildAddButton()
                            : _buildQuantitySelector(
                          quantity,
                        ),
                      ),
                    ],
                  ),
                ),
              ),
            ],
          ),
        );
      },
    );
  }

  // ==========================================================
  // ADD TO CART BUTTON
  // ==========================================================

  Widget _buildAddButton() {
    return Material(
      color: AppColors.primary,
      borderRadius:
      BorderRadius.circular(10),
      child: InkWell(
        borderRadius:
        BorderRadius.circular(10),
        onTap: _adding
            ? null
            : _addToCart,
        child: Center(
          child: _adding
              ? const SizedBox(
            width: 20,
            height: 20,
            child:
            CircularProgressIndicator(
              strokeWidth: 2,
              color: Colors.white,
            ),
          )
              : const Row(
            mainAxisAlignment:
            MainAxisAlignment.center,
            children: [
              Icon(
                Icons
                    .shopping_cart_outlined,
                size: 18,
                color: Colors.white,
              ),
              SizedBox(width: 6),
              Text(
                "Add to Cart",
                style: TextStyle(
                  color: Colors.white,
                  fontWeight:
                  FontWeight.bold,
                  fontSize: 12,
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }

  // ==========================================================
  // QUANTITY SELECTOR
  // ==========================================================

  Widget _buildQuantitySelector(
      int quantity,
      ) {
    return Container(
      decoration: BoxDecoration(
        color: AppColors.primary,
        borderRadius:
        BorderRadius.circular(10),
      ),
      child: Row(
        children: [

          // ==============================================
          // MINUS
          // ==============================================

          Expanded(
            child: IconButton(
              onPressed:
              _decreaseQuantity,
              padding: EdgeInsets.zero,
              icon: const Icon(
                Icons.remove,
                color: Colors.white,
                size: 20,
              ),
            ),
          ),

          // ==============================================
          // QUANTITY
          // ==============================================

          Expanded(
            child: Center(
              child: Text(
                "$quantity",
                style: const TextStyle(
                  color: Colors.white,
                  fontSize: 17,
                  fontWeight:
                  FontWeight.bold,
                ),
              ),
            ),
          ),

          // ==============================================
          // PLUS
          // ==============================================

          Expanded(
            child: IconButton(
              onPressed:
              _increaseQuantity,
              padding: EdgeInsets.zero,
              icon: const Icon(
                Icons.add,
                color: Colors.white,
                size: 20,
              ),
            ),
          ),
        ],
      ),
    );
  }

  // ==========================================================
  // UNAVAILABLE BUTTON
  // ==========================================================

  Widget _buildUnavailableButton() {
    return Container(
      decoration: BoxDecoration(
        color: Colors.grey.shade300,
        borderRadius:
        BorderRadius.circular(10),
      ),
      child: Center(
        child: Text(
          unavailableText,
          style: TextStyle(
            color: Colors.grey.shade700,
            fontWeight: FontWeight.bold,
            fontSize: 12,
          ),
        ),
      ),
    );
  }
}