import 'package:flutter/material.dart';

import '../../../app/theme.dart';
import '../controllers/order_controller.dart';
import '../models/order_model.dart';
import '../widgets/cancel_order_button.dart';
import '../widgets/live_tracking_map.dart';
import '../widgets/order_loading.dart';
import '../widgets/order_timeline.dart';
import '../widgets/tracking_header.dart';

class TrackingScreen extends StatefulWidget {
  final int orderId;

  const TrackingScreen({
    super.key,
    required this.orderId,
  });

  @override
  State<TrackingScreen> createState() =>
      _TrackingScreenState();
}

class _TrackingScreenState extends State<TrackingScreen> {
  late final OrderController controller;

  @override
  void initState() {
    super.initState();

    controller = OrderController();
    controller.startTracking(widget.orderId);
  }

  @override
  void dispose() {
    controller.dispose();
    super.dispose();
  }

  Future<void> _refresh() async {
    await controller.loadOrder(widget.orderId);
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: AppColors.background,
      appBar: AppBar(
        title: const Text("Track Order"),
      ),
      body: SafeArea(
        child: AnimatedBuilder(
          animation: controller,
          builder: (_, __) {
            if (controller.currentOrder == null) {
              return const OrderLoading();
            }

            final OrderModel order =
            controller.currentOrder!;

            return RefreshIndicator(
              color: AppColors.primary,
              onRefresh: _refresh,
              child: ListView(
                physics:
                const AlwaysScrollableScrollPhysics(),
                padding: const EdgeInsets.all(16),
                children: [

                  /// HEADER

                  TrackingHeader(
                    order: order,
                  ),

                  const SizedBox(height: 20),

                  /// LIVE MAP (Only after rider is assigned)

                  if (controller.tracking != null &&
                      controller.tracking!.hasRider) ...[
                    LiveTrackingMap(
                      tracking: controller.tracking!,
                    ),

                    const SizedBox(height: 20),
                  ],

                  /// TRACKING HISTORY

                  Card(
                    elevation: 0,
                    shape: RoundedRectangleBorder(
                      borderRadius:
                      BorderRadius.circular(18),
                    ),
                    child: Padding(
                      padding:
                      const EdgeInsets.all(20),
                      child: Column(
                        crossAxisAlignment:
                        CrossAxisAlignment.start,
                        children: [

                          const Row(
                            children: [
                              Icon(
                                Icons.history,
                                color:
                                AppColors.primary,
                              ),
                              SizedBox(width: 10),
                              Text(
                                "Tracking History",
                                style: TextStyle(
                                  fontSize: 18,
                                  fontWeight:
                                  FontWeight.bold,
                                ),
                              ),
                            ],
                          ),

                          const SizedBox(height: 20),

                          OrderTimeline(
                            currentStatus:
                            order.orderStatus,
                          ),
                        ],
                      ),
                    ),
                  ),

                  const SizedBox(height: 24),

                  /// LIVE UPDATE NOTICE

                  Container(
                    padding:
                    const EdgeInsets.all(18),
                    decoration: BoxDecoration(
                      color: AppColors.primary
                          .withValues(alpha: .08),
                      borderRadius:
                      BorderRadius.circular(18),
                    ),
                    child: Row(
                      children: [
                        const Icon(
                          Icons.sync,
                          color:
                          AppColors.primary,
                        ),
                        const SizedBox(width: 14),
                        Expanded(
                          child: Text(
                            "This page updates automatically every 5 seconds until your order is completed.",
                            style: TextStyle(
                              color:
                              Colors.grey.shade800,
                              height: 1.4,
                            ),
                          ),
                        ),
                      ],
                    ),
                  ),

                  if (order.canCancel) ...[
                    const SizedBox(height: 24),

                    CancelOrderButton(
                      order: order,
                      controller: controller,
                    ),
                  ],

                  const SizedBox(height: 30),
                ],
              ),
            );
          },
        ),
      ),
    );
  }
}