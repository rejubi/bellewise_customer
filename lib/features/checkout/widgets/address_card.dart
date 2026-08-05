import 'package:flutter/material.dart';

class AddressCard extends StatelessWidget {
  final TextEditingController controller;

  const AddressCard({
    super.key,
    required this.controller,
  });

  @override
  Widget build(BuildContext context) {
    return Card(
      elevation: 0,
      shape: RoundedRectangleBorder(
        borderRadius: BorderRadius.circular(16),
      ),
      child: Padding(
        padding: const EdgeInsets.all(18),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            const Row(
              children: [
                Icon(
                  Icons.location_on,
                  color: Colors.orange,
                ),
                SizedBox(width: 8),
                Text(
                  "Delivery Address",
                  style: TextStyle(
                    fontWeight: FontWeight.bold,
                    fontSize: 17,
                  ),
                ),
              ],
            ),

            const SizedBox(height: 16),

            TextFormField(
              controller: controller,
              maxLines: 2,
              decoration: const InputDecoration(
                hintText: "Enter delivery address",
                border: OutlineInputBorder(),
              ),
              validator: (value) {
                if (value == null ||
                    value.trim().isEmpty) {
                  return "Delivery address is required";
                }

                return null;
              },
            ),

            const SizedBox(height: 12),

            OutlinedButton.icon(
              onPressed: () {
                // Map picker (next version)
              },
              icon: const Icon(Icons.map_outlined),
              label: const Text("Choose on Map"),
            ),
          ],
        ),
      ),
    );
  }
}