import 'package:flutter/material.dart';

import '../../../app/theme.dart';
import '../../../core/errors/error_handler.dart';
import '../../../core/widgets/error_view.dart';
import '../../cart/controllers/cart_state.dart';
import '../../cart/widgets/single_vendor_dialog.dart';
import '../../favorites/controllers/favorites_store.dart';
import '../controllers/product_detail_controller.dart';
import '../models/product_detail_model.dart';
import '../widgets/add_to_cart_button.dart';
import '../widgets/product_detail_header.dart';
import '../widgets/product_detail_info.dart';

class ProductDetailScreen extends StatefulWidget {
  final int productId;

  const ProductDetailScreen({
    super.key,
    required this.productId,
  });

  @override
  State<ProductDetailScreen> createState() =>
      _ProductDetailScreenState();
}

class _ProductDetailScreenState
    extends State<ProductDetailScreen> {
  final ProductDetailController controller =
  ProductDetailController();

  final FavoritesStore favorites =
      FavoritesStore.instance;

  late Future<ProductDetailModel?> future;

  @override
  void initState() {
    super.initState();

    favorites.addListener(_favoriteChanged);

    // Make sure saved favorites are loaded
    // from SharedPreferences.
    favorites.initialize();

    future = controller.loadProduct(
      widget.productId,
    );
  }

  @override
  void dispose() {
    favorites.removeListener(_favoriteChanged);

    super.dispose();
  }

  // ==========================================================
  // FAVORITE STATE
  // ==========================================================

  void _favoriteChanged() {
    if (mounted) {
      setState(() {});
    }
  }

  // ==========================================================
  // RELOAD PRODUCT
  // ==========================================================

  Future<void> _reload() async {
    setState(() {
      future = controller.loadProduct(
        widget.productId,
      );
    });

    await future;
  }

  // ==========================================================
  // ADD TO CART
  // ==========================================================

  Future<void> _addToCart(
      ProductDetailModel product,
      ) async {
    final cart = CartState.instance;

    if (!cart.isLoaded) {
      await cart.load();
    }

    if (!mounted) return;

    // --------------------------------------------------------
    // CHECK FOR DIFFERENT VENDOR
    // --------------------------------------------------------

    if (cart.cart != null &&
        cart.cart!.vendor != null &&
        cart.cart!.vendor!.id != product.vendorId) {
      final replace =
      await SingleVendorDialog.show(
        context: context,
        currentVendor:
        cart.cart!.vendor!.businessName,
        newVendor:
        product.vendorName,
      );

      if (!mounted) return;

      if (!replace) {
        return;
      }

      await cart.clearCart();
    }

    // --------------------------------------------------------
    // ADD PRODUCT
    // --------------------------------------------------------

    await cart.addProduct(
      productId: product.id,
    );

    if (!mounted) return;

    ScaffoldMessenger.of(context).showSnackBar(
      SnackBar(
        content: Text(
          "${product.name} added to cart",
        ),
      ),
    );
  }

  // ==========================================================
  // TOGGLE FAVORITE
  // ==========================================================

  Future<void> _toggleFavorite(
      ProductDetailModel product,
      ) async {
    final wasFavorite =
    favorites.isFavorite(product.id);

    await favorites.toggleProduct(product);

    if (!mounted) return;

    ScaffoldMessenger.of(context).showSnackBar(
      SnackBar(
        content: Text(
          wasFavorite
              ? "Removed from favorites"
              : "Added to favorites",
        ),
        duration:
        const Duration(milliseconds: 900),
      ),
    );
  }

  // ==========================================================
  // BUILD
  // ==========================================================

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: AppColors.background,

      body: FutureBuilder<ProductDetailModel?>(
        future: future,

        builder: (context, snapshot) {
          // --------------------------------------------------
          // LOADING
          // --------------------------------------------------

          if (snapshot.connectionState ==
              ConnectionState.waiting) {
            return const Center(
              child: CircularProgressIndicator(),
            );
          }

          // --------------------------------------------------
          // ERROR
          // --------------------------------------------------

          if (snapshot.hasError) {
            return ErrorView(
              message:
              ErrorHandler.getMessage(
                snapshot.error,
              ),
              onRetry: _reload,
            );
          }

          // --------------------------------------------------
          // NO PRODUCT
          // --------------------------------------------------

          if (!snapshot.hasData ||
              snapshot.data == null) {
            return ErrorView(
              message: "Product not found.",
              onRetry: _reload,
            );
          }

          // --------------------------------------------------
          // PRODUCT
          // --------------------------------------------------

          final product = snapshot.data!;

          final unitPrice =
              product.discountPrice ??
                  product.price;

          final isFavorite =
          favorites.isFavorite(
            product.id,
          );

          return Column(
            children: [
              // ==============================================
              // PRODUCT CONTENT
              // ==============================================

              Expanded(
                child: CustomScrollView(
                  physics:
                  const AlwaysScrollableScrollPhysics(),

                  slivers: [
                    // ----------------------------------------
                    // HEADER
                    // ----------------------------------------

                    ProductDetailHeader(
                      image: product.image,
                      isFavorite: isFavorite,
                      onFavoritePressed: () {
                        _toggleFavorite(product);
                      },
                    ),

                    // ----------------------------------------
                    // PRODUCT INFORMATION
                    // ----------------------------------------

                    SliverToBoxAdapter(
                      child: ProductDetailInfo(
                        product: product,
                      ),
                    ),
                  ],
                ),
              ),

              // ==============================================
              // ADD TO CART
              // ==============================================

              AddToCartButton(
                productId: product.id,
                unitPrice: unitPrice,
                onAdd: () => _addToCart(product),
              ),
            ],
          );
        },
      ),
    );
  }
}