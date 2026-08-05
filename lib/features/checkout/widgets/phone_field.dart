import 'package:flutter/material.dart';

class PhoneField extends StatelessWidget {
  final TextEditingController controller;

  const PhoneField({
    super.key,
    required this.controller,
  });

  @override
  Widget build(BuildContext context) {
    return TextFormField(
      controller: controller,
      keyboardType: TextInputType.phone,
      decoration: const InputDecoration(
        labelText: "Phone Number",
        prefixIcon: Icon(Icons.phone),
        border: OutlineInputBorder(),
      ),
      validator: (value) {
        if (value == null ||
            value.trim().isEmpty) {
          return "Phone number is required";
        }

        return null;
      },
    );
  }
}