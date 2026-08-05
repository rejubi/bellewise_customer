import 'package:flutter/material.dart';

import '../../../app/theme.dart';
import '../models/address_model.dart';

class AddressCard extends StatelessWidget {
  final AddressModel address;
  final VoidCallback onDelete;

  const AddressCard({
    super.key,
    required this.address,
    required this.onDelete,
  });

  @override
  Widget build(BuildContext context) {
    final bool isHome =
        address.title.toUpperCase() == "HOME";

    return Card(
      elevation: 0,
      color: Colors.white,
      margin: EdgeInsets.zero,
      shape: RoundedRectangleBorder(
        borderRadius: BorderRadius.circular(18),
        side: BorderSide(
          color: Colors.grey.shade200,
        ),
      ),
      child: Padding(
        padding: const EdgeInsets.all(18),
        child: Column(
          crossAxisAlignment:
          CrossAxisAlignment.start,
          children: [
            Row(
              children: [
                Container(
                  width: 46,
                  height: 46,
                  decoration: BoxDecoration(
                    color: AppColors.primary.withOpacity(.1),
                    borderRadius:
                    BorderRadius.circular(12),
                  ),
                  child: Icon(
                    isHome
                        ? Icons.home_outlined
                        : Icons.location_on_outlined,
                    color: AppColors.primary,
                  ),
                ),

                const SizedBox(width: 14),

                Expanded(
                  child: Column(
                    crossAxisAlignment:
                    CrossAxisAlignment.start,
                    children: [
                      Text(
                        address.title,
                        style: const TextStyle(
                          fontSize: 17,
                          fontWeight:
                          FontWeight.bold,
                        ),
                      ),

                      if (address.isDefault)
                        Padding(
                          padding:
                          const EdgeInsets.only(
                            top: 4,
                          ),
                          child: Container(
                            padding:
                            const EdgeInsets.symmetric(
                              horizontal: 10,
                              vertical: 4,
                            ),
                            decoration: BoxDecoration(
                              color: AppColors.primary
                                  .withOpacity(.12),
                              borderRadius:
                              BorderRadius.circular(
                                20,
                              ),
                            ),
                            child: const Text(
                              "Default Address",
                              style: TextStyle(
                                color:
                                AppColors.primary,
                                fontSize: 12,
                                fontWeight:
                                FontWeight.w600,
                              ),
                            ),
                          ),
                        ),
                    ],
                  ),
                ),
              ],
            ),

            const SizedBox(height: 18),

            Text(
              address.recipientName,
              style: const TextStyle(
                fontWeight: FontWeight.w600,
                fontSize: 15,
              ),
            ),

            const SizedBox(height: 4),

            Text(
              address.phoneNumber,
              style: TextStyle(
                color: Colors.grey.shade700,
              ),
            ),

            const SizedBox(height: 12),

            Row(
              crossAxisAlignment:
              CrossAxisAlignment.start,
              children: [
                Icon(
                  Icons.place_outlined,
                  size: 18,
                  color: Colors.grey.shade600,
                ),

                const SizedBox(width: 8),

                Expanded(
                  child: Text(
                    address.fullAddress,
                    style: const TextStyle(
                      height: 1.5,
                    ),
                  ),
                ),
              ],
            ),

            if (address.landmark.isNotEmpty) ...[
              const SizedBox(height: 10),

              Row(
                crossAxisAlignment:
                CrossAxisAlignment.start,
                children: [
                  Icon(
                    Icons.flag_outlined,
                    size: 18,
                    color: Colors.grey.shade600,
                  ),

                  const SizedBox(width: 8),

                  Expanded(
                    child: Text(
                      address.landmark,
                    ),
                  ),
                ],
              ),
            ],

            const SizedBox(height: 20),

            Divider(
              color: Colors.grey.shade200,
              height: 1,
            ),

            const SizedBox(height: 10),

            Row(
              mainAxisAlignment:
              MainAxisAlignment.end,
              children: [
                TextButton.icon(
                  onPressed: onDelete,
                  icon: const Icon(
                    Icons.delete_outline,
                    color: Colors.red,
                  ),
                  label: const Text(
                    "Delete",
                    style: TextStyle(
                      color: Colors.red,
                    ),
                  ),
                ),
              ],
            ),
          ],
        ),
      ),
    );
  }
}