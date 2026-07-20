import 'package:flutter/material.dart';

import '../home/home_screen.dart';

class TrackOrderScreen extends StatelessWidget {
const TrackOrderScreen({super.key});

@override
Widget build(BuildContext context) {
return Scaffold(
backgroundColor: Colors.grey.shade100,

appBar: AppBar(
title: const Text("Track Order"),
centerTitle: true,
),

body: SingleChildScrollView(
child: Column(
children: [

Container(
width: double.infinity,
height: 260,
color: Colors.grey.shade300,

child: const Center(
child: Column(
mainAxisAlignment: MainAxisAlignment.center,
children: [

Icon(
Icons.map,
size: 70,
color: Colors.grey,
),

SizedBox(height: 12),

Text(
"Google Maps will appear here",
style: TextStyle(
color: Colors.grey,
fontSize: 16,
),
),
],
),
),
),

Padding(
padding: const EdgeInsets.all(20),

child: Column(
crossAxisAlignment: CrossAxisAlignment.start,

children: [

const Text(
"Estimated Arrival",
style: TextStyle(
color: Colors.grey,
),
),

const SizedBox(height: 8),

const Text(
"25 - 35 mins",
style: TextStyle(
fontSize: 30,
fontWeight: FontWeight.bold,
color: Color(0xFFF57C00),
),
),

const SizedBox(height: 30),

const Text(
"Order Status",
style: TextStyle(
fontSize: 22,
fontWeight: FontWeight.bold,
),
),

const SizedBox(height: 25),

_buildStatusTile(
icon: Icons.check_circle,
title: "Order Confirmed",
subtitle: "Your order has been received.",
completed: true,
),

_buildStatusTile(
icon: Icons.restaurant,
title: "Preparing Food",
subtitle: "The restaurant is preparing your meal.",
completed: true,
),

_buildStatusTile(
icon: Icons.delivery_dining,
title: "Rider Picked Up",
subtitle: "Your order is on its way.",
completed: false,
),

_buildStatusTile(
icon: Icons.location_on,
title: "Arriving Soon",
subtitle: "Your rider is almost there.",
completed: false,
),

_buildStatusTile(
icon: Icons.home,
title: "Delivered",
subtitle: "Enjoy your meal!",
completed: false,
),

const SizedBox(height: 30),
const Text(
"Your Rider",
style: TextStyle(
fontSize: 22,
fontWeight: FontWeight.bold,
),
),

const SizedBox(height: 15),

Card(
elevation: 3,
shape: RoundedRectangleBorder(
borderRadius: BorderRadius.circular(16),
),
child: Padding(
padding: const EdgeInsets.all(16),
child: Row(
children: [

const CircleAvatar(
radius: 30,
backgroundColor: Color(0xFFF57C00),
child: Icon(
Icons.person,
color: Colors.white,
size: 32,
),
),

const SizedBox(width: 15),

const Expanded(
child: Column(
crossAxisAlignment:
CrossAxisAlignment.start,
children: [

Text(
"David Musa",
style: TextStyle(
fontWeight: FontWeight.bold,
fontSize: 18,
),
),

SizedBox(height: 4),

Text(
"Delivery Rider",
style: TextStyle(
color: Colors.grey,
),
),

SizedBox(height: 4),

Row(
children: [

Icon(
Icons.star,
color: Colors.amber,
size: 18,
),

SizedBox(width: 4),

Text("4.9"),
],
),
],
),
),

Column(
children: [

CircleAvatar(
backgroundColor:
Color(0xFFF57C00),
child: Icon(
Icons.call,
color: Colors.white,
),
),

SizedBox(height: 12),

CircleAvatar(
backgroundColor: Colors.blue,
child: Icon(
Icons.chat,
color: Colors.white,
),
),
],
),
],
),
),
),

const SizedBox(height: 30),

SizedBox(
width: double.infinity,
height: 58,
child: ElevatedButton(
style: ElevatedButton.styleFrom(
backgroundColor:
const Color(0xFFF57C00),
foregroundColor: Colors.white,
shape: RoundedRectangleBorder(
borderRadius:
BorderRadius.circular(16),
),
),
onPressed: () {
Navigator.pushAndRemoveUntil(
context,
MaterialPageRoute(
builder: (_) =>
const HomeScreen(),
),
(route) => false,
);
},
child: const Text(
"Back to Home",
style: TextStyle(
fontSize: 18,
fontWeight: FontWeight.bold,
),
),
),
),

const SizedBox(height: 20),                ],
),
),
],
),
),
);
}

Widget _buildStatusTile({
  required IconData icon,
  required String title,
  required String subtitle,
  required bool completed,
}) {
  return Padding(
    padding: const EdgeInsets.only(bottom: 18),
    child: Row(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [

        CircleAvatar(
          radius: 20,
          backgroundColor: completed
              ? const Color(0xFFF57C00)
              : Colors.grey.shade300,
          child: Icon(
            icon,
            color: Colors.white,
            size: 20,
          ),
        ),

        const SizedBox(width: 15),

        Expanded(
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [

              Text(
                title,
                style: TextStyle(
                  fontSize: 17,
                  fontWeight: FontWeight.bold,
                  color: completed
                      ? Colors.black
                      : Colors.grey,
                ),
              ),

              const SizedBox(height: 4),

              Text(
                subtitle,
                style: TextStyle(
                  color: Colors.grey.shade600,
                  fontSize: 14,
                ),
              ),
            ],
          ),
        ),
      ],
    ),
  );
}
}