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
        borderRadius: BorderRadius.circular(16),
        side: BorderSide(
          color: Colors.grey.shade200,
        ),
      ),
      child: Padding(
        padding: const EdgeInsets.all(14),
        child: Column(
          crossAxisAlignment:
          CrossAxisAlignment.start,
          children: [
            Row(
              children: [
                Container(
                  width: 40,
                  height: 40,
                  decoration: BoxDecoration(
                    color: AppColors.primary.withOpacity(.1),
                    borderRadius:
                    BorderRadius.circular(10),
                  ),
                  child: Icon(
                    isHome
                        ? Icons.home_outlined
                        : Icons.location_on_outlined,
                    color: AppColors.primary,
                    size: 22,
                  ),
                ),

                const SizedBox(width: 12),

                Expanded(
                  child: Column(
                    crossAxisAlignment:
                    CrossAxisAlignment.start,
                    children: [
                      Text(
                        address.title,
                        style: const TextStyle(
                          fontSize: 16,
                          fontWeight:
                          FontWeight.bold,
                        ),
                      ),

                      if (address.isDefault)
                        Padding(
                          padding:
                          const EdgeInsets.only(
                            top: 3,
                          ),
                          child: Container(
                            padding:
                            const EdgeInsets.symmetric(
                              horizontal: 8,
                              vertical: 3,
                            ),
                            decoration: BoxDecoration(
                              color: AppColors.primary
                                  .withOpacity(.12),
                              borderRadius:
                              BorderRadius.circular(
                                18,
                              ),
                            ),
                            child: const Text(
                              "Default Address",
                              style: TextStyle(
                                color:
                                AppColors.primary,
                                fontSize: 11,
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

            const SizedBox(height: 14),

            Text(
              address.recipientName,
              style: const TextStyle(
                fontWeight: FontWeight.w600,
                fontSize: 14,
              ),
            ),

            const SizedBox(height: 2),

            Text(
              address.phoneNumber,
              style: TextStyle(
                color: Colors.grey.shade700,
                fontSize: 13,
              ),
            ),

            const SizedBox(height: 10),

            Row(
              crossAxisAlignment:
              CrossAxisAlignment.start,
              children: [
                Icon(
                  Icons.place_outlined,
                  size: 16,
                  color: Colors.grey.shade600,
                ),

                const SizedBox(width: 6),

                Expanded(
                  child: Text(
                    address.fullAddress,
                    style: const TextStyle(
                      fontSize: 13,
                      height: 1.35,
                    ),
                  ),
                ),
              ],
            ),

            if (address.landmark.isNotEmpty) ...[
              const SizedBox(height: 8),

              Row(
                crossAxisAlignment:
                CrossAxisAlignment.start,
                children: [
                  Icon(
                    Icons.flag_outlined,
                    size: 16,
                    color: Colors.grey.shade600,
                  ),

                  const SizedBox(width: 6),

                  Expanded(
                    child: Text(
                      address.landmark,
                      style: const TextStyle(
                        fontSize: 13,
                      ),
                    ),
                  ),
                ],
              ),
            ],

            const SizedBox(height: 14),

            Divider(
              color: Colors.grey.shade200,
              height: 1,
            ),

            const SizedBox(height: 6),

            Row(
              mainAxisAlignment:
              MainAxisAlignment.end,
              children: [
                TextButton.icon(
                  onPressed: onDelete,
                  style: TextButton.styleFrom(
                    minimumSize: const Size(0, 34),
                    tapTargetSize:
                    MaterialTapTargetSize
                        .shrinkWrap,
                    padding:
                    const EdgeInsets.symmetric(
                      horizontal: 8,
                    ),
                  ),
                  icon: const Icon(
                    Icons.delete_outline,
                    color: Colors.red,
                    size: 18,
                  ),
                  label: const Text(
                    "Delete",
                    style: TextStyle(
                      color: Colors.red,
                      fontSize: 13,
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