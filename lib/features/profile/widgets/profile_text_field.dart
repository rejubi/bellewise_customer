import 'package:flutter/material.dart';

import '../../../app/theme.dart';

class ProfileTextField extends StatelessWidget {
  final TextEditingController controller;
  final String label;
  final bool readOnly;
  final TextInputType keyboardType;
  final String? Function(String?)? validator;
  final int maxLines;

  const ProfileTextField({
    super.key,
    required this.controller,
    required this.label,
    this.readOnly = false,
    this.keyboardType = TextInputType.text,
    this.validator,
    this.maxLines = 1,
  });

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.only(
        bottom: 18,
      ),
      child: TextFormField(
        controller: controller,
        readOnly: readOnly,
        keyboardType: keyboardType,
        validator: validator,
        maxLines: maxLines,
        decoration: InputDecoration(
          labelText: label,

          filled: true,
          fillColor: readOnly
              ? Colors.grey.shade100
              : Colors.white,

          border: OutlineInputBorder(
            borderRadius:
            BorderRadius.circular(14),
          ),

          enabledBorder: OutlineInputBorder(
            borderRadius:
            BorderRadius.circular(14),
            borderSide: BorderSide(
              color: Colors.grey.shade300,
            ),
          ),

          focusedBorder: OutlineInputBorder(
            borderRadius:
            BorderRadius.circular(14),
            borderSide: const BorderSide(
              color: AppColors.primary,
              width: 2,
            ),
          ),

          suffixIcon: readOnly
              ? const Icon(
            Icons.lock_outline,
            size: 18,
          )
              : null,
        ),
      ),
    );
  }
}