import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';

import '../../../app/theme.dart';
import '../controllers/order_controller.dart';
import '../models/order_model.dart';
import '../widgets/empty_orders.dart';
import '../widgets/order_card.dart';
import '../widgets/order_loading.dart';

class OrdersScreen extends StatefulWidget {
  const OrdersScreen({
    super.key,
  });

  @override
  State<OrdersScreen> createState() => _OrdersScreenState();
}

class _OrdersScreenState extends State<OrdersScreen> {
  late final OrderController controller;

  @override
  void initState() {
    super.initState();

    controller = OrderController();

    controller.loadOrders();
  }

  @override
  void dispose() {
    controller.dispose();
    super.dispose();
  }

  // ============================================================
  // REFRESH
  // ============================================================

  Future<void> _refresh() async {
    await controller.refreshOrders();
  }

  // ============================================================
  // BACK TO HOME
  // ============================================================

  void _goBackToHome() {
    context.go('/home');
  }

  // ============================================================
  // BUILD
  // ============================================================

  @override
  Widget build(BuildContext context) {
    return PopScope(
      canPop: false,
      onPopInvokedWithResult: (didPop, result) {
        if (didPop) {
          return;
        }

        _goBackToHome();
      },
      child: Scaffold(
        appBar: AppBar(
          title: const Text(
            "My Orders",
          ),

          // Important:
          // Always return to Home instead of exposing the
          // Order Success screen underneath this page.
          leading: IconButton(
            icon: const Icon(
              Icons.arrow_back,
            ),
            onPressed: _goBackToHome,
          ),
        ),

        body: AnimatedBuilder(
          animation: controller,
          builder: (_, __) {
            // ==================================================
            // INITIAL LOADING
            // ==================================================

            if (controller.isLoading &&
                controller.orders.isEmpty) {
              return const OrderLoading();
            }

            // ==================================================
            // ERROR
            // ==================================================

            if (controller.error != null &&
                controller.orders.isEmpty) {
              return Center(
                child: Padding(
                  padding: const EdgeInsets.all(24),
                  child: Column(
                    mainAxisAlignment:
                    MainAxisAlignment.center,
                    children: [
                      const Icon(
                        Icons.error_outline,
                        size: 60,
                        color: Colors.red,
                      ),

                      const SizedBox(height: 16),

                      Text(
                        controller.error!,
                        textAlign: TextAlign.center,
                      ),

                      const SizedBox(height: 20),

                      ElevatedButton(
                        onPressed: () {
                          controller.loadOrders();
                        },
                        child: const Text(
                          "Retry",
                        ),
                      ),
                    ],
                  ),
                ),
              );
            }

            // ==================================================
            // NO ORDERS
            // ==================================================

            if (controller.orders.isEmpty) {
              return const EmptyOrders();
            }

            // ==================================================
            // ORDERS LIST
            // ==================================================

            return RefreshIndicator(
              color: AppColors.primary,
              onRefresh: _refresh,
              child: ListView.separated(
                padding: const EdgeInsets.all(16),
                physics:
                const AlwaysScrollableScrollPhysics(),
                itemCount: controller.orders.length,
                separatorBuilder: (_, __) =>
                const SizedBox(height: 16),
                itemBuilder: (_, index) {
                  final OrderModel order =
                  controller.orders[index];

                  return OrderCard(
                    order: order,
                    onTap: () {
                      context.push(
                        "/orders/${order.id}",
                      );
                    },
                  );
                },
              ),
            );
          },
        ),
      ),
    );
  }
}