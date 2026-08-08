import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';

import '../../../core/services/location_service.dart';

class HomeAppBar extends StatelessWidget {
  final Map<String, dynamic> customer;
  final int notifications;

  const HomeAppBar({
    super.key,
    required this.customer,
    required this.notifications,
  });

  String greeting() {
    final hour = DateTime.now().hour;

    if (hour < 12) {
      return "Good Morning";
    }

    if (hour < 17) {
      return "Good Afternoon";
    }

    return "Good Evening";
  }

  @override
  Widget build(BuildContext context) {
    final gpsAddress =
        LocationService.currentAddress?.trim() ?? "";

    final savedAddress =
    (customer["full_address"] ?? "").toString().trim();

    final address = gpsAddress.isNotEmpty
        ? gpsAddress
        : savedAddress.isNotEmpty
        ? savedAddress
        : "Add delivery address";

    return Padding(
      padding: const EdgeInsets.fromLTRB(20, 20, 20, 0),
      child: Row(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Expanded(
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text(
                  greeting(),
                  style: const TextStyle(
                    fontSize: 16,
                    color: Colors.grey,
                  ),
                ),

                const SizedBox(height: 4),

                Text(
                  customer["first_name"] ?? "",
                  style: const TextStyle(
                    fontSize: 24,
                    fontWeight: FontWeight.bold,
                  ),
                ),

                const SizedBox(height: 8),

                Row(
                  children: [
                    const Icon(
                      Icons.location_on,
                      size: 16,
                      color: Colors.orange,
                    ),

                    const SizedBox(width: 4),

                    Expanded(
                      child: Text(
                        address,
                        maxLines: 1,
                        overflow: TextOverflow.ellipsis,
                        style: const TextStyle(
                          fontSize: 13,
                          color: Colors.grey,
                        ),
                      ),
                    ),
                  ],
                ),
              ],
            ),
          ),

          // ====================================================
          // NOTIFICATIONS
          // ====================================================

          Material(
            color: Colors.transparent,
            child: InkWell(
              borderRadius: BorderRadius.circular(30),
              onTap: () {
                context.push("/profile/notifications");
              },
              child: Padding(
                padding: const EdgeInsets.all(6),
                child: Stack(
                  clipBehavior: Clip.none,
                  children: [
                    const Icon(
                      Icons.notifications_outlined,
                      size: 30,
                    ),

                    if (notifications > 0)
                      Positioned(
                        right: -2,
                        top: -2,
                        child: Container(
                          constraints: const BoxConstraints(
                            minWidth: 16,
                            minHeight: 16,
                          ),
                          padding: const EdgeInsets.symmetric(
                            horizontal: 3,
                          ),
                          decoration: const BoxDecoration(
                            color: Colors.red,
                            shape: BoxShape.circle,
                          ),
                          alignment: Alignment.center,
                          child: Text(
                            notifications > 99
                                ? "99+"
                                : notifications.toString(),
                            style: const TextStyle(
                              fontSize: 9,
                              fontWeight: FontWeight.bold,
                              color: Colors.white,
                            ),
                          ),
                        ),
                      ),
                  ],
                ),
              ),
            ),
          ),
        ],
      ),
    );
  }
}