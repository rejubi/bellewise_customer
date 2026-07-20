import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

import '../cart/providers/cart_provider.dart';
import '../orders/models/order_model.dart';
import '../orders/providers/order_provider.dart';
import 'order_confirmed_screen.dart';

class OrderSummaryScreen extends ConsumerWidget {
  final int paymentMethod;

  const OrderSummaryScreen({
    super.key,
    required this.paymentMethod,
  });

  String getPaymentMethod() {
    switch (paymentMethod) {
      case 0:
        return "Cash on Delivery";
      case 1:
        return "Bank Transfer";
      default:
        return "Cash on Delivery";
    }
  }

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final cart = ref.watch(cartProvider);
    final notifier = ref.read(cartProvider.notifier);

    const deliveryFee = 800.0;
    const serviceFee = 200.0;

    final subtotal = notifier.subtotal;
    final total = subtotal + deliveryFee + serviceFee;

    return Scaffold(
      backgroundColor: Colors.grey.shade50,
      appBar: AppBar(
        title: const Text("Review Order"),
        centerTitle: true,
      ),
      body: Padding(
        padding: const EdgeInsets.all(20),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            const Text(
              "Restaurant",
              style: TextStyle(
                fontSize: 18,
                fontWeight: FontWeight.bold,
              ),
            ),

            const SizedBox(height: 8),

            Card(
              shape: RoundedRectangleBorder(
                borderRadius: BorderRadius.circular(16),
              ),
              child: ListTile(
                leading: const Icon(
                  Icons.store,
                  color: Color(0xFFF57C00),
                ),
                title: Text(
                  notifier.currentVendor ?? "Restaurant",
                ),
              ),
            ),

            const SizedBox(height: 20),

            const Text(
              "Items",
              style: TextStyle(
                fontSize: 18,
                fontWeight: FontWeight.bold,
              ),
            ),

            const SizedBox(height: 10),

            Expanded(
              child: ListView.builder(
                itemCount: cart.length,
                itemBuilder: (context, index) {
                  final item = cart[index];

                  return ListTile(
                    leading: CircleAvatar(
                      backgroundImage: AssetImage(item.image),
                    ),
                    title: Text(item.name),
                    subtitle: Text(
                      "${item.quantity} × ₦${item.price.toStringAsFixed(0)}",
                    ),
                    trailing: Text(
                      "₦${item.total.toStringAsFixed(0)}",
                    ),
                  );
                },
              ),
            ),

            const Divider(),

            ListTile(
              contentPadding: EdgeInsets.zero,
              title: const Text("Payment Method"),
              trailing: Text(getPaymentMethod()),
            ),

            ListTile(
              contentPadding: EdgeInsets.zero,
              title: const Text("Subtotal"),
              trailing: Text(
                "₦${subtotal.toStringAsFixed(0)}",
              ),
            ),

            const ListTile(
              contentPadding: EdgeInsets.zero,
              title: Text("Delivery Fee"),
              trailing: Text("₦800"),
            ),

            const ListTile(
              contentPadding: EdgeInsets.zero,
              title: Text("Service Fee"),
              trailing: Text("₦200"),
            ),

            const Divider(),

            ListTile(
              contentPadding: EdgeInsets.zero,
              title: const Text(
                "Total",
                style: TextStyle(
                  fontSize: 20,
                  fontWeight: FontWeight.bold,
                ),
              ),
              trailing: Text(
                "₦${total.toStringAsFixed(0)}",
                style: const TextStyle(
                  fontSize: 22,
                  fontWeight: FontWeight.bold,
                  color: Color(0xFFF57C00),
                ),
              ),
            ),

            const SizedBox(height: 20),

            SizedBox(
              width: double.infinity,
              height: 55,
              child: ElevatedButton(
                style: ElevatedButton.styleFrom(
                  backgroundColor: const Color(0xFFF57C00),
                  foregroundColor: Colors.white,
                  shape: RoundedRectangleBorder(
                    borderRadius: BorderRadius.circular(16),
                  ),
                ),
                onPressed: () {

                  ref.read(ordersProvider.notifier).addOrder(

                    OrderModel(
                      vendor: notifier.currentVendor ?? "Restaurant",
                      image: cart.first.image,
                      total: total,
                      status: "Preparing",
                      date: DateTime.now(),
                    ),

                  );

                  notifier.clearCart();

                  Navigator.pushReplacement(
                    context,
                    MaterialPageRoute(
                      builder: (_) => const OrderConfirmedScreen(),
                    ),
                  );
                },
                child: const Text(
                  "Place Order",
                  style: TextStyle(
                    fontSize: 18,
                    fontWeight: FontWeight.bold,
                  ),
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }
}