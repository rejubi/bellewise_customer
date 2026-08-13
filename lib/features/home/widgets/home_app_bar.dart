import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';

import '../../../app/theme.dart';

class HomeAppBar extends StatelessWidget {
  final Map<String, dynamic> customer;
  final int notifications;
  final String? locationAddress;
  final bool loadingLocation;

  const HomeAppBar({
    super.key,
    required this.customer,
    required this.notifications,
    this.locationAddress,
    this.loadingLocation = false,
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
    final savedAddress =
    (customer["full_address"] ?? "")
        .toString()
        .trim();

    final gpsAddress =
        locationAddress?.trim() ?? "";

    final address = gpsAddress.isNotEmpty
        ? gpsAddress
        : savedAddress.isNotEmpty
        ? savedAddress
        : "Add delivery address";

    return Container(
      width: double.infinity,
      padding: const EdgeInsets.fromLTRB(
        20,
        20,
        20,
        18,
      ),
      decoration: const BoxDecoration(
        color: AppColors.primary,
        borderRadius: BorderRadius.only(
          bottomLeft: Radius.circular(24),
          bottomRight: Radius.circular(24),
        ),
      ),
      child: Row(
        crossAxisAlignment:
        CrossAxisAlignment.start,
        children: [
          Expanded(
            child: Column(
              crossAxisAlignment:
              CrossAxisAlignment.start,
              children: [
                // GREETING
                Text(
                  greeting(),
                  style: const TextStyle(
                    fontSize: 15,
                    color: Colors.white70,
                  ),
                ),

                const SizedBox(height: 3),

                // CUSTOMER NAME
                Text(
                  customer["first_name"]
                      ?.toString() ??
                      "",
                  style: const TextStyle(
                    fontSize: 25,
                    fontWeight: FontWeight.bold,
                    color: Colors.white,
                  ),
                ),

                const SizedBox(height: 10),

                // LOCATION
                Row(
                  children: [
                    const Icon(
                      Icons.location_on,
                      size: 17,
                      color: Colors.white,
                    ),
                    const SizedBox(width: 5),
                    Expanded(
                      child: Row(
                        children: [
                          Expanded(
                            child: Text(
                              address,
                              maxLines: 1,
                              overflow:
                              TextOverflow.ellipsis,
                              style: const TextStyle(
                                fontSize: 13,
                                color:
                                Colors.white,
                              ),
                            ),
                          ),

                          if (loadingLocation)
                            const Padding(
                              padding:
                              EdgeInsets.only(
                                left: 6,
                              ),
                              child: SizedBox(
                                width: 12,
                                height: 12,
                                child:
                                CircularProgressIndicator(
                                  strokeWidth: 1.5,
                                  color: Colors.white,
                                ),
                              ),
                            ),
                        ],
                      ),
                    ),
                  ],
                ),
              ],
            ),
          ),

          // NOTIFICATIONS
          Material(
            color: Colors.white.withOpacity(.15),
            shape: const CircleBorder(),
            child: InkWell(
              customBorder:
              const CircleBorder(),
              onTap: () {
                context.push(
                  "/profile/notifications",
                );
              },
              child: Padding(
                padding:
                const EdgeInsets.all(10),
                child: Stack(
                  clipBehavior:
                  Clip.none,
                  children: [
                    const Icon(
                      Icons
                          .notifications_outlined,
                      size: 27,
                      color: Colors.white,
                    ),

                    if (notifications > 0)
                      Positioned(
                        right: -4,
                        top: -4,
                        child: Container(
                          constraints:
                          const BoxConstraints(
                            minWidth: 17,
                            minHeight: 17,
                          ),
                          padding:
                          const EdgeInsets
                              .symmetric(
                            horizontal: 3,
                          ),
                          decoration:
                          const BoxDecoration(
                            color: Colors.red,
                            shape:
                            BoxShape.circle,
                          ),
                          alignment:
                          Alignment.center,
                          child: Text(
                            notifications > 99
                                ? "99+"
                                : notifications
                                .toString(),
                            style:
                            const TextStyle(
                              fontSize: 9,
                              fontWeight:
                              FontWeight.bold,
                              color:
                              Colors.white,
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