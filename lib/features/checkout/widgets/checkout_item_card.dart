import 'package:flutter/material.dart';

import '../../../app/theme.dart';
import '../../cart/models/cart_item_model.dart';

class CheckoutItemCard extends StatelessWidget {
  final CartItemModel item;

  const CheckoutItemCard({
    super.key,
    required this.item,
  });

  @override
  Widget build(BuildContext context) {
    final total = item.price * item.quantity;

    return Card(
      elevation: 1,
      margin: const EdgeInsets.symmetric(
        horizontal: 16,
        vertical: 6,
      ),
      shape: RoundedRectangleBorder(
        borderRadius: BorderRadius.circular(14),
      ),
      child: Padding(
        padding: const EdgeInsets.all(10),
        child: Row(
          children: [
            ClipRRect(
              borderRadius: BorderRadius.circular(10),
              child: item.image != null
                  ? Image.network(
                item.image!,
                width: 70,
                height: 70,
                fit: BoxFit.cover,
              )
                  : Container(
                width: 70,
                height: 70,
                color: Colors.grey.shade200,
                child: const Icon(
                  Icons.fastfood,
                  color: Colors.grey,
                ),
              ),
            ),

            const SizedBox(width: 14),

            Expanded(
              child: Column(
                crossAxisAlignment:
                CrossAxisAlignment.start,
                children: [
                  Text(
                    item.name,
                    style: const TextStyle(
                      fontSize: 16,
                      fontWeight:
                      FontWeight.bold,
                    ),
                  ),

                  const SizedBox(height: 6),

                  Text(
                    "${item.quantity} × ₦${item.price.toStringAsFixed(0)}",
                    style: TextStyle(
                      color: Colors.grey.shade600,
                      fontSize: 14,
                    ),
                  ),
                ],
              ),
            ),

            Text(
              "₦${total.toStringAsFixed(0)}",
              style: const TextStyle(
                color: AppColors.primary,
                fontWeight: FontWeight.bold,
                fontSize: 16,
              ),
            ),
          ],
        ),
      ),
    );
  }
}