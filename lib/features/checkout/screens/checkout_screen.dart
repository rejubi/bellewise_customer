import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';

import '../../../app/theme.dart';
import '../../../core/services/location_service.dart';
import '../../cart/controllers/cart_controller.dart';
import '../../cart/models/cart_model.dart';
import '../../cart/models/cart_pricing_model.dart';
import '../../profile/models/address_model.dart';
import '../widgets/address_card.dart';
import '../widgets/checkout_item_card.dart';
import '../widgets/checkout_summary.dart';
import '../widgets/notes_field.dart';
import '../widgets/phone_field.dart';

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

  final CartController _cartController =
  CartController();

  CartPricingModel? _pricing;

  bool _loadingPricing = true;

  String? _selectedAddress;

  final TextEditingController
  _phoneController =
  TextEditingController();

  final TextEditingController
  _notesController =
  TextEditingController();

  @override
  void initState() {
    super.initState();

    _selectedAddress =
        LocationService.currentAddress;

    _loadPricing();
  }

  Future<void> _loadPricing() async {
    try {
      final pricing =
      await _cartController.loadPricing();

      if (!mounted) return;

      setState(() {
        _pricing = pricing;
        _loadingPricing = false;
      });
    } catch (_) {
      if (!mounted) return;

      setState(() {
        _loadingPricing = false;
      });
    }
  }

  @override
  void dispose() {
    _phoneController.dispose();
    _notesController.dispose();
    super.dispose();
  }

  Future<void> _changeAddress() async {
    final result =
    await context.push<AddressModel>(
      "/profile/addresses",
    );

    if (result != null && mounted) {
      setState(() {
        _selectedAddress =
            result.fullAddress;
      });
    }
  }

  @override
  Widget build(BuildContext context) {
    final cart = widget.cart;

    return Scaffold(
      backgroundColor:
      AppColors.background,

      appBar: AppBar(
        title: const Text("Checkout"),
      ),

      bottomNavigationBar: SafeArea(
        top: false,
        child: Container(
          padding:
          const EdgeInsets.fromLTRB(
            16,
            12,
            16,
            16,
          ),
          decoration: BoxDecoration(
            color: Colors.white,
            boxShadow: [
              BoxShadow(
                color: Colors.black
                    .withValues(alpha: 0.05),
                blurRadius: 12,
                offset: const Offset(0, -2),
              ),
            ],
          ),
          child: SizedBox(
            height: 56,
            child: ElevatedButton(
              onPressed: _loadingPricing
                  ? null
                  : _continue,
              style:
              ElevatedButton.styleFrom(
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
              child: _loadingPricing
                  ? const SizedBox(
                height: 22,
                width: 22,
                child:
                CircularProgressIndicator(
                  strokeWidth: 2,
                  color: Colors.white,
                ),
              )
                  : const Text(
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
          padding:
          const EdgeInsets.all(16),
          children: [
            AddressCard(
              address: _selectedAddress,
              onChange: _changeAddress,
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
                  (item) =>
                  CheckoutItemCard(
                    item: item,
                  ),
            ),

            const SizedBox(height: 24),

            if (_loadingPricing)
              const Center(
                child:
                CircularProgressIndicator(),
              )
            else if (_pricing != null)
              CheckoutSummary(
                subtotal:
                _pricing!.subtotal,
                deliveryFee:
                _pricing!.deliveryFee,
                serviceFee:
                _pricing!.serviceFee,
                vat: _pricing!.vat,
                total: _pricing!.total,
              )
            else
              CheckoutSummary(
                subtotal:
                cart.subtotal,
                deliveryFee:
                cart.deliveryFee,
                serviceFee:
                cart.serviceFee,
                vat: 0,
                total: cart.total,
              ),

            const SizedBox(height: 24),
          ],
        ),
      ),
    );
  }

  void _continue() {
    final address =
        _selectedAddress?.trim() ?? "";

    if (address.isEmpty) {
      ScaffoldMessenger.of(context)
          .showSnackBar(
        const SnackBar(
          content: Text(
            "Please select a delivery address.",
          ),
        ),
      );
      return;
    }

    if (!_formKey.currentState!
        .validate()) {
      return;
    }

    context.push(
      "/payment",
      extra: {
        "cart": widget.cart,
        "pricing": _pricing,
        "address": address,
        "phone":
        _phoneController.text.trim(),
        "note":
        _notesController.text.trim(),
      },
    );
  }
}