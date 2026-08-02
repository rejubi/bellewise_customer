import 'package:flutter/material.dart';

class VendorLoading extends StatelessWidget {
  const VendorLoading({super.key});

  @override
  Widget build(BuildContext context) {
    return const Center(
      child: CircularProgressIndicator(),
    );
  }
}