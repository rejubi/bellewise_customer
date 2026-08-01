import 'package:flutter/material.dart';

class AppLogo extends StatelessWidget {
  final double width;

  const AppLogo({
    super.key,
    this.width = 150,
  });

  @override
  Widget build(BuildContext context) {
    return Hero(
      tag: 'logo',
      child: Image.asset(
        'assets/images/logo.png',
        width: width,
        fit: BoxFit.contain,
      ),
    );
  }
}