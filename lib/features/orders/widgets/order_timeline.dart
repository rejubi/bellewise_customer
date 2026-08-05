import 'package:flutter/material.dart';

import '../../../app/theme.dart';
import '../models/order_status.dart';

class OrderTimeline extends StatelessWidget {
  final OrderStatus currentStatus;

  const OrderTimeline({
    super.key,
    required this.currentStatus,
  });

  static const List<OrderStatus> _steps = [
    OrderStatus.pending,
    OrderStatus.confirmed,
    OrderStatus.preparing,
    OrderStatus.ready,
    OrderStatus.assigned,
    OrderStatus.pickedUp,
    OrderStatus.delivered,
  ];

  @override
  Widget build(BuildContext context) {
    final currentIndex = _steps.indexOf(currentStatus);

    return Column(
      children: List.generate(
        _steps.length,
            (index) {
          final completed = index <= currentIndex;

          return _TimelineStep(
            title: _steps[index].title,
            completed: completed,
            isLast: index == _steps.length - 1,
          );
        },
      ),
    );
  }
}

class _TimelineStep extends StatelessWidget {
  final String title;
  final bool completed;
  final bool isLast;

  const _TimelineStep({
    required this.title,
    required this.completed,
    required this.isLast,
  });

  @override
  Widget build(BuildContext context) {
    final color = completed
        ? AppColors.primary
        : Colors.grey.shade300;

    return IntrinsicHeight(
      child: Row(
        crossAxisAlignment:
        CrossAxisAlignment.start,
        children: [
          Column(
            children: [
              AnimatedContainer(
                duration: const Duration(
                  milliseconds: 300,
                ),
                width: 18,
                height: 18,
                decoration: BoxDecoration(
                  color: color,
                  shape: BoxShape.circle,
                ),
                child: completed
                    ? const Icon(
                  Icons.check,
                  color: Colors.white,
                  size: 12,
                )
                    : null,
              ),
              if (!isLast)
                Expanded(
                  child: Container(
                    width: 2,
                    color: color,
                  ),
                ),
            ],
          ),

          const SizedBox(width: 16),

          Expanded(
            child: Padding(
              padding:
              const EdgeInsets.only(
                bottom: 26,
              ),
              child: Text(
                title,
                style: TextStyle(
                  fontSize: 16,
                  fontWeight: completed
                      ? FontWeight.w600
                      : FontWeight.w400,
                  color: completed
                      ? Colors.black
                      : Colors.grey,
                ),
              ),
            ),
          ),
        ],
      ),
    );
  }
}