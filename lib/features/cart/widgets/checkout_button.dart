import 'package:flutter/material.dart';

import '../../../app/theme.dart';

class CheckoutButton extends StatelessWidget {
  final VoidCallback? onPressed;

  const CheckoutButton({
    super.key,
    required this.onPressed,
  });

  @override
  Widget build(BuildContext context) {
    final bool enabled = onPressed != null;

    return SafeArea(
      top: false,
      child: Container(
        padding: const EdgeInsets.fromLTRB(
          16,
          12,
          16,
          16,
        ),
        decoration: BoxDecoration(
          color: Colors.white,
          boxShadow: [
            BoxShadow(
              color: Colors.black.withValues(alpha: 0.06),
              blurRadius: 12,
              offset: const Offset(0, -2),
            ),
          ],
        ),
        child: SizedBox(
          width: double.infinity,
          height: 56,
          child: ElevatedButton(
            onPressed: onPressed,
            style: ElevatedButton.styleFrom(
              backgroundColor: enabled
                  ? AppColors.primary
                  : Colors.grey.shade300,
              foregroundColor: enabled
                  ? Colors.white
                  : Colors.grey.shade600,
              disabledBackgroundColor:
              Colors.grey.shade300,
              disabledForegroundColor:
              Colors.grey.shade600,
              elevation: 0,
              shape: RoundedRectangleBorder(
                borderRadius:
                BorderRadius.circular(14),
              ),
            ),
            child: Row(
              mainAxisAlignment:
              MainAxisAlignment.center,
              children: [
                Icon(
                  enabled
                      ? Icons.shopping_bag_outlined
                      : Icons.store_mall_directory_outlined,
                ),

                const SizedBox(width: 10),

                Text(
                  enabled
                      ? "Proceed to Checkout"
                      : "Vendor Currently Closed",
                  style: const TextStyle(
                    fontSize: 16,
                    fontWeight: FontWeight.w600,
                  ),
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }
}