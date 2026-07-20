import 'package:flutter/services.dart';

class PhoneNumberFormatter extends TextInputFormatter {
  @override
  TextEditingValue formatEditUpdate(
      TextEditingValue oldValue,
      TextEditingValue newValue,
      ) {
    String digits = newValue.text.replaceAll(' ', '');

    if (digits.length > 11) {
      digits = digits.substring(0, 11);
    }

    String formatted = '';

    for (int i = 0; i < digits.length; i++) {
      formatted += digits[i];

      if (i == 2 || i == 6) {
        if (i != digits.length - 1) {
          formatted += ' ';
        }
      }
    }

    return TextEditingValue(
      text: formatted,
      selection: TextSelection.collapsed(
        offset: formatted.length,
      ),
    );
  }
}