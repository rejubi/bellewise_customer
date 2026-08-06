import 'package:flutter/material.dart';

import '../../../app/theme.dart';
import '../../../core/services/location_service.dart';

class AddressCard extends StatelessWidget {
  final String? address;
  final VoidCallback? onChange;

  const AddressCard({
    super.key,
    this.address,
    this.onChange,
  });

  @override
  Widget build(BuildContext context) {
    final gpsAddress =
        LocationService.currentAddress?.trim() ?? "";

    final savedAddress = address?.trim() ?? "";

    final displayAddress = gpsAddress.isNotEmpty
        ? gpsAddress
        : savedAddress.isNotEmpty
        ? savedAddress
        : "No delivery address available";

    return Card(
      elevation: 0,
      margin: EdgeInsets.zero,
      shape: RoundedRectangleBorder(
        borderRadius: BorderRadius.circular(14),
      ),
      child: Padding(
        padding: const EdgeInsets.symmetric(
          horizontal: 14,
          vertical: 10,
        ),
        child: Column(
          crossAxisAlignment:
          CrossAxisAlignment.start,
          children: [
            Row(
              children: [
                const Icon(
                  Icons.location_on,
                  color: Colors.orange,
                  size: 18,
                ),
                const SizedBox(width: 6),
                const Expanded(
                  child: Text(
                    "Delivery Address",
                    style: TextStyle(
                      fontSize: 15,
                      fontWeight: FontWeight.w600,
                    ),
                  ),
                ),
                TextButton(
                  onPressed: onChange,
                  style: TextButton.styleFrom(
                    padding: EdgeInsets.zero,
                    minimumSize: const Size(55, 28),
                    tapTargetSize:
                    MaterialTapTargetSize
                        .shrinkWrap,
                  ),
                  child: const Text(
                    "Change",
                    style: TextStyle(
                      fontSize: 13,
                    ),
                  ),
                ),
              ],
            ),

            const SizedBox(height: 8),

            Container(
              width: double.infinity,
              padding: const EdgeInsets.symmetric(
                horizontal: 10,
                vertical: 8,
              ),
              decoration: BoxDecoration(
                color: AppColors.background,
                borderRadius:
                BorderRadius.circular(10),
                border: Border.all(
                  color: Colors.grey.shade300,
                ),
              ),
              child: Row(
                crossAxisAlignment:
                CrossAxisAlignment.start,
                children: [
                  const Icon(
                    Icons.place_outlined,
                    size: 16,
                    color: AppColors.primary,
                  ),
                  const SizedBox(width: 8),
                  Expanded(
                    child: Text(
                      displayAddress,
                      maxLines: 2,
                      overflow:
                      TextOverflow.ellipsis,
                      style: const TextStyle(
                        fontSize: 13,
                        height: 1.3,
                      ),
                    ),
                  ),
                ],
              ),
            ),
          ],
        ),
      ),
    );
  }
}