import 'package:flutter/material.dart';

class SingleVendorDialog {
  static Future<bool> show({
    required BuildContext context,
    required String currentVendor,
    required String newVendor,
  }) async {
    final result = await showDialog<bool>(
      context: context,
      barrierDismissible: false,
      builder: (_) {
        return AlertDialog(
          shape: RoundedRectangleBorder(
            borderRadius: BorderRadius.circular(20),
          ),
          title: const Row(
            children: [
              Icon(
                Icons.shopping_cart,
                color: Colors.orange,
              ),
              SizedBox(width: 10),
              Expanded(
                child: Text(
                  "Replace Cart?",
                ),
              ),
            ],
          ),
          content: RichText(
            text: TextSpan(
              style: const TextStyle(
                color: Colors.black87,
                fontSize: 15,
                height: 1.5,
              ),
              children: [
                const TextSpan(
                  text:
                  "Your cart already contains items from\n\n",
                ),
                TextSpan(
                  text: currentVendor,
                  style: const TextStyle(
                    fontWeight: FontWeight.bold,
                  ),
                ),
                const TextSpan(
                  text:
                  ".\n\nBelleWise only allows items from one restaurant in a single order.\n\nIf you continue, your current cart will be cleared and replaced with items from\n\n",
                ),
                TextSpan(
                  text: newVendor,
                  style: const TextStyle(
                    fontWeight: FontWeight.bold,
                  ),
                ),
                const TextSpan(text: "."),
              ],
            ),
          ),
          actions: [
            TextButton(
              onPressed: () {
                Navigator.pop(context, false);
              },
              child: const Text("Cancel"),
            ),
            FilledButton(
              onPressed: () {
                Navigator.pop(context, true);
              },
              child: const Text("Clear Cart"),
            ),
          ],
        );
      },
    );

    return result ?? false;
  }
}