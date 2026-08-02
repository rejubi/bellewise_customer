import 'package:flutter/material.dart';

import '../controllers/vendor_product_controller.dart';
import '../models/vendor_product_model.dart';
import 'vendor_product_card.dart';

class VendorProductGrid extends StatefulWidget {
  final int vendorId;

  const VendorProductGrid({
    super.key,
    required this.vendorId,
  });

  @override
  State<VendorProductGrid> createState() =>
      _VendorProductGridState();
}

class _VendorProductGridState
    extends State<VendorProductGrid> {
  final VendorProductController controller =
  VendorProductController();

  late Future<List<VendorProductModel>>
  productsFuture;

  @override
  void initState() {
    super.initState();

    productsFuture = controller.loadProducts(
      widget.vendorId,
    );
  }

  @override
  Widget build(BuildContext context) {
    return FutureBuilder<List<VendorProductModel>>(
      future: productsFuture,
      builder: (context, snapshot) {
        if (snapshot.connectionState ==
            ConnectionState.waiting) {
          return const Padding(
            padding: EdgeInsets.all(30),
            child: Center(
              child: CircularProgressIndicator(),
            ),
          );
        }

        if (snapshot.hasError) {
          return Padding(
            padding: const EdgeInsets.all(20),
            child: Text(
              snapshot.error.toString(),
            ),
          );
        }

        final products = snapshot.data ?? [];

        if (products.isEmpty) {
          return const Padding(
            padding: EdgeInsets.all(30),
            child: Center(
              child: Text(
                "No products available.",
              ),
            ),
          );
        }

        return Padding(
          padding: const EdgeInsets.all(16),
          child: GridView.builder(
            shrinkWrap: true,
            physics:
            const NeverScrollableScrollPhysics(),
            itemCount: products.length,
            gridDelegate:
            const SliverGridDelegateWithFixedCrossAxisCount(
              crossAxisCount: 2,
              childAspectRatio: .70,
              crossAxisSpacing: 14,
              mainAxisSpacing: 14,
            ),
            itemBuilder: (context, index) {
              return VendorProductCard(
                product: products[index],
              );
            },
          ),
        );
      },
    );
  }
}