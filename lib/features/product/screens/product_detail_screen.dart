import 'package:flutter/material.dart';

import '../../../app/theme.dart';
import '../../../core/errors/error_handler.dart';
import '../../../core/widgets/error_view.dart';
import '../../cart/controllers/cart_state.dart';
import '../../cart/widgets/single_vendor_dialog.dart';
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

late Future<ProductDetailModel> future;

@override
void initState() {
super.initState();
future = controller.loadProduct(widget.productId);
}

Future<void> _reload() async {
setState(() {
future = controller.loadProduct(widget.productId);
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
currentVendor: cart.cart!.vendor!.businessName,
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

// Stay on this screen.
// The AddToCartButton will automatically
// change into the quantity selector.
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
            ErrorHandler.getMessage(snapshot.error),
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
            product.discountPrice ?? product.price;

        return Column(
          children: [
            Expanded(
              child: CustomScrollView(
                physics:
                const AlwaysScrollableScrollPhysics(),
                slivers: [
                  ProductDetailHeader(
                    image: product.image,
                  ),

                  SliverToBoxAdapter(
                    child: ProductDetailInfo(
                      product: product,
                    ),
                  ),

                  // The old QuantitySelector has been removed.
                  // The bottom button now becomes the quantity selector.
                ],
              ),
            ),

            AddToCartButton(
              productId: product.id,
              unitPrice: unitPrice,
              onAdd: () => _addToCart(
                product,
              ),
            ),
          ],
        );
      },
    ),
  );
}
}