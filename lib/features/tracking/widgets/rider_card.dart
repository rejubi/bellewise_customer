import 'package:flutter/material.dart';

class RiderCard extends StatelessWidget {
  const RiderCard({super.key});

  @override
  Widget build(BuildContext context) {
    return Card(
      shape: RoundedRectangleBorder(
        borderRadius: BorderRadius.circular(18),
      ),

      child: ListTile(
        leading: const CircleAvatar(
          radius: 28,
          backgroundColor: Color(0xFFF57C00),
          child: Icon(
            Icons.person,
            color: Colors.white,
          ),
        ),

        title: const Text(
          "John David",
          style: TextStyle(
            fontWeight: FontWeight.bold,
          ),
        ),

        subtitle: const Text(
          "Bellewise Rider",
        ),

        trailing: Row(
          mainAxisSize: MainAxisSize.min,
          children: [

            CircleAvatar(
              backgroundColor: Colors.green.shade100,

              child: IconButton(
                icon: const Icon(
                  Icons.call,
                  color: Colors.green,
                ),
                onPressed: () {},
              ),
            ),

            const SizedBox(width: 10),

            CircleAvatar(
              backgroundColor: Colors.blue.shade100,

              child: IconButton(
                icon: const Icon(
                  Icons.chat,
                  color: Colors.blue,
                ),
                onPressed: () {},
              ),
            ),
          ],
        ),
      ),
    );
  }
}