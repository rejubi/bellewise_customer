import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';

import '../../../app/theme.dart';

class EmptyOrders extends StatelessWidget {
  const EmptyOrders({
    super.key,
  });

  @override
  Widget build(BuildContext context) {
    return Center(
      child: Padding(
        padding:
        const EdgeInsets.symmetric(
          horizontal: 24,
        ),

        child: Column(
          mainAxisAlignment:
          MainAxisAlignment.center,

          children: [
            Icon(
              Icons.receipt_long_outlined,
              size: 90,
              color: Colors.grey.shade400,
            ),

            const SizedBox(height: 24),

            const Text(
              "No Orders Yet",
              style: TextStyle(
                fontSize: 24,
                fontWeight: FontWeight.bold,
              ),
            ),

            const SizedBox(height: 12),

            Text(
              "Looks like you haven't placed any orders yet.",
              textAlign: TextAlign.center,
              style: TextStyle(
                color: Colors.grey.shade600,
              ),
            ),

            const SizedBox(height: 30),

            SizedBox(
              width: double.infinity,
              child: ElevatedButton(
                style: ElevatedButton.styleFrom(
                  backgroundColor:
                  AppColors.primary,
                  foregroundColor:
                  Colors.white,
                  padding:
                  const EdgeInsets.symmetric(
                    vertical: 15,
                  ),
                ),
                onPressed: () {
                  context.go("/home");
                },
                child: const Text(
                  "Start Shopping",
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }
}