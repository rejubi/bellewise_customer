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
    // ==========================================================
    // CURRENT SELLING PRICE
    // ==========================================================

    final currentPrice =
        item.currentPrice;

    // ==========================================================
    // ITEM TOTAL
    // ==========================================================
    //
    // This is the UI calculation for displaying
    // the current selling price × quantity.
    //
    // The actual order total remains controlled
    // by the backend.
    // ==========================================================

    final total =
        currentPrice * item.quantity;

    return Card(
      elevation: 1,

      margin:
      const EdgeInsets.symmetric(
        horizontal: 16,
        vertical: 6,
      ),

      shape:
      RoundedRectangleBorder(
        borderRadius:
        BorderRadius.circular(14),
      ),

      child: Padding(
        padding:
        const EdgeInsets.all(10),

        child: Row(
          children: [
            // ==================================================
            // PRODUCT IMAGE
            // ==================================================

            ClipRRect(
              borderRadius:
              BorderRadius.circular(10),

              child: item.image != null &&
                  item.image!.isNotEmpty
                  ? Image.network(
                item.image!,
                width: 70,
                height: 70,
                fit: BoxFit.cover,

                errorBuilder:
                    (
                    context,
                    error,
                    stackTrace,
                    ) {
                  return Container(
                    width: 70,
                    height: 70,
                    color:
                    Colors.grey.shade200,
                    child:
                    const Icon(
                      Icons.fastfood,
                      color: Colors.grey,
                    ),
                  );
                },
              )
                  : Container(
                width: 70,
                height: 70,
                color:
                Colors.grey.shade200,
                child:
                const Icon(
                  Icons.fastfood,
                  color: Colors.grey,
                ),
              ),
            ),

            const SizedBox(width: 14),

            // ==================================================
            // PRODUCT INFORMATION
            // ==================================================

            Expanded(
              child: Column(
                crossAxisAlignment:
                CrossAxisAlignment.start,

                children: [
                  Text(
                    item.name,

                    maxLines: 1,
                    overflow:
                    TextOverflow.ellipsis,

                    style:
                    const TextStyle(
                      fontSize: 16,
                      fontWeight:
                      FontWeight.bold,
                    ),
                  ),

                  const SizedBox(height: 6),

                  // ==================================================
                  // QUANTITY × CURRENT PRICE
                  // ==================================================

                  Row(
                    children: [
                      Text(
                        "${item.quantity} × ₦${currentPrice.toStringAsFixed(0)}",

                        style: TextStyle(
                          color:
                          Colors.grey
                              .shade600,
                          fontSize: 14,
                        ),
                      ),

                      if (item.hasDiscount) ...[
                        const SizedBox(width: 6),

                        Text(
                          "₦${item.price.toStringAsFixed(0)}",

                          style:
                          const TextStyle(
                            color:
                            Colors.grey,
                            fontSize: 12,
                            decoration:
                            TextDecoration
                                .lineThrough,
                            decorationColor:
                            Colors.grey,
                          ),
                        ),
                      ],
                    ],
                  ),
                ],
              ),
            ),

            const SizedBox(width: 8),

            // ==================================================
            // CURRENT ITEM TOTAL
            // ==================================================

            Text(
              "₦${total.toStringAsFixed(0)}",

              style:
              const TextStyle(
                color:
                AppColors.primary,
                fontWeight:
                FontWeight.bold,
                fontSize: 16,
              ),
            ),
          ],
        ),
      ),
    );
  }
}