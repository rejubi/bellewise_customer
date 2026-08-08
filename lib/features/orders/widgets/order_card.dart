import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';
import 'package:intl/intl.dart';

import '../../../app/theme.dart';
import '../models/order_model.dart';
import 'order_status_badge.dart';

class OrderCard extends StatelessWidget {
  final OrderModel order;
  final VoidCallback onTap;

  const OrderCard({
    super.key,
    required this.order,
    required this.onTap,
  });

  bool get _isActive {
    return order.orderStatus != "DELIVERED" &&
        order.orderStatus != "CANCELLED";
  }

  @override
  Widget build(BuildContext context) {
    final currency = NumberFormat.currency(
      locale: "en_NG",
      symbol: "₦",
      decimalDigits: 0,
    );

    final date = DateFormat(
      "dd MMM yyyy • hh:mm a",
    ).format(order.createdAt);

    return Container(
      decoration: BoxDecoration(
        color: Colors.white,
        borderRadius: BorderRadius.circular(18),
        boxShadow: [
          BoxShadow(
            color: Colors.black.withValues(alpha: .05),
            blurRadius: 12,
            offset: const Offset(0, 4),
          ),
        ],
      ),
      child: InkWell(
        borderRadius: BorderRadius.circular(18),
        onTap: onTap,
        child: Padding(
          padding: const EdgeInsets.all(18),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              /// Header
              Row(
                children: [
                  Container(
                    width: 54,
                    height: 54,
                    decoration: BoxDecoration(
                      color: AppColors.primary.withValues(
                        alpha: .10,
                      ),
                      borderRadius: BorderRadius.circular(14),
                    ),
                    child: const Icon(
                      Icons.storefront,
                      color: AppColors.primary,
                      size: 28,
                    ),
                  ),

                  const SizedBox(width: 14),

                  Expanded(
                    child: Column(
                      crossAxisAlignment:
                      CrossAxisAlignment.start,
                      children: [
                        Text(
                          order.vendorName,
                          style: const TextStyle(
                            fontSize: 18,
                            fontWeight: FontWeight.bold,
                          ),
                        ),
                        const SizedBox(height: 4),
                        Text(
                          "Order #${order.publicId}",
                          style: TextStyle(
                            color: Colors.grey.shade600,
                          ),
                        ),
                      ],
                    ),
                  ),

                  OrderStatusBadge(
                    status: order.orderStatus,
                  ),
                ],
              ),

              const SizedBox(height: 18),

              Divider(
                color: Colors.grey.shade200,
              ),

              const SizedBox(height: 16),

              Row(
                children: [
                  Expanded(
                    child: _InfoCard(
                      icon: Icons.receipt_long,
                      title: "Total",
                      value: currency.format(order.total),
                    ),
                  ),

                  const SizedBox(width: 12),

                  Expanded(
                    child: _InfoCard(
                      icon: Icons.schedule,
                      title: "Ordered",
                      value: date,
                    ),
                  ),
                ],
              ),

              const SizedBox(height: 22),

              Row(
                children: [
                  Expanded(
                    child: OutlinedButton(
                      onPressed: onTap,
                      style: OutlinedButton.styleFrom(
                        minimumSize:
                        const Size.fromHeight(48),
                        shape: RoundedRectangleBorder(
                          borderRadius:
                          BorderRadius.circular(12),
                        ),
                      ),
                      child: const Text(
                        "View Details",
                      ),
                    ),
                  ),

                  if (_isActive) ...[
                    const SizedBox(width: 12),

                    Expanded(
                      child: FilledButton.icon(
                        onPressed: () {
                          context.push(
                            "/tracking/${order.id}",
                          );
                        },
                        icon: const Icon(
                          Icons.location_searching,
                          size: 18,
                        ),
                        label: const Text(
                          "Track",
                        ),
                        style: FilledButton.styleFrom(
                          minimumSize:
                          const Size.fromHeight(48),
                          backgroundColor:
                          AppColors.primary,
                          shape:
                          RoundedRectangleBorder(
                            borderRadius:
                            BorderRadius.circular(
                              12,
                            ),
                          ),
                        ),
                      ),
                    ),
                  ],
                ],
              ),
            ],
          ),
        ),
      ),
    );
  }
}

class _InfoCard extends StatelessWidget {
  final IconData icon;
  final String title;
  final String value;

  const _InfoCard({
    required this.icon,
    required this.title,
    required this.value,
  });

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: const EdgeInsets.symmetric(
        horizontal: 14,
        vertical: 12,
      ),
      decoration: BoxDecoration(
        color: AppColors.background,
        borderRadius: BorderRadius.circular(14),
      ),
      child: Column(
        crossAxisAlignment:
        CrossAxisAlignment.start,
        children: [
          Icon(
            icon,
            size: 18,
            color: AppColors.primary,
          ),

          const SizedBox(height: 8),

          Text(
            title,
            style: TextStyle(
              color: Colors.grey.shade600,
              fontSize: 12,
            ),
          ),

          const SizedBox(height: 4),

          Text(
            value,
            maxLines: 2,
            overflow: TextOverflow.ellipsis,
            style: const TextStyle(
              fontWeight: FontWeight.bold,
              fontSize: 14,
            ),
          ),
        ],
      ),
    );
  }
}