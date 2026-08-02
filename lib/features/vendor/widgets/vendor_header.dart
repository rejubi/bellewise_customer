import 'package:flutter/material.dart';

import '../models/vendor_model.dart';

class VendorHeader extends StatelessWidget {
  final VendorModel vendor;

  const VendorHeader({
    super.key,
    required this.vendor,
  });

  @override
  Widget build(BuildContext context) {
    return SliverAppBar(
      expandedHeight: 230,
      pinned: true,

      flexibleSpace: FlexibleSpaceBar(
        background: Image.network(
          vendor.banner,
          fit: BoxFit.cover,
          errorBuilder: (_, __, ___) =>
              Container(color: Colors.grey.shade300),
        ),
      ),
    );
  }
}