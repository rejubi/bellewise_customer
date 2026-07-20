import 'package:flutter/material.dart';

class AuthLogo extends StatelessWidget {
  final double width;
  final String image;

  const AuthLogo({
    super.key,
    required this.image,
    this.width = 180,
  });

  @override
  Widget build(BuildContext context) {
    return Image.asset(
      image,
      width: width,
      fit: BoxFit.contain,
    );
  }
}