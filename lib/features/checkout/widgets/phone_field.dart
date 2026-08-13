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
      maxLength: 14,
      decoration: const InputDecoration(
        labelText: "Phone Number",
        hintText: "08012345678",
        prefixIcon: Icon(Icons.phone),
        border: OutlineInputBorder(),
        counterText: "",
      ),
      validator: (value) {
        final phone = value?.trim() ?? "";

        // Empty
        if (phone.isEmpty) {
          return "Phone number is required";
        }

        // Remove spaces for validation
        final normalized = phone.replaceAll(" ", "");

        // Nigerian local format: 08012345678
        final localPattern = RegExp(
          r'^0[789][01][0-9]{8}$',
        );

        // Nigerian international format: +2348012345678
        final internationalPattern = RegExp(
          r'^\+234[789][01][0-9]{8}$',
        );

        if (!localPattern.hasMatch(normalized) &&
            !internationalPattern.hasMatch(normalized)) {
          return "Enter a valid phone number";
        }

        return null;
      },
    );
  }
}