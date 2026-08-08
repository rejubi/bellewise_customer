import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';

import '../../../app/theme.dart';

class OrderSuccessScreen extends StatelessWidget {
  final String publicId;

  const OrderSuccessScreen({
    super.key,
    required this.publicId,
  });

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: AppColors.background,

      body: SafeArea(
        child: Center(
          child: SingleChildScrollView(
            padding: const EdgeInsets.all(24),

            child: Column(
              mainAxisAlignment: MainAxisAlignment.center,

              children: [
                Container(
                  width: 120,
                  height: 120,

                  decoration: BoxDecoration(
                    color: Colors.green.withOpacity(.12),
                    shape: BoxShape.circle,
                  ),

                  child: const Icon(
                    Icons.check_circle,
                    size: 80,
                    color: Colors.green,
                  ),
                ),

                const SizedBox(height: 32),

                const Text(
                  "Order Placed!",
                  style: TextStyle(
                    fontSize: 30,
                    fontWeight: FontWeight.bold,
                  ),
                ),

                const SizedBox(height: 12),

                Text(
                  "Your order has been placed successfully.\n"
                      "You can now track its progress in real time.",
                  textAlign: TextAlign.center,
                  style: TextStyle(
                    color: Colors.grey.shade700,
                    fontSize: 16,
                  ),
                ),

                const SizedBox(height: 32),

                Container(
                  width: double.infinity,
                  padding: const EdgeInsets.all(18),

                  decoration: BoxDecoration(
                    color: Colors.white,
                    borderRadius: BorderRadius.circular(16),
                  ),

                  child: Column(
                    children: [
                      const Text(
                        "Order Number",
                        style: TextStyle(
                          color: Colors.grey,
                        ),
                      ),

                      const SizedBox(height: 8),

                      Text(
                        publicId,
                        style: const TextStyle(
                          fontSize: 24,
                          fontWeight: FontWeight.bold,
                          color: AppColors.primary,
                        ),
                      ),
                    ],
                  ),
                ),

                const SizedBox(height: 40),

                SizedBox(
                  width: double.infinity,

                  child: FilledButton.icon(
                    icon: const Icon(
                      Icons.receipt_long_outlined,
                    ),

                    style: FilledButton.styleFrom(
                      backgroundColor: AppColors.primary,
                      padding: const EdgeInsets.symmetric(
                        vertical: 16,
                      ),
                    ),

                    onPressed: () {
                      context.push("/orders");
                    },

                    label: const Text(
                      "View My Orders",
                    ),
                  ),
                ),

                const SizedBox(height: 16),

                SizedBox(
                  width: double.infinity,

                  child: OutlinedButton.icon(
                    icon: const Icon(
                      Icons.home_outlined,
                    ),

                    style: OutlinedButton.styleFrom(
                      padding: const EdgeInsets.symmetric(
                        vertical: 16,
                      ),
                    ),

                    onPressed: () {
                      context.go("/home");
                    },

                    label: const Text(
                      "Back to Home",
                    ),
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