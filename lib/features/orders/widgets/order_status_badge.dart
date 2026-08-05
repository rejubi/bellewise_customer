import 'package:flutter/material.dart';

import '../../../app/theme.dart';
import '../models/order_status.dart';

class OrderStatusBadge extends StatelessWidget {
  final OrderStatus status;

  const OrderStatusBadge({
    super.key,
    required this.status,
  });

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: const EdgeInsets.symmetric(
        horizontal: 14,
        vertical: 8,
      ),

      decoration: BoxDecoration(
        color: _backgroundColor(),
        borderRadius: BorderRadius.circular(30),
      ),

      child: Row(
        mainAxisSize: MainAxisSize.min,
        children: [
          Icon(
            _icon(),
            size: 16,
            color: _textColor(),
          ),

          const SizedBox(width: 6),

          Text(
            status.title,
            style: TextStyle(
              color: _textColor(),
              fontWeight: FontWeight.w600,
            ),
          ),
        ],
      ),
    );
  }

  Color _backgroundColor() {
    switch (status) {
      case OrderStatus.pending:
        return Colors.orange.withOpacity(.12);

      case OrderStatus.confirmed:
        return Colors.blue.withOpacity(.12);

      case OrderStatus.preparing:
        return Colors.deepOrange.withOpacity(.12);

      case OrderStatus.ready:
        return AppColors.primary.withOpacity(.12);

      case OrderStatus.assigned:
        return Colors.indigo.withOpacity(.12);

      case OrderStatus.pickedUp:
        return Colors.purple.withOpacity(.12);

      case OrderStatus.delivered:
        return Colors.green.withOpacity(.12);

      case OrderStatus.cancelled:
        return Colors.red.withOpacity(.12);

      default:
        return Colors.grey.withOpacity(.12);
    }
  }

  Color _textColor() {
    switch (status) {
      case OrderStatus.pending:
        return Colors.orange;

      case OrderStatus.confirmed:
        return Colors.blue;

      case OrderStatus.preparing:
        return Colors.deepOrange;

      case OrderStatus.ready:
        return AppColors.primary;

      case OrderStatus.assigned:
        return Colors.indigo;

      case OrderStatus.pickedUp:
        return Colors.purple;

      case OrderStatus.delivered:
        return Colors.green;

      case OrderStatus.cancelled:
        return Colors.red;

      default:
        return Colors.grey;
    }
  }

  IconData _icon() {
    switch (status) {
      case OrderStatus.pending:
        return Icons.schedule;

      case OrderStatus.confirmed:
        return Icons.check_circle_outline;

      case OrderStatus.preparing:
        return Icons.restaurant;

      case OrderStatus.ready:
        return Icons.done_all;

      case OrderStatus.assigned:
        return Icons.delivery_dining;

      case OrderStatus.pickedUp:
        return Icons.local_shipping;

      case OrderStatus.delivered:
        return Icons.check_circle;

      case OrderStatus.cancelled:
        return Icons.cancel;

      default:
        return Icons.help_outline;
    }
  }
}