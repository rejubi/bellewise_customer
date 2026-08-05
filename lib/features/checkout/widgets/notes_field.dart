import 'package:flutter/material.dart';

class NotesField extends StatelessWidget {
  final TextEditingController controller;

  const NotesField({
    super.key,
    required this.controller,
  });

  @override
  Widget build(BuildContext context) {
    return TextFormField(
      controller: controller,
      maxLines: 4,
      decoration: const InputDecoration(
        labelText: "Delivery Notes (Optional)",
        hintText:
        "Apartment number, landmarks, gate code...",
        alignLabelWithHint: true,
        border: OutlineInputBorder(),
      ),
    );
  }
}