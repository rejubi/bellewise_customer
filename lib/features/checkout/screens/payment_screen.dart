import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';

import '../../../app/theme.dart';
import '../../cart/models/cart_model.dart';
import '../../cart/models/cart_pricing_model.dart';
import '../controllers/checkout_controller.dart';
import '../models/checkout_request_model.dart';
import '../widgets/checkout_summary.dart';
import '../widgets/payment_option_card.dart';

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
              style: ElevatedButton.styleFrom(
                backgroundColor: AppColors.primary,
                foregroundColor: Colors.white,
                shape: RoundedRectangleBorder(
                  borderRadius: BorderRadius.circular(14),
                ),
              ),
              child: loading
                  ? const SizedBox(
                width: 22,
                height: 22,
                child: CircularProgressIndicator(
                  strokeWidth: 2,
                  color: Colors.white,
                ),
              )
                  : const Text(
                "Place Order",
                style: TextStyle(
                  fontSize: 16,
                  fontWeight: FontWeight.w600,
                ),
              ),
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

          // -----------------------------------------
          // CASH ON DELIVERY
          // -----------------------------------------

          PaymentOptionCard(
            title: "Cash on Delivery",
            subtitle: "Pay when your order arrives.",
            icon: Icons.payments_outlined,
            selected: paymentMethod == "CASH",
            onTap: () {
              if (loading) return;

              setState(() {
                paymentMethod = "CASH";
              });
            },
          ),

          const SizedBox(height: 16),

          // -----------------------------------------
          // BANK TRANSFER
          // -----------------------------------------

          PaymentOptionCard(
            title: "Bank Transfer",
            subtitle: "Pay now for your order.",
            icon: Icons.account_balance_outlined,
            selected: paymentMethod == "TRANSFER",
            onTap: () {
              if (loading) return;

              setState(() {
                paymentMethod = "TRANSFER";
              });
            },
          ),

          const SizedBox(height: 28),

          // -----------------------------------------
          // ORDER SUMMARY
          // -----------------------------------------

          CheckoutSummary(
            subtotal: pricing.subtotal,
            deliveryFee: pricing.deliveryFee,
            serviceFee: pricing.serviceFee,
            vat: pricing.vat,
            total: pricing.total,
          ),

          const SizedBox(height: 24),

          // -----------------------------------------
          // CASH INFORMATION
          // -----------------------------------------

          if (paymentMethod == "CASH")
            Container(
              padding: const EdgeInsets.all(16),
              decoration: BoxDecoration(
                color: Colors.white,
                borderRadius: BorderRadius.circular(14),
              ),
              child: const Row(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Icon(
                    Icons.info_outline,
                    color: AppColors.primary,
                  ),
                  SizedBox(width: 12),
                  Expanded(
                    child: Text(
                      "You will pay the rider when your order is delivered.",
                      style: TextStyle(
                        fontSize: 14,
                        height: 1.4,
                      ),
                    ),
                  ),
                ],
              ),
            ),

          // -----------------------------------------
          // TRANSFER INFORMATION
          // -----------------------------------------

          if (paymentMethod == "TRANSFER")
            Container(
              padding: const EdgeInsets.all(16),
              decoration: BoxDecoration(
                color: Colors.white,
                borderRadius: BorderRadius.circular(14),
              ),
              child: const Row(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Icon(
                    Icons.account_balance_outlined,
                    color: AppColors.primary,
                  ),
                  SizedBox(width: 12),
                  Expanded(
                    child: Text(
                      "You will be redirected to the payment process to complete your bank transfer.",
                      style: TextStyle(
                        fontSize: 14,
                        height: 1.4,
                      ),
                    ),
                  ),
                ],
              ),
            ),
        ],
      ),
    );
  }

  Future<void> _placeOrder() async {
    if (loading) return;

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

      // -----------------------------------------
      // CREATE ORDER
      // -----------------------------------------

      final publicId = await _controller.createOrder(
        request,
      );

      if (!mounted) return;

      // -----------------------------------------
      // GO TO SUCCESS SCREEN
      // -----------------------------------------

      context.go(
        "/order-success/$publicId",
      );
    } catch (e) {
      if (!mounted) return;

      ScaffoldMessenger.of(context).showSnackBar(
        SnackBar(
          content: Text(
            e.toString(),
          ),
          backgroundColor: Colors.red,
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