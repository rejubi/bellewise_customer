import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';

import '../../../app/theme.dart';
import '../../cart/models/cart_model.dart';
import '../controllers/checkout_controller.dart';
import '../models/checkout_request_model.dart';
import '../widgets/checkout_summary.dart';
import '../widgets/payment_option_card.dart';
import '../../cart/models/cart_pricing_model.dart';

class PaymentScreen extends StatefulWidget {
  final CartModel cart;
  final CartPricingModel pricing;
  final String address;
  final String phone;
  final String note;

  const PaymentScreen({
    super.key,
    required this.cart,
    required this.pricing,
    required this.address,
    required this.phone,
    required this.note,
  });

  @override
  State<PaymentScreen> createState() => _PaymentScreenState();
}

class _PaymentScreenState extends State<PaymentScreen> {
  final CheckoutController _controller = CheckoutController();

  String paymentMethod = "CASH";

  bool loading = false;

  @override
  Widget build(BuildContext context) {
    final pricing = widget.pricing;

    return Scaffold(
      backgroundColor: AppColors.background,
      appBar: AppBar(
        title: const Text("Payment"),
      ),
      bottomNavigationBar: SafeArea(
        child: Padding(
          padding: const EdgeInsets.all(16),
          child: SizedBox(
            height: 56,
            child: ElevatedButton(
              onPressed: loading ? null : _placeOrder,
              child: loading
                  ? const SizedBox(
                width: 22,
                height: 22,
                child: CircularProgressIndicator(
                  strokeWidth: 2,
                  color: Colors.white,
                ),
              )
                  : const Text("Place Order"),
            ),
          ),
        ),
      ),
      body: ListView(
        padding: const EdgeInsets.all(16),
        children: [
          const Text(
            "Choose Payment Method",
            style: TextStyle(
              fontWeight: FontWeight.bold,
              fontSize: 19,
            ),
          ),

          const SizedBox(height: 18),

          PaymentOptionCard(
            title: "Cash on Delivery",
            subtitle: "Pay when your order arrives.",
            icon: Icons.payments_outlined,
            selected: paymentMethod == "CASH",
            onTap: () {
              setState(() {
                paymentMethod = "CASH";
              });
            },
          ),

          const SizedBox(height: 16),

          PaymentOptionCard(
            title: "Bank Transfer",
            subtitle: "Pay now for your order.",
            icon: Icons.account_balance_outlined,
            selected: paymentMethod == "BANK_TRANSFER",
            onTap: () {
              setState(() {
                paymentMethod = "BANK_TRANSFER";
              });
            },
          ),

          const SizedBox(height: 28),

          CheckoutSummary(
            subtotal: pricing.subtotal,
            deliveryFee: pricing.deliveryFee,
            serviceFee: pricing.serviceFee,
            vat: pricing.vat,
            total: pricing.total,
          ),
        ],
      ),
    );
  }

  Future<void> _placeOrder() async {
    setState(() {
      loading = true;
    });

    try {
      final request = CheckoutRequestModel(
        deliveryAddress: widget.address,
        customerPhone: widget.phone,
        customerNote: widget.note,
        paymentMethod: paymentMethod,
      );

      final orderId = await _controller.createOrder(request);

      if (!mounted) return;

      context.go("/order-success/$orderId");
    } catch (e) {
      if (!mounted) return;

      ScaffoldMessenger.of(context).showSnackBar(
        SnackBar(
          content: Text(e.toString()),
        ),
      );
    } finally {
      if (mounted) {
        setState(() {
          loading = false;
        });
      }
    }
  }
}