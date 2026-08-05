import 'package:flutter/material.dart';

import '../../../app/theme.dart';

class CheckoutSummary extends StatelessWidget {
  final double subtotal;
  final double deliveryFee;
  final double serviceFee;
  final double total;

  const CheckoutSummary({
    super.key,
    required this.subtotal,
    required this.deliveryFee,
    required this.serviceFee,
    required this.total,
  });

  Widget _row(
      String title,
      double value, {
        bool bold = false,
      }) {
    return Padding(
      padding:
      const EdgeInsets.symmetric(vertical: 6),
      child: Row(
        children: [
          Expanded(
            child: Text(
              title,
              style: TextStyle(
                fontWeight: bold
                    ? FontWeight.bold
                    : FontWeight.w500,
                fontSize: 15,
              ),
            ),
          ),
          Text(
            "₦${value.toStringAsFixed(0)}",
            style: TextStyle(
              color: bold
                  ? AppColors.primary
                  : Colors.black87,
              fontWeight: bold
                  ? FontWeight.bold
                  : FontWeight.w500,
              fontSize: 15,
            ),
          ),
        ],
      ),
    );
  }

  @override
  Widget build(BuildContext context) {
    return Card(
      elevation: 0,
      shape: RoundedRectangleBorder(
        borderRadius:
        BorderRadius.circular(16),
      ),
      child: Padding(
        padding:
        const EdgeInsets.all(18),
        child: Column(
          children: [
            _row(
              "Subtotal",
              subtotal,
            ),

            _row(
              "Delivery Fee",
              deliveryFee,
            ),

            _row(
              "Service Fee",
              serviceFee,
            ),

            const Padding(
              padding: EdgeInsets.symmetric(
                vertical: 12,
              ),
              child: Divider(),
            ),

            _row(
              "Total",
              total,
              bold: true,
            ),
          ],
        ),
      ),
    );
  }
}