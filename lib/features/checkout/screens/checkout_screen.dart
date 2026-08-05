import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';

import '../../../app/theme.dart';
import '../../cart/models/cart_model.dart';
import '../widgets/checkout_item_card.dart';
import '../widgets/address_card.dart';
import '../widgets/checkout_summary.dart';
import '../widgets/notes_field.dart';
import '../widgets/phone_field.dart';
import 'payment_screen.dart';

class CheckoutScreen extends StatefulWidget {
  final CartModel cart;

  const CheckoutScreen({
    super.key,
    required this.cart,
  });

  @override
  State<CheckoutScreen> createState() =>
      _CheckoutScreenState();
}

class _CheckoutScreenState
    extends State<CheckoutScreen> {
  final _formKey = GlobalKey<FormState>();

  final TextEditingController
  _addressController = TextEditingController();

  final TextEditingController
  _phoneController = TextEditingController();

  final TextEditingController
  _notesController = TextEditingController();

  @override
  void dispose() {
    _addressController.dispose();
    _phoneController.dispose();
    _notesController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    final cart = widget.cart;

    return Scaffold(
      backgroundColor: AppColors.background,

      appBar: AppBar(
        title: const Text("Checkout"),
      ),

      bottomNavigationBar: SafeArea(
        top: false,
        child: Container(
          padding: const EdgeInsets.fromLTRB(
            16,
            12,
            16,
            16,
          ),
          decoration: BoxDecoration(
            color: Colors.white,
            boxShadow: [
              BoxShadow(
                color: Colors.black.withValues(
                  alpha: 0.05,
                ),
                blurRadius: 12,
                offset: const Offset(0, -2),
              ),
            ],
          ),
          child: SizedBox(
            height: 56,
            child: ElevatedButton(
              onPressed: _continue,
              style: ElevatedButton.styleFrom(
                backgroundColor:
                AppColors.primary,
                foregroundColor:
                Colors.white,
                shape:
                RoundedRectangleBorder(
                  borderRadius:
                  BorderRadius.circular(
                    14,
                  ),
                ),
              ),
              child: const Text(
                "Continue",
                style: TextStyle(
                  fontSize: 16,
                  fontWeight:
                  FontWeight.w600,
                ),
              ),
            ),
          ),
        ),
      ),

      body: Form(
        key: _formKey,
        child: ListView(
          padding: const EdgeInsets.all(16),
          children: [
            AddressCard(
              controller:
              _addressController,
            ),

            const SizedBox(height: 18),

            PhoneField(
              controller:
              _phoneController,
            ),

            const SizedBox(height: 18),

            NotesField(
              controller:
              _notesController,
            ),

            const SizedBox(height: 24),

            const Text(
              "Your Items",
              style: TextStyle(
                fontSize: 18,
                fontWeight:
                FontWeight.bold,
              ),
            ),

            const SizedBox(height: 12),

            ...cart.items.map(
                  (item) => CheckoutItemCard(
                item: item,
              ),
            ),

            const SizedBox(height: 24),

            CheckoutSummary(
              subtotal: cart.subtotal,
              deliveryFee:
              cart.deliveryFee,
              serviceFee:
              cart.serviceFee,
              total: cart.total,
            ),

            const SizedBox(height: 24),
          ],
        ),
      ),
    );
  }

  void _continue() {
    if (!_formKey.currentState!.validate()) {
      return;
    }

    context.push(
      "/payment",
      extra: {
        "cart": widget.cart,
        "address":
        _addressController.text.trim(),
        "phone":
        _phoneController.text.trim(),
        "note":
        _notesController.text.trim(),
      },
    );
  }
}