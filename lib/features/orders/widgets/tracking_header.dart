import 'package:flutter/material.dart';
import 'package:intl/intl.dart';

import '../../../app/theme.dart';
import '../models/order_model.dart';
import 'order_status_badge.dart';

class TrackingHeader extends StatelessWidget {
  final OrderModel order;

  const TrackingHeader({
    super.key,
    required this.order,
  });

  @override
  Widget build(BuildContext context) {
    final currency = NumberFormat.currency(
      locale: "en_NG",
      symbol: "₦",
      decimalDigits: 0,
    );

    return Container(
      width: double.infinity,
      padding: const EdgeInsets.all(20),

      decoration: BoxDecoration(
        color: Colors.white,
        borderRadius: BorderRadius.circular(16),
        boxShadow: [
          BoxShadow(
            color: Colors.black.withOpacity(.05),
            blurRadius: 12,
            offset: const Offset(0, 4),
          ),
        ],
      ),

      child: Column(
        crossAxisAlignment:
        CrossAxisAlignment.start,

        children: [

          Row(
            children: [

              CircleAvatar(
                radius: 26,
                backgroundColor:
                AppColors.primary.withOpacity(.12),

                child: const Icon(
                  Icons.restaurant,
                  color: AppColors.primary,
                ),
              ),

              const SizedBox(width: 16),

              Expanded(
                child: Column(
                  crossAxisAlignment:
                  CrossAxisAlignment.start,

                  children: [

                    Text(
                      order.vendorName,
                      style: const TextStyle(
                        fontSize: 18,
                        fontWeight:
                        FontWeight.bold,
                      ),
                    ),

                    const SizedBox(height: 4),

                    Text(
                      "Order #${order.id}",
                      style: TextStyle(
                        color: Colors.grey.shade600,
                      ),
                    ),
                  ],
                ),
              ),
            ],
          ),

          const SizedBox(height: 20),

          OrderStatusBadge(
            status: order.orderStatus,
          ),

          const SizedBox(height: 20),

          const Divider(),

          const SizedBox(height: 16),

          Row(
            children: [

              Expanded(
                child: _InfoTile(
                  title: "Items",
                  value:
                  "${order.totalItems}",
                ),
              ),

              Expanded(
                child: _InfoTile(
                  title: "Total",
                  value: currency.format(
                    order.total,
                  ),
                ),
              ),
            ],
          ),
        ],
      ),
    );
  }
}

class _InfoTile extends StatelessWidget {
  final String title;
  final String value;

  const _InfoTile({
    required this.title,
    required this.value,
  });

  @override
  Widget build(BuildContext context) {
    return Column(
      crossAxisAlignment:
      CrossAxisAlignment.start,

      children: [

        Text(
          title,
          style: TextStyle(
            color: Colors.grey.shade600,
            fontSize: 13,
          ),
        ),

        const SizedBox(height: 4),

        Text(
          value,
          style: const TextStyle(
            fontWeight: FontWeight.bold,
            fontSize: 17,
          ),
        ),
      ],
    );
  }
}