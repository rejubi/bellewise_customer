import 'package:flutter/material.dart';

import '../../../app/theme.dart';
import '../models/product_detail_model.dart';

class ProductPrice extends StatelessWidget {
  final ProductDetailModel product;

  const ProductPrice({
    super.key,
    required this.product,
  });

  @override
  Widget build(BuildContext context) {
    if (product.discountPrice != null) {
      return Row(
        children: [
          Text(
            "₦${product.discountPrice}",
            style: const TextStyle(
              fontSize: 26,
              color: AppColors.primary,
              fontWeight: FontWeight.bold,
            ),
          ),
          const SizedBox(width: 10),
          Text(
            "₦${product.price}",
            style: const TextStyle(
              decoration: TextDecoration.lineThrough,
            ),
          ),
        ],
      );
    }

    return Text(
      "₦${product.price}",
      style: const TextStyle(
        fontSize: 26,
        color: AppColors.primary,
        fontWeight: FontWeight.bold,
      ),
    );
  }
}