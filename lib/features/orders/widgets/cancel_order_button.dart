import 'package:flutter/material.dart';

import '../../../app/theme.dart';
import '../controllers/order_controller.dart';
import '../models/order_model.dart';

class CancelOrderButton extends StatefulWidget {
  final OrderModel order;
  final OrderController controller;

  const CancelOrderButton({
    super.key,
    required this.order,
    required this.controller,
  });

  @override
  State<CancelOrderButton> createState() =>
      _CancelOrderButtonState();
}

class _CancelOrderButtonState
    extends State<CancelOrderButton> {

  bool loading = false;

  Future<void> _cancel() async {

    final confirm =
    await showDialog<bool>(

      context: context,

      builder: (_) {
        return AlertDialog(

          title: const Text(
            "Cancel Order",
          ),

          content: const Text(
            "Are you sure you want to cancel this order?",
          ),

          actions: [

            TextButton(
              onPressed: () {
                Navigator.pop(
                  context,
                  false,
                );
              },

              child: const Text(
                "No",
              ),
            ),

            FilledButton(
              onPressed: () {
                Navigator.pop(
                  context,
                  true,
                );
              },

              child: const Text(
                "Yes",
              ),
            ),
          ],
        );
      },
    );

    if (confirm != true) {
      return;
    }

    setState(() {
      loading = true;
    });

    try {

      await widget.controller.cancelOrder(
        widget.order.id,
      );

      if (!mounted) return;

      ScaffoldMessenger.of(context)
          .showSnackBar(

        const SnackBar(

          content: Text(
            "Order cancelled successfully.",
          ),

        ),
      );

    } catch (e) {

      if (!mounted) return;

      ScaffoldMessenger.of(context)
          .showSnackBar(

        SnackBar(

          content: Text(
            e.toString(),
          ),

        ),
      );
    }

    if (!mounted) return;

    setState(() {
      loading = false;
    });
  }

  @override
  Widget build(BuildContext context) {

    if (!widget.order.canCancel) {
      return const SizedBox.shrink();
    }

    return SizedBox(
      width: double.infinity,

      child: OutlinedButton.icon(

        onPressed:
        loading ? null : _cancel,

        icon: loading

            ? const SizedBox(
          width: 18,
          height: 18,
          child:
          CircularProgressIndicator(
            strokeWidth: 2,
          ),
        )

            : const Icon(
          Icons.cancel_outlined,
        ),

        label: Text(
          loading
              ? "Cancelling..."
              : "Cancel Order",
        ),

        style: OutlinedButton.styleFrom(

          foregroundColor: Colors.red,

          side: const BorderSide(
            color: Colors.red,
          ),

          padding:
          const EdgeInsets.symmetric(
            vertical: 15,
          ),

          shape:
          RoundedRectangleBorder(
            borderRadius:
            BorderRadius.circular(12),
          ),
        ),
      ),
    );
  }
}