import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';

import '../../../app/theme.dart';
import '../controllers/order_controller.dart';
import '../widgets/cancel_order_button.dart';
import '../widgets/order_item_tile.dart';
import '../widgets/order_loading.dart';
import '../widgets/order_status_badge.dart';

class OrderDetailsScreen extends StatefulWidget {
  final int orderId;

  const OrderDetailsScreen({
    super.key,
    required this.orderId,
  });

  @override
  State<OrderDetailsScreen> createState() =>
      _OrderDetailsScreenState();
}

class _OrderDetailsScreenState
    extends State<OrderDetailsScreen> {
late final OrderController controller;

@override
void initState() {
super.initState();

controller = OrderController();
controller.loadOrder(widget.orderId);
}

@override
void dispose() {
controller.dispose();
super.dispose();
}

Future<void> _refresh() async {
await controller.loadOrder(widget.orderId);
}

@override
Widget build(BuildContext context) {
return Scaffold(
backgroundColor: AppColors.background,

appBar: AppBar(
title: const Text("Order Details"),
),

body: SafeArea(
child: AnimatedBuilder(
animation: controller,
builder: (_, _) {
if (controller.isLoading &&
controller.currentOrder == null) {
return const OrderLoading();
}

if (controller.error != null &&
controller.currentOrder == null) {
return Center(
child: Padding(
padding:
const EdgeInsets.all(24),
child: Text(
controller.error!,
textAlign: TextAlign.center,
),
),
);
}

final order =
controller.currentOrder;

if (order == null) {
return const Center(
child: Text(
"Unable to load order.",
),
);
}

return RefreshIndicator(
color: AppColors.primary,
onRefresh: _refresh,
child: ListView(
physics:
const AlwaysScrollableScrollPhysics(),
padding:
const EdgeInsets.all(16),
children: [

/// ============================
/// ORDER HEADER
/// ============================

Card(
elevation: 0,
shape:
RoundedRectangleBorder(
borderRadius:
BorderRadius.circular(
18),
),
child: Padding(
padding:
const EdgeInsets.all(
20),
child: Row(
children: [
Container(
width: 60,
height: 60,
decoration:
BoxDecoration(
color: AppColors
.primary
.withValues(
alpha:
.10),
borderRadius:
BorderRadius
.circular(
16),
),
child:
const Icon(
Icons.storefront,
color: AppColors
.primary,
size: 30,
),
),

const SizedBox(
width: 16),

Expanded(
child: Column(
crossAxisAlignment:
CrossAxisAlignment
.start,
children: [

Text(
order
.vendorName,
style:
const TextStyle(
fontSize:
20,
fontWeight:
FontWeight
.bold,
),
),

const SizedBox(
height:
4),

  Text(
    "Order #${order.publicId}",
    style: TextStyle(
      color: Colors.grey.shade600,
    ),
  ),

const SizedBox(
height:
12),

OrderStatusBadge(
status: order
.orderStatus,
),
],
),
),
],
),
),
),

const SizedBox(height: 20),

/// ============================
/// PRODUCTS
/// ============================

Card(
elevation: 0,
shape:
RoundedRectangleBorder(
borderRadius:
BorderRadius.circular(
18),
),
child: Padding(
padding:
const EdgeInsets.all(
20),
child: Column(
crossAxisAlignment:
CrossAxisAlignment
.start,
children: [

const Row(
children: [

Icon(
Icons
.shopping_bag_outlined,
color: AppColors
.primary,
),

SizedBox(
width: 10),

Text(
"Items",
style:
TextStyle(
fontSize:
18,
fontWeight:
FontWeight
.bold,
),
),
],
),

const SizedBox(
height: 18),

...order.items.map(
(item) => Padding(
padding:
const EdgeInsets
.only(
bottom:
14),
child:
OrderItemTile(
item: item,
),
),
),
],
),
),
),

const SizedBox(height: 20),

/// ============================
/// DELIVERY
/// ============================

Card(
elevation: 0,
shape:
RoundedRectangleBorder(
borderRadius:
BorderRadius.circular(
18),
),
child: Padding(
padding:
const EdgeInsets.all(
20),
child: Column(
crossAxisAlignment:
CrossAxisAlignment
.start,
children: [

const Row(
children: [

Icon(
Icons
.location_on_outlined,
color: AppColors
.primary,
),

SizedBox(
width: 10),

Text(
"Delivery Address",
style:
TextStyle(
fontSize:
18,
fontWeight:
FontWeight
.bold,
),
),
],
),

const SizedBox(
height: 18),

ListTile(
contentPadding:
EdgeInsets.zero,
leading:
const Icon(
Icons.location_on,
color: AppColors
.primary,
),
title: Text(
order
.deliveryAddress,
),
),

ListTile(
contentPadding:
EdgeInsets.zero,
leading:
const Icon(
Icons.phone,
color: AppColors
.primary,
),
title: Text(
order
.customerPhone,
),
),

if (order
.customerNote
.trim()
.isNotEmpty)
ListTile(
contentPadding:
EdgeInsets.zero,
leading:
const Icon(
Icons.notes,
color:
AppColors
.primary,
),
title: Text(
order
.customerNote,
),
),
],
),
),
),

const SizedBox(height: 20),
  /// ============================
  /// PAYMENT SUMMARY
  /// ============================

  Card(
    elevation: 0,
    shape: RoundedRectangleBorder(
      borderRadius:
      BorderRadius.circular(18),
    ),
    child: Padding(
      padding:
      const EdgeInsets.all(20),
      child: Column(
        crossAxisAlignment:
        CrossAxisAlignment.start,
        children: [
          const Row(
            children: [
              Icon(
                Icons
                    .account_balance_wallet_outlined,
                color:
                AppColors.primary,
              ),
              SizedBox(width: 10),
              Text(
                "Payment Summary",
                style: TextStyle(
                  fontSize: 18,
                  fontWeight:
                  FontWeight.bold,
                ),
              ),
            ],
          ),

          const SizedBox(height: 18),

          _SummaryRow(
            "Subtotal",
            "₦${order.subtotal.toStringAsFixed(0)}",
          ),

          _SummaryRow(
            "Delivery Fee",
            "₦${order.deliveryFee.toStringAsFixed(0)}",
          ),

          _SummaryRow(
            "Service Fee",
            "₦${order.serviceFee.toStringAsFixed(0)}",
          ),
          const Divider(height: 30),

          _SummaryRow(
            "Payment Method",
            order.paymentMethodLabel,
          ),

          _SummaryRow(
            "Payment Status",
            order.paymentStatusLabel,
          ),

          const Divider(height: 30),

          _SummaryRow(
            "Total",
            "₦${order.total.toStringAsFixed(0)}",
            bold: true,
          ),
        ],
      ),
    ),
  ),

  const SizedBox(height: 28),

  /// ============================
  /// ACTIONS
  /// ============================

  SizedBox(
    width: double.infinity,
    child: FilledButton.icon(
      style: FilledButton.styleFrom(
        backgroundColor:
        AppColors.primary,
        minimumSize:
        const Size.fromHeight(
            56),
        shape:
        RoundedRectangleBorder(
          borderRadius:
          BorderRadius.circular(
              14),
        ),
      ),
      onPressed: () {
        context.push(
          "/tracking/${order.id}",
        );
      },
      icon: const Icon(
        Icons.location_searching,
      ),
      label: const Text(
        "Track Order",
      ),
    ),
  ),

  if (order.isActive) ...[
    const SizedBox(height: 14),

    CancelOrderButton(
      order: order,
      controller: controller,
    ),
  ],

  const SizedBox(height: 30),
],
),
);
},
),
),
);
}
}

class _SummaryRow extends StatelessWidget {
  final String title;
  final String value;
  final bool bold;

  const _SummaryRow(
      this.title,
      this.value, {
        this.bold = false,
      });

  @override
  Widget build(BuildContext context) {
    final style = TextStyle(
      fontSize: bold ? 17 : 15,
      fontWeight:
      bold ? FontWeight.bold : FontWeight.w600,
      color: bold
          ? AppColors.primary
          : Colors.black87,
    );

    return Padding(
      padding: const EdgeInsets.symmetric(
        vertical: 8,
      ),
      child: Row(
        children: [
          Expanded(
            child: Text(
              title,
              style: style,
            ),
          ),
          Text(
            value,
            style: style,
          ),
        ],
      ),
    );
  }
}