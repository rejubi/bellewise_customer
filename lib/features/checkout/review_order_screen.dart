import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

import '../cart/providers/cart_provider.dart';
import 'payment_screen.dart';

class ReviewOrderScreen extends ConsumerWidget {
const ReviewOrderScreen({super.key});

@override
Widget build(BuildContext context, WidgetRef ref) {
final cart = ref.watch(cartProvider);
final notifier = ref.read(cartProvider.notifier);

const double deliveryFee = 800;
const double serviceFee = 200;

final subtotal = notifier.subtotal;
final total = subtotal + deliveryFee + serviceFee;

return Scaffold(
backgroundColor: Colors.grey.shade50,

appBar: AppBar(
title: const Text("Review Order"),
centerTitle: true,
),

body: SingleChildScrollView(
padding: const EdgeInsets.all(20),

child: Column(
crossAxisAlignment: CrossAxisAlignment.start,

children: [

const Text(
"Delivery Address",
style: TextStyle(
fontSize: 20,
fontWeight: FontWeight.bold,
),
),

const SizedBox(height: 12),

Card(
shape: RoundedRectangleBorder(
borderRadius: BorderRadius.circular(16),
),
child: const ListTile(
leading: Icon(
Icons.location_on,
color: Color(0xFFF57C00),
),
title: Text("Home"),
subtitle: Text("Gwarinpa, Abuja"),
),
),

const SizedBox(height: 30),

const Text(
"Order Summary",
style: TextStyle(
fontSize: 20,
fontWeight: FontWeight.bold,
),
),

const SizedBox(height: 15),
  Card(
    shape: RoundedRectangleBorder(
      borderRadius: BorderRadius.circular(16),
    ),
    child: Column(
      children: [

        ...cart.map(
              (item) => ListTile(
            leading: CircleAvatar(
              backgroundImage: AssetImage(item.image),
            ),

            title: Text(
              item.name,
              style: const TextStyle(
                fontWeight: FontWeight.bold,
              ),
            ),

            subtitle: Text(
              "${item.quantity} × ₦${item.price.toStringAsFixed(0)}",
            ),

            trailing: Text(
              "₦${item.total.toStringAsFixed(0)}",
              style: const TextStyle(
                fontWeight: FontWeight.bold,
              ),
            ),
          ),
        ),

        const Divider(),

        Padding(
          padding: const EdgeInsets.all(18),

          child: Column(
            children: [

              Row(
                mainAxisAlignment:
                MainAxisAlignment.spaceBetween,
                children: [

                  const Text("Subtotal"),

                  Text(
                    "₦${subtotal.toStringAsFixed(0)}",
                  ),
                ],
              ),

              const SizedBox(height: 10),

              const Row(
                mainAxisAlignment:
                MainAxisAlignment.spaceBetween,
                children: [

                  Text("Delivery Fee"),

                  Text("₦800"),
                ],
              ),

              const SizedBox(height: 10),

              const Row(
                mainAxisAlignment:
                MainAxisAlignment.spaceBetween,
                children: [

                  Text("Service Fee"),

                  Text("₦200"),
                ],
              ),

              const Padding(
                padding: EdgeInsets.symmetric(vertical: 15),
                child: Divider(),
              ),

              Row(
                mainAxisAlignment:
                MainAxisAlignment.spaceBetween,
                children: [

                  const Text(
                    "Total",
                    style: TextStyle(
                      fontSize: 22,
                      fontWeight: FontWeight.bold,
                    ),
                  ),

                  Text(
                    "₦${total.toStringAsFixed(0)}",
                    style: const TextStyle(
                      color: Color(0xFFF57C00),
                      fontSize: 24,
                      fontWeight: FontWeight.bold,
                    ),
                  ),
                ],
              ),
            ],
          ),
        ),
      ],
    ),
  ),

  const SizedBox(height: 30),

  SizedBox(
    width: double.infinity,
    height: 58,

    child: ElevatedButton(
      style: ElevatedButton.styleFrom(
        backgroundColor: const Color(0xFFF57C00),
        foregroundColor: Colors.white,
        shape: RoundedRectangleBorder(
          borderRadius: BorderRadius.circular(16),
        ),
      ),

      onPressed: () {
        Navigator.push(
          context,
          MaterialPageRoute(
            builder: (_) => const PaymentScreen(),
          ),
        );
      },

      child: const Text(
        "Proceed to Payment",
        style: TextStyle(
          fontSize: 18,
          fontWeight: FontWeight.bold,
        ),
      ),
    ),
  ),

  const SizedBox(height: 20),
],
),
),
);
}
}