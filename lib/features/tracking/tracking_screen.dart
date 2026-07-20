import 'package:flutter/material.dart';

import '../home/home_screen.dart';
import 'widgets/rider_card.dart';
import 'widgets/tracking_step.dart';

class TrackingScreen extends StatelessWidget {
  const TrackingScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.grey.shade100,

      appBar: AppBar(
        title: const Text("Track Order"),
        centerTitle: true,
      ),

      body: SingleChildScrollView(
        padding: const EdgeInsets.all(20),

        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [

            // Map Placeholder
            Container(
              height: 220,
              width: double.infinity,
              decoration: BoxDecoration(
                color: Colors.grey.shade300,
                borderRadius: BorderRadius.circular(20),
              ),
              child: const Center(
                child: Column(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    Icon(
                      Icons.map,
                      size: 70,
                      color: Colors.grey,
                    ),
                    SizedBox(height: 10),
                    Text(
                      "Live Map Coming Soon",
                      style: TextStyle(
                        color: Colors.grey,
                        fontSize: 17,
                      ),
                    ),
                  ],
                ),
              ),
            ),

            const SizedBox(height: 30),

            const Text(
              "Order Status",
              style: TextStyle(
                fontSize: 24,
                fontWeight: FontWeight.bold,
              ),
            ),

            const SizedBox(height: 25),

            const TrackingStep(
              title: "Order Received",
              subtitle: "Restaurant received your order",
              completed: true,
            ),

            const TrackingStep(
              title: "Preparing Food",
              subtitle: "Your meal is being prepared",
              completed: true,
            ),

            const TrackingStep(
              title: "Rider Assigned",
              subtitle: "A rider has accepted your order",
              completed: true,
            ),

            const TrackingStep(
              title: "On the Way",
              subtitle: "Your rider is heading to you",
              completed: false,
            ),

            const TrackingStep(
              title: "Delivered",
              subtitle: "Enjoy your meal!",
              completed: false,
              isLast: true,
            ),

            const SizedBox(height: 30),

            const Text(
              "Delivery Rider",
              style: TextStyle(
                fontSize: 24,
                fontWeight: FontWeight.bold,
              ),
            ),

            const SizedBox(height: 15),

            const RiderCard(),

            const SizedBox(height: 35),

            SizedBox(
              width: double.infinity,
              height: 55,
              child: ElevatedButton(
                style: ElevatedButton.styleFrom(
                  backgroundColor: const Color(0xFFF57C00),
                  shape: RoundedRectangleBorder(
                    borderRadius: BorderRadius.circular(16),
                  ),
                ),
                onPressed: () {
                  Navigator.pushAndRemoveUntil(
                    context,
                    MaterialPageRoute(
                      builder: (_) => const HomeScreen(),
                    ),
                        (route) => false,
                  );
                },
                child: const Text(
                  "Back Home",
                  style: TextStyle(
                    color: Colors.white,
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
}