import 'package:flutter/material.dart';

import '../../../app/theme.dart';

class CartSummary extends StatelessWidget {
  final double subtotal;

  const CartSummary({
    super.key,
    required this.subtotal,
  });

  @override
  Widget build(BuildContext context) {
    final total = subtotal;

    return Container(
      margin: const EdgeInsets.all(16),
      padding: const EdgeInsets.all(20),
      decoration: BoxDecoration(
        color: Colors.white,
        borderRadius: BorderRadius.circular(18),
        boxShadow: [
          BoxShadow(
            color: Colors.black.withValues(alpha: 0.04),
            blurRadius: 10,
            offset: const Offset(0, 4),
          ),
        ],
      ),
      child: Column(
        children: [
          _row(
            "Subtotal",
            "₦${subtotal.toStringAsFixed(0)}",
          ),

          const SizedBox(height: 14),

          _row(
            "Delivery",
            "Calculated at checkout",
          ),

          const Padding(
            padding: EdgeInsets.symmetric(vertical: 18),
            child: Divider(height: 1),
          ),

          _row(
            "Total",
            "₦${total.toStringAsFixed(0)}",
            bold: true,
          ),
        ],
      ),
    );
  }

  Widget _row(
      String title,
      String value, {
        bool bold = false,
      }) {
    return Row(
      children: [
        Expanded(
          child: Text(
            title,
            style: TextStyle(
              fontSize: 15,
              fontWeight:
              bold ? FontWeight.bold : FontWeight.w500,
            ),
          ),
        ),
        Text(
          value,
          style: TextStyle(
            fontSize: 16,
            color: bold
                ? AppColors.primary
                : Colors.black87,
            fontWeight:
            bold ? FontWeight.bold : FontWeight.w500,
          ),
        ),
      ],
    );
  }
}