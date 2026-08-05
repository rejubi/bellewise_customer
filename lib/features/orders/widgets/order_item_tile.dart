import 'package:flutter/material.dart';
import 'package:intl/intl.dart';

import '../../../app/theme.dart';
import '../models/order_item_model.dart';

class OrderItemTile extends StatelessWidget {
  final OrderItemModel item;

  const OrderItemTile({
    super.key,
    required this.item,
  });

  @override
  Widget build(BuildContext context) {
    final currency = NumberFormat.currency(
      locale: "en_NG",
      symbol: "₦",
      decimalDigits: 0,
    );

    return Container(
      padding: const EdgeInsets.all(14),

      decoration: BoxDecoration(
        color: Colors.white,
        borderRadius: BorderRadius.circular(12),

        border: Border.all(
          color: Colors.grey.shade200,
        ),
      ),

      child: Row(
        crossAxisAlignment:
        CrossAxisAlignment.start,

        children: [

          /// Quantity

          Container(
            width: 42,
            height: 42,

            alignment: Alignment.center,

            decoration: BoxDecoration(
              color: AppColors.primary
                  .withOpacity(.12),

              borderRadius:
              BorderRadius.circular(10),
            ),

            child: Text(
              "${item.quantity}×",
              style: const TextStyle(
                fontWeight: FontWeight.bold,
                color: AppColors.primary,
              ),
            ),
          ),

          const SizedBox(width: 14),

          /// Product

          Expanded(
            child: Column(
              crossAxisAlignment:
              CrossAxisAlignment.start,

              children: [

                Text(
                  item.product,
                  style: const TextStyle(
                    fontSize: 16,
                    fontWeight:
                    FontWeight.w600,
                  ),
                ),

                const SizedBox(height: 8),

                Text(
                  "${currency.format(item.price)} each",
                  style: TextStyle(
                    color:
                    Colors.grey.shade600,
                  ),
                ),
              ],
            ),
          ),

          /// Total

          Text(
            currency.format(
              item.total,
            ),
            style: const TextStyle(
              fontWeight: FontWeight.bold,
              fontSize: 16,
            ),
          ),
        ],
      ),
    );
  }
}