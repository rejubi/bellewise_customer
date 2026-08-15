import 'package:flutter/material.dart';

import '../../../../app/theme.dart';
import '../controllers/app_management_controller.dart';
import 'announcements_screen.dart';
import 'app_content_screen.dart';
import 'faq_screen.dart';

class AppManagementScreen
    extends StatefulWidget {
  const AppManagementScreen({
    super.key,
  });

  @override
  State<AppManagementScreen> createState() =>
      _AppManagementScreenState();
}

class _AppManagementScreenState
    extends State<AppManagementScreen> {

  late final AppManagementController
  controller;

  @override
  void initState() {
    super.initState();

    controller =
        AppManagementController();

    controller.loadAll();
  }

  @override
  void dispose() {
    controller.dispose();
    super.dispose();
  }

  void openContent(
      String title,
      String slug,
      ) {
    Navigator.of(context).push(
      MaterialPageRoute(
        builder: (_) => AppContentScreen(
          title: title,
          slug: slug,
          controller: controller,
        ),
      ),
    );
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: AppColors.background,

      appBar: AppBar(
        title: const Text(
          "BelleWise",
        ),
      ),

      body: AnimatedBuilder(
        animation: controller,
        builder: (
            context,
            child,
            ) {

          if (controller.isLoading) {
            return const Center(
              child:
              CircularProgressIndicator(),
            );
          }

          if (controller.errorMessage != null) {
            return Center(
              child: Padding(
                padding:
                const EdgeInsets.all(24),
                child: Column(
                  mainAxisSize:
                  MainAxisSize.min,
                  children: [

                    const Icon(
                      Icons.cloud_off,
                      size: 48,
                    ),

                    const SizedBox(
                      height: 16,
                    ),

                    Text(
                      controller.errorMessage!,
                      textAlign:
                      TextAlign.center,
                    ),

                    const SizedBox(
                      height: 16,
                    ),

                    ElevatedButton(
                      onPressed:
                      controller.loadAll,
                      child:
                      const Text("Retry"),
                    ),
                  ],
                ),
              ),
            );
          }

          return RefreshIndicator(
            onRefresh:
            controller.loadAll,

            child: ListView(
              padding:
              const EdgeInsets.all(20),

              children: [

                _sectionTile(
                  icon:
                  Icons.privacy_tip_outlined,
                  title:
                  "Privacy Policy",
                  onTap: () => openContent(
                    "Privacy Policy",
                    "privacy-policy",
                  ),
                ),

                _sectionTile(
                  icon:
                  Icons.description_outlined,
                  title:
                  "Terms & Conditions",
                  onTap: () => openContent(
                    "Terms & Conditions",
                    "terms-and-conditions",
                  ),
                ),

                _sectionTile(
                  icon:
                  Icons.support_agent_outlined,
                  title:
                  "Support",
                  onTap: () => openContent(
                    "Support",
                    "support",
                  ),
                ),

                _sectionTile(
                  icon:
                  Icons.info_outline,
                  title:
                  "About BelleWise",
                  onTap: () => openContent(
                    "About BelleWise",
                    "about-bellewise",
                  ),
                ),

                _sectionTile(
                  icon:
                  Icons.contact_page_outlined,
                  title:
                  "Contact Information",
                  onTap: () => openContent(
                    "Contact Information",
                    "contact-information",
                  ),
                ),

                _sectionTile(
                  icon:
                  Icons.miscellaneous_services_outlined,
                  title:
                  "Services",
                  onTap: () => openContent(
                    "Services",
                    "services",
                  ),
                ),

                _sectionTile(
                  icon:
                  Icons.help_outline,
                  title:
                  "Frequently Asked Questions",
                  onTap: () {
                    Navigator.of(context).push(
                      MaterialPageRoute(
                        builder: (_) =>
                            FaqScreen(
                              controller:
                              controller,
                            ),
                      ),
                    );
                  },
                ),

                _sectionTile(
                  icon:
                  Icons.campaign_outlined,
                  title:
                  "Announcements",
                  onTap: () {
                    Navigator.of(context).push(
                      MaterialPageRoute(
                        builder: (_) =>
                            AnnouncementsScreen(
                              controller:
                              controller,
                            ),
                      ),
                    );
                  },
                ),
              ],
            ),
          );
        },
      ),
    );
  }

  Widget _sectionTile({
    required IconData icon,
    required String title,
    required VoidCallback onTap,
  }) {
    return Card(
      margin:
      const EdgeInsets.only(bottom: 12),

      child: ListTile(
        leading: Icon(
          icon,
          color: AppColors.primary,
        ),

        title: Text(
          title,
          style: const TextStyle(
            fontWeight:
            FontWeight.w600,
          ),
        ),

        trailing: const Icon(
          Icons.chevron_right,
        ),

        onTap: onTap,
      ),
    );
  }
}