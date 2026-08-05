import 'package:flutter/material.dart';

import '../../../app/theme.dart';

class SaveProfileButton extends StatelessWidget {
  final bool loading;
  final VoidCallback onPressed;

  const SaveProfileButton({
    super.key,
    required this.loading,
    required this.onPressed,
  });

  @override
  Widget build(BuildContext context) {
    return SizedBox(
      height: 56,
      width: double.infinity,
      child: ElevatedButton(
        onPressed: loading
            ? null
            : onPressed,
        style: ElevatedButton.styleFrom(
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
        child: loading
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
          "Save Changes",
          style: TextStyle(
            fontSize: 16,
            fontWeight:
            FontWeight.w600,
          ),
        ),
      ),
    );
  }
}