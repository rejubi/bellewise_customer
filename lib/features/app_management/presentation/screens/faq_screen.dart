import 'package:flutter/material.dart';

import '../controllers/app_management_controller.dart';

class FaqScreen extends StatelessWidget {

  final AppManagementController controller;

  const FaqScreen({
    super.key,
    required this.controller,
  });

  @override
  Widget build(BuildContext context) {

    return Scaffold(
      appBar: AppBar(
        title:
        const Text("Frequently Asked Questions"),
      ),

      body: AnimatedBuilder(
        animation: controller,
        builder: (
            context,
            child,
            ) {

          if (controller.faqs.isEmpty) {
            return const Center(
              child: Text(
                "No FAQs available.",
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
              controller.faqs.length,

              itemBuilder:
                  (context, index) {

                final faq =
                controller.faqs[index];

                return Card(
                  margin:
                  const EdgeInsets.only(
                    bottom: 10,
                  ),

                  child: ExpansionTile(
                    title: Text(
                      faq.question,
                      style:
                      const TextStyle(
                        fontWeight:
                        FontWeight.w600,
                      ),
                    ),

                    children: [

                      Padding(
                        padding:
                        const EdgeInsets.fromLTRB(
                          16,
                          0,
                          16,
                          18,
                        ),

                        child: Align(
                          alignment:
                          Alignment.centerLeft,

                          child: Text(
                            faq.answer,
                            style:
                            const TextStyle(
                              height: 1.6,
                            ),
                          ),
                        ),
                      ),
                    ],
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