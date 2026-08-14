import 'package:flutter/material.dart';

import '../../../app/theme.dart';
import '../../../core/errors/error_handler.dart';
import '../../../core/widgets/error_view.dart';
import '../../cart/widgets/floating_cart_button.dart';
import '../controllers/vendor_controller.dart';
import '../models/vendor_model.dart';
import '../widgets/vendor_header.dart';
import '../widgets/vendor_info.dart';
import '../widgets/vendor_loading.dart';
import '../widgets/vendor_product_grid.dart';

class VendorScreen extends StatefulWidget {
  final int vendorId;

  const VendorScreen({
    super.key,
    required this.vendorId,
  });

  @override
  State<VendorScreen> createState() => _VendorScreenState();
}

class _VendorScreenState extends State<VendorScreen> {
  final VendorController controller = VendorController();

  late Future<VendorModel> vendorFuture;

  @override
  void initState() {
    super.initState();
    vendorFuture = controller.loadVendor(widget.vendorId);
  }

  Future<void> _reload() async {
    setState(() {
      vendorFuture = controller.loadVendor(widget.vendorId);
    });

    await vendorFuture;
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: AppColors.background,
      body: FutureBuilder<VendorModel>(
        future: vendorFuture,
        builder: (context, snapshot) {
          if (snapshot.connectionState == ConnectionState.waiting) {
            return const VendorLoading();
          }

          if (snapshot.hasError) {
            return ErrorView(
              message: ErrorHandler.getMessage(snapshot.error),
              onRetry: _reload,
            );
          }

          if (!snapshot.hasData) {
            return ErrorView(
              message: "Vendor not found.",
              onRetry: _reload,
            );
          }

          final vendor = snapshot.data!;

          return Stack(
            children: [
              RefreshIndicator(
                onRefresh: _reload,
                child: CustomScrollView(
                  physics: const AlwaysScrollableScrollPhysics(),
                  slivers: [
                    VendorHeader(vendor: vendor),

                    SliverToBoxAdapter(
                      child: VendorInfo(vendor: vendor),
                    ),

                    SliverToBoxAdapter(
                      child: VendorProductGrid(
                        vendorId: vendor.id,
                        vendorName: vendor.businessName,
                      ),
                    ),

                    // Extra space so the last products
                    // are visible above the floating cart.
                    const SliverToBoxAdapter(
                      child: SizedBox(height: 120),
                    ),
                  ],
                ),
              ),

              Positioned(
                left: 0,
                right: 0,
                bottom: 16,
                child: const FloatingCartButton(),
              ),
            ],
          );
        },
      ),
    );
  }
}