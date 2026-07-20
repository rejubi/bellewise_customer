import 'package:flutter/material.dart';

import '../checkout/track_order_screen.dart';
import 'models/order_model.dart';

class OrderDetailsScreen extends StatelessWidget {
  final OrderModel order;

  const OrderDetailsScreen({
    super.key,
    required this.order,
  });

  @override
  Widget build(BuildContext context) {
    final subtotal = order.total - 1000;

    return Scaffold(
      backgroundColor: Colors.grey.shade100,

      appBar: AppBar(
        title: const Text("Order Details"),
        centerTitle: true,
      ),

      body: SingleChildScrollView(
        padding: const EdgeInsets.all(20),

        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,

          children: [

            Card(
              shape: RoundedRectangleBorder(
                borderRadius: BorderRadius.circular(18),
              ),

              child: Padding(
                padding: const EdgeInsets.all(18),

                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,

                  children: [

                    Text(
                      "Order #BW-${order.date.millisecondsSinceEpoch.toString().substring(7)}",
                      style: const TextStyle(
                        fontWeight: FontWeight.bold,
                        fontSize: 18,
                      ),
                    ),

                    const SizedBox(height: 15),

                    Text(
                      order.vendor,
                      style: const TextStyle(
                        fontSize: 22,
                        fontWeight: FontWeight.bold,
                      ),
                    ),

                    const SizedBox(height: 8),

                    Text(
                      "${order.date.day}/${order.date.month}/${order.date.year}",
                      style: const TextStyle(
                        color: Colors.grey,
                      ),
                    ),

                    const SizedBox(height: 20),

                    Row(
                      children: [

                        const Text(
                          "Status",
                          style: TextStyle(
                            fontWeight: FontWeight.bold,
                          ),
                        ),

                        const Spacer(),

                        Container(
                          padding: const EdgeInsets.symmetric(
                            horizontal: 14,
                            vertical: 8,
                          ),

                          decoration: BoxDecoration(
                            color: Colors.orange.shade100,
                            borderRadius: BorderRadius.circular(30),
                          ),

                          child: Text(
                            order.status,
                            style: const TextStyle(
                              color: Color(0xFFF57C00),
                              fontWeight: FontWeight.bold,
                            ),
                          ),
                        ),
                      ],
                    ),
                  ],
                ),
              ),
            ),

            const SizedBox(height: 25),

            const Text(
              "Items Ordered",
              style: TextStyle(
                fontSize: 20,
                fontWeight: FontWeight.bold,
              ),
            ),

            const SizedBox(height: 15),

            Card(
              child: Column(
                children: const [

                  ListTile(
                    leading: Icon(Icons.restaurant),
                    title: Text("Jollof Rice"),
                    trailing: Text("x2"),
                  ),

                  Divider(height: 1),

                  ListTile(
                    leading: Icon(Icons.lunch_dining),
                    title: Text("Chicken"),
                    trailing: Text("x1"),
                  ),

                  Divider(height: 1),

                  ListTile(
                    leading: Icon(Icons.local_drink),
                    title: Text("Coke"),
                    trailing: Text("x1"),
                  ),
                ],
              ),
            ),

            const SizedBox(height: 25),

            const Text(
              "Delivery Address",
              style: TextStyle(
                fontWeight: FontWeight.bold,
                fontSize: 20,
              ),
            ),

            const SizedBox(height: 12),

            const Card(
              child: ListTile(
                leading: Icon(
                  Icons.location_on,
                  color: Color(0xFFF57C00),
                ),
                title: Text("Home"),
                subtitle: Text("Gwarinpa, Abuja"),
              ),
            ),

            const SizedBox(height: 25),

            const Text(
              "Payment",
              style: TextStyle(
                fontWeight: FontWeight.bold,
                fontSize: 20,
              ),
            ),

            const SizedBox(height: 12),

            const Card(
              child: ListTile(
                leading: Icon(
                  Icons.payments,
                  color: Color(0xFFF57C00),
                ),
                title: Text("Cash on Delivery"),
              ),
            ),

            const SizedBox(height: 25),

            const Text(
              "Payment Summary",
              style: TextStyle(
                fontSize: 20,
                fontWeight: FontWeight.bold,
              ),
            ),

            const SizedBox(height: 15),

            Card(
              child: Padding(
                padding: const EdgeInsets.all(18),

                child: Column(
                  children: [

                    _row(
                      "Subtotal",
                      "₦${subtotal.toStringAsFixed(0)}",
                    ),

                    const SizedBox(height: 10),

                    _row(
                      "Delivery Fee",
                      "₦800",
                    ),

                    const SizedBox(height: 10),

                    _row(
                      "Service Fee",
                      "₦200",
                    ),

                    const Divider(height: 30),

                    _row(
                      "Total",
                      "₦${order.total.toStringAsFixed(0)}",
                      true,
                    ),
                  ],
                ),
              ),
            ),

            const SizedBox(height: 30),

            SizedBox(
              width: double.infinity,
              height: 56,

              child: ElevatedButton(
                style: ElevatedButton.styleFrom(
                  backgroundColor: const Color(0xFFF57C00),
                  foregroundColor: Colors.white,
                ),

                onPressed: () {
                  Navigator.push(
                    context,
                    MaterialPageRoute(
                      builder: (_) => const TrackOrderScreen(),
                    ),
                  );
                },

                child: const Text(
                  "Track Order",
                  style: TextStyle(
                    fontSize: 18,
                    fontWeight: FontWeight.bold,
                  ),
                ),
              ),
            ),

            const SizedBox(height: 15),

            SizedBox(
              width: double.infinity,
              height: 56,

              child: OutlinedButton(
                onPressed: () {
                  Navigator.pop(context);
                },

                child: const Text(
                  "Reorder",
                  style: TextStyle(
                    fontSize: 18,
                  ),
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }

  static Widget _row(
      String title,
      String value, [
        bool total = false,
      ]) {
    return Row(
      children: [

        Text(
          title,
          style: TextStyle(
            fontSize: total ? 18 : 16,
            fontWeight:
            total ? FontWeight.bold : FontWeight.normal,
          ),
        ),

        const Spacer(),

        Text(
          value,
          style: TextStyle(
            fontSize: total ? 20 : 16,
            fontWeight:
            total ? FontWeight.bold : FontWeight.normal,
            color: total
                ? const Color(0xFFF57C00)
                : Colors.black,
          ),
        ),
      ],
    );
  }
}