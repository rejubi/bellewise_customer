import 'package:flutter/material.dart';

class NotificationsScreen extends StatelessWidget {
  const NotificationsScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.grey.shade100,

      appBar: AppBar(
        title: const Text("Notifications"),
        centerTitle: true,
      ),

      body: ListView(
        padding: const EdgeInsets.all(20),

        children: const [

          NotificationCard(
            icon: Icons.restaurant,
            title: "Order Accepted",
            subtitle: "Mama Nkechi Kitchen has accepted your order.",
            time: "2 mins ago",
            color: Colors.green,
          ),

          SizedBox(height: 15),

          NotificationCard(
            icon: Icons.delivery_dining,
            title: "Rider Assigned",
            subtitle: "David Musa is on the way to pick up your order.",
            time: "8 mins ago",
            color: Colors.orange,
          ),

          SizedBox(height: 15),

          NotificationCard(
            icon: Icons.local_offer,
            title: "20% Discount",
            subtitle: "Enjoy 20% off Chicken Republic today.",
            time: "Today",
            color: Colors.red,
          ),

          SizedBox(height: 15),

          NotificationCard(
            icon: Icons.card_giftcard,
            title: "Welcome to Bellewise",
            subtitle: "Thanks for joining Bellewise.",
            time: "Yesterday",
            color: Color(0xFFF57C00),
          ),
        ],
      ),
    );
  }
}

class NotificationCard extends StatelessWidget {
  final IconData icon;
  final String title;
  final String subtitle;
  final String time;
  final Color color;

  const NotificationCard({
    super.key,
    required this.icon,
    required this.title,
    required this.subtitle,
    required this.time,
    required this.color,
  });

  @override
  Widget build(BuildContext context) {
    return Card(
      elevation: 2,

      shape: RoundedRectangleBorder(
        borderRadius: BorderRadius.circular(16),
      ),

      child: ListTile(
        leading: CircleAvatar(
          backgroundColor: color,
          child: Icon(
            icon,
            color: Colors.white,
          ),
        ),

        title: Text(
          title,
          style: const TextStyle(
            fontWeight: FontWeight.bold,
          ),
        ),

        subtitle: Text(subtitle),

        trailing: Text(
          time,
          style: const TextStyle(
            color: Colors.grey,
            fontSize: 12,
          ),
        ),
      ),
    );
  }
}