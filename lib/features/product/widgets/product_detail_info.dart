import 'package:flutter/material.dart';

import '../../../app/theme.dart';
import '../models/product_detail_model.dart';

class ProductDetailInfo extends StatelessWidget {
  final ProductDetailModel product;

  const ProductDetailInfo({
    super.key,
    required this.product,
  });

  @override
  Widget build(BuildContext context) {
    final bool hasDiscount = product.discountPrice != null;

    return Container(
      decoration: const BoxDecoration(
        color: Colors.white,
        borderRadius: BorderRadius.vertical(
          top: Radius.circular(30),
        ),
      ),
      child: Padding(
        padding: const EdgeInsets.fromLTRB(
          22,
          24,
          22,
          30,
        ),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [

            /// Vendor
            Row(
              children: [
                CircleAvatar(
                  radius: 22,
                  backgroundImage: product.vendorLogo.isNotEmpty
                      ? NetworkImage(product.vendorLogo)
                      : null,
                  child: product.vendorLogo.isEmpty
                      ? const Icon(Icons.storefront)
                      : null,
                ),

                const SizedBox(width: 14),

                Expanded(
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [

                      Text(
                        product.vendorName,
                        style: const TextStyle(
                          fontSize: 17,
                          fontWeight: FontWeight.bold,
                        ),
                      ),

                      const SizedBox(height: 3),

                      Row(
                        children: [

                          const Icon(
                            Icons.star,
                            color: Colors.amber,
                            size: 16,
                          ),

                          const SizedBox(width: 4),

                          Text(
                            product.vendorRating.toStringAsFixed(1),
                          ),

                          const SizedBox(width: 10),

                          Text(
                            "${product.deliveryTime} mins",
                            style: const TextStyle(
                              color: Colors.grey,
                            ),
                          ),
                        ],
                      ),
                    ],
                  ),
                ),
              ],
            ),

            const SizedBox(height: 24),

            Text(
              product.name,
              style: const TextStyle(
                fontSize: 30,
                fontWeight: FontWeight.bold,
              ),
            ),

            const SizedBox(height: 18),

            if (hasDiscount)
              Row(
                children: [
                  Text(
                    "₦${product.discountPrice!.toStringAsFixed(0)}",
                    style: const TextStyle(
                      color: AppColors.primary,
                      fontWeight: FontWeight.bold,
                      fontSize: 34,
                    ),
                  ),

                  const SizedBox(width: 10),

                  Text(
                    "₦${product.price.toStringAsFixed(0)}",
                    style: const TextStyle(
                      decoration: TextDecoration.lineThrough,
                      color: Colors.grey,
                      fontSize: 20,
                    ),
                  ),
                ],
              )
            else
              Text(
                "₦${product.price.toStringAsFixed(0)}",
                style: const TextStyle(
                  color: AppColors.primary,
                  fontWeight: FontWeight.bold,
                  fontSize: 34,
                ),
              ),

            const SizedBox(height: 24),

            Wrap(
              spacing: 10,
              runSpacing: 10,
              children: [

                _chip(
                  Icons.schedule,
                  "${product.preparationTime} mins",
                ),

                _chip(
                  Icons.restaurant_menu,
                  product.category,
                ),

                _chip(
                  Icons.delivery_dining,
                  "₦${product.deliveryFee.toStringAsFixed(0)} Delivery",
                ),

                _chip(
                  product.available
                      ? Icons.check_circle
                      : Icons.cancel,
                  product.available
                      ? "Available"
                      : "Unavailable",
                ),
              ],
            ),

            const SizedBox(height: 30),

            const Text(
              "Description",
              style: TextStyle(
                fontSize: 20,
                fontWeight: FontWeight.bold,
              ),
            ),

            const SizedBox(height: 10),

            Text(
              product.description.isEmpty
                  ? "No description available."
                  : product.description,
              style: TextStyle(
                height: 1.7,
                color: Colors.grey.shade700,
              ),
            ),
          ],
        ),
      ),
    );
  }

  Widget _chip(
      IconData icon,
      String text,
      ) {
    return Container(
      padding: const EdgeInsets.symmetric(
        horizontal: 14,
        vertical: 10,
      ),
      decoration: BoxDecoration(
        color: AppColors.primary.withAlpha(20),
        borderRadius: BorderRadius.circular(30),
      ),
      child: Row(
        mainAxisSize: MainAxisSize.min,
        children: [

          Icon(
            icon,
            size: 18,
            color: AppColors.primary,
          ),

          const SizedBox(width: 6),

          Text(
            text,
            style: const TextStyle(
              fontWeight: FontWeight.w600,
            ),
          ),
        ],
      ),
    );
  }
}