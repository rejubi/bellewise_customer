import 'package:flutter/material.dart';

import '../models/vendor_cart_model.dart';

class VendorHeader extends StatelessWidget {
  final VendorCartModel vendor;

  const VendorHeader({
    super.key,
    required this.vendor,
  });

  @override
  Widget build(BuildContext context) {
    return ListTile(
      leading: CircleAvatar(
        radius: 28,
        backgroundImage:
        vendor.logo != null ? NetworkImage(vendor.logo!) : null,
        child: vendor.logo == null
            ? const Icon(Icons.store)
            : null,
      ),
      title: Text(
        vendor.businessName,
        style: const TextStyle(
          fontWeight: FontWeight.bold,
          fontSize: 18,
        ),
      ),
      subtitle: const Text("Restaurant"),
    );
  }
}