import 'package:flutter/material.dart';

import '../../../app/theme.dart';
import '../../../core/errors/error_handler.dart';
import '../../../core/widgets/error_view.dart';
import '../../cart/controllers/cart_state.dart';
import '../../cart/widgets/single_vendor_dialog.dart';
import '../../favorites/controllers/favorites_controller.dart';
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

  final FavoritesController favorites =
      FavoritesController.instance;

  late Future<ProductDetailModel> future;

  @override
  void initState() {
    super.initState();

    favorites.addListener(_favoriteChanged);

    future = controller.loadProduct(
      widget.productId,
    );
  }

  @override
  void dispose() {
    favorites.removeListener(_favoriteChanged);
    super.dispose();
  }

  void _favoriteChanged() {
    if (mounted) {
      setState(() {});
    }
  }

  Future<void> _reload() async {
    setState(() {
      future = controller.loadProduct(
        widget.productId,
      );
    });

    await future;
  }

  Future<void> _addToCart(
      ProductDetailModel product,
      ) async {
    final cart = CartState.instance;

    if (!cart.isLoaded) {
      await cart.load();
    }

    if (!mounted) return;

    if (cart.cart != null &&
        cart.cart!.vendor != null &&
        cart.cart!.vendor!.id != product.vendorId) {
      final replace = await SingleVendorDialog.show(
        context: context,
        currentVendor:
        cart.cart!.vendor!.businessName,
        newVendor: product.vendorName,
      );

      if (!mounted) return;

      if (!replace) {
        return;
      }

      await cart.clearCart();
    }

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

  void _toggleFavorite() {
    favorites.toggleFavorite(
      widget.productId,
    );

    if (!mounted) return;

    final isFavorite =
    favorites.isFavorite(widget.productId);

    ScaffoldMessenger.of(context).showSnackBar(
      SnackBar(
        content: Text(
          isFavorite
              ? "Added to favorites"
              : "Removed from favorites",
        ),
        duration:
        const Duration(milliseconds: 900),
      ),
    );
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: AppColors.background,
      body: FutureBuilder<ProductDetailModel>(
        future: future,
        builder: (context, snapshot) {
          if (snapshot.connectionState ==
              ConnectionState.waiting) {
            return const Center(
              child: CircularProgressIndicator(),
            );
          }

          if (snapshot.hasError) {
            return ErrorView(
              message:
              ErrorHandler.getMessage(
                snapshot.error,
              ),
              onRetry: _reload,
            );
          }

          if (!snapshot.hasData) {
            return ErrorView(
              message: "Product not found.",
              onRetry: _reload,
            );
          }

          final product = snapshot.data!;

          final unitPrice =
              product.discountPrice ??
                  product.price;

          final isFavorite =
          favorites.isFavorite(product.id);

          return Column(
            children: [
              Expanded(
                child: CustomScrollView(
                  physics:
                  const AlwaysScrollableScrollPhysics(),
                  slivers: [
                    ProductDetailHeader(
                      image: product.image,
                      isFavorite: isFavorite,
                      onFavoritePressed:
                      _toggleFavorite,
                    ),

                    SliverToBoxAdapter(
                      child: ProductDetailInfo(
                        product: product,
                      ),
                    ),
                  ],
                ),
              ),

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