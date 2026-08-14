import 'package:flutter/material.dart';

import '../models/vendor_model.dart';

class VendorInfo extends StatelessWidget {
  final VendorModel vendor;

  const VendorInfo({
    super.key,
    required this.vendor,
  });

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.all(20),

      child: Column(
        crossAxisAlignment:
        CrossAxisAlignment.start,
        children: [
          Text(
            vendor.businessName,
            style: const TextStyle(
              fontSize: 24,
              fontWeight: FontWeight.bold,
            ),
          ),

          const SizedBox(height: 10),

          Text(vendor.description),

          const SizedBox(height: 15),

          Row(
            children: [
              const Icon(Icons.star,
                  color: Colors.orange),

              const SizedBox(width: 6),

              Text(
                vendor.rating.toString(),
              ),

              const Spacer(),

              const SizedBox(width: 20),

              Text(
                "₦${vendor.deliveryFee.toStringAsFixed(0)}",
              ),
            ],
          ),
        ],
      ),
    );
  }
}