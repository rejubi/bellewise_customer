import 'package:flutter/material.dart';

import '../controllers/app_management_controller.dart';

class AnnouncementsScreen
    extends StatelessWidget {

  final AppManagementController controller;

  const AnnouncementsScreen({
    super.key,
    required this.controller,
  });

  @override
  Widget build(BuildContext context) {

    return Scaffold(
      appBar: AppBar(
        title:
        const Text("Announcements"),
      ),

      body: AnimatedBuilder(
        animation: controller,
        builder: (
            context,
            child,
            ) {

          if (controller.announcements.isEmpty) {
            return const Center(
              child: Text(
                "No announcements available.",
              ),
            );
          }

          return RefreshIndicator(
            onRefresh:
            controller.loadAll,

            child: ListView.builder(
              physics:
              const AlwaysScrollableScrollPhysics(),

              padding:
              const EdgeInsets.all(16),

              itemCount:
              controller.announcements.length,

              itemBuilder:
                  (context, index) {

                final announcement =
                controller
                    .announcements[index];

                return Card(
                  margin:
                  const EdgeInsets.only(
                    bottom: 14,
                  ),

                  child: Padding(
                    padding:
                    const EdgeInsets.all(18),

                    child: Column(
                      crossAxisAlignment:
                      CrossAxisAlignment.start,

                      children: [

                        Row(
                          crossAxisAlignment:
                          CrossAxisAlignment.start,

                          children: [

                            const Icon(
                              Icons.campaign_outlined,
                            ),

                            const SizedBox(
                              width: 10,
                            ),

                            Expanded(
                              child: Text(
                                announcement.title,
                                style:
                                const TextStyle(
                                  fontSize: 17,
                                  fontWeight:
                                  FontWeight.bold,
                                ),
                              ),
                            ),
                          ],
                        ),

                        const SizedBox(
                          height: 12,
                        ),

                        Text(
                          announcement.message,
                          style:
                          const TextStyle(
                            height: 1.6,
                          ),
                        ),
                      ],
                    ),
                  ),
                );
              },
            ),
          );
        },
      ),
    );
  }
}