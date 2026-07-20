import 'package:flutter/material.dart';

class TrackingStep extends StatelessWidget {
  final String title;
  final String subtitle;
  final bool completed;
  final bool isLast;

  const TrackingStep({
    super.key,
    required this.title,
    required this.subtitle,
    required this.completed,
    this.isLast = false,
  });

  @override
  Widget build(BuildContext context) {
    return Row(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [

        Column(
          children: [

            CircleAvatar(
              radius: 14,
              backgroundColor: completed
                  ? const Color(0xFFF57C00)
                  : Colors.grey.shade400,

              child: Icon(
                completed ? Icons.check : Icons.circle,
                color: Colors.white,
                size: 14,
              ),
            ),

            if (!isLast)
              Container(
                width: 2,
                height: 55,
                color: completed
                    ? const Color(0xFFF57C00)
                    : Colors.grey.shade300,
              ),
          ],
        ),

        const SizedBox(width: 15),

        Expanded(
          child: Padding(
            padding: const EdgeInsets.only(bottom: 18),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [

                Text(
                  title,
                  style: const TextStyle(
                    fontWeight: FontWeight.bold,
                    fontSize: 17,
                  ),
                ),

                const SizedBox(height: 4),

                Text(
                  subtitle,
                  style: const TextStyle(
                    color: Colors.grey,
                  ),
                ),
              ],
            ),
          ),
        ),
      ],
    );
  }
}