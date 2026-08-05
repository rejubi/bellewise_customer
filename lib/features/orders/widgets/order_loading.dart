import 'package:flutter/material.dart';

class OrderLoading extends StatelessWidget {
  const OrderLoading({
    super.key,
  });

  @override
  Widget build(BuildContext context) {
    return const Center(
      child: CircularProgressIndicator(),
    );
  }
}