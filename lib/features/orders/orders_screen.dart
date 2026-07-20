import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

import 'providers/order_provider.dart';
import 'order_details_screen.dart';

class OrdersScreen extends ConsumerWidget {
  const OrdersScreen({super.key});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final orders = ref.watch(ordersProvider);

    return Scaffold(
      backgroundColor: Colors.grey.shade100,

      appBar: AppBar(
        title: const Text("My Orders"),
        centerTitle: true,
      ),

      body: orders.isEmpty
          ? const Center(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [

            Icon(
              Icons.receipt_long,
              size: 90,
              color: Colors.grey,
            ),

            SizedBox(height: 20),

            Text(
              "No orders yet",
              style: TextStyle(
                fontSize: 22,
                fontWeight: FontWeight.bold,
              ),
            ),

            SizedBox(height: 10),

            Text(
              "Your completed orders will appear here.",
              style: TextStyle(
                color: Colors.grey,
              ),
            ),
          ],
        ),
      )

          : ListView.builder(
        padding: const EdgeInsets.all(16),
        itemCount: orders.length,

        itemBuilder: (context, index) {

          final order = orders[index];

          return GestureDetector(
            onTap: () {
              Navigator.push(
                context,
                MaterialPageRoute(
                  builder: (_) => OrderDetailsScreen(
                    order: order,
                  ),
                ),
              );
            },

            child: Card(
              elevation: 4,
              margin: const EdgeInsets.only(bottom: 16),

              shape: RoundedRectangleBorder(
                borderRadius: BorderRadius.circular(18),
              ),

              child: Padding(
                padding: const EdgeInsets.all(16),

                child: Row(
                  children: [

                    ClipRRect(
                      borderRadius: BorderRadius.circular(12),

                      child: Image.asset(
                        order.image,
                        width: 80,
                        height: 80,
                        fit: BoxFit.cover,
                      ),
                    ),

                    const SizedBox(width: 16),

                    Expanded(
                      child: Column(
                        crossAxisAlignment:
                        CrossAxisAlignment.start,

                        children: [

                          Text(
                            order.vendor,
                            style: const TextStyle(
                              fontSize: 18,
                              fontWeight: FontWeight.bold,
                            ),
                          ),

                          const SizedBox(height: 6),

                          Text(
                            "₦${order.total.toStringAsFixed(0)}",
                            style: const TextStyle(
                              color: Color(0xFFF57C00),
                              fontWeight: FontWeight.bold,
                              fontSize: 17,
                            ),
                          ),

                          const SizedBox(height: 6),

                          Text(
                            "${order.date.day}/${order.date.month}/${order.date.year}",
                            style: const TextStyle(
                              color: Colors.grey,
                            ),
                          ),
                        ],
                      ),
                    ),

                    Column(
                      children: [

                        Container(
                          padding: const EdgeInsets.symmetric(
                            horizontal: 12,
                            vertical: 8,
                          ),

                          decoration: BoxDecoration(
                            color: Colors.orange.shade100,
                            borderRadius:
                            BorderRadius.circular(30),
                          ),

                          child: Text(
                            order.status,
                            style: const TextStyle(
                              color: Color(0xFFF57C00),
                              fontWeight: FontWeight.bold,
                            ),
                          ),
                        ),

                        const SizedBox(height: 12),

                        const Icon(
                          Icons.arrow_forward_ios,
                          color: Colors.grey,
                          size: 16,
                        ),
                      ],
                    ),
                  ],
                ),
              ),
            ),
          );
        },
      ),
    );
  }
}