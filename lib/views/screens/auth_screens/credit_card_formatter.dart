import 'package:flutter/services.dart';

class CreditCardFormatter extends TextInputFormatter {
  @override
  TextEditingValue formatEditUpdate(
      TextEditingValue oldValue, TextEditingValue newValue) {
    String digitsOnly =
        newValue.text.replaceAll(RegExp(r'\D'), ''); // Remove non-numeric chars
    String formattedText = _formatCardNumber(digitsOnly);

    return TextEditingValue(
      text: formattedText,
      selection: TextSelection.collapsed(offset: formattedText.length),
    );
  }

  String _formatCardNumber(String input) {
    if (input.isEmpty) return input;

    String cardType = detectCardType(input);

    if (cardType == 'AMEX') {
      return _applyFormat(input, [4, 6, 5]); // Amex format 4-6-5
    } else if (cardType == 'DINERS') {
      return _applyFormat(input, [4, 6, 4]); // Diners format 4-6-4
    } else {
      return _applyFormat(input, [4, 4, 4, 4]); // Default 4-4-4-4
    }
  }

  String _applyFormat(String input, List<int> pattern) {
    StringBuffer buffer = StringBuffer();
    int start = 0;

    for (int length in pattern) {
      if (start + length > input.length) {
        buffer.write(input.substring(start));
        break;
      }
      buffer.write(input.substring(start, start + length));
      buffer.write(' ');
      start += length;
    }

    return buffer.toString().trim();
  }

  String detectCardType(String input) {
    if (input.startsWith('34') || input.startsWith('37')) {
      return 'AMEX';
    } else if (RegExp(
            r'^(51|52|53|54|55|222[1-9]|22[3-9]\d|2[3-6]\d\d|27[01]\d|2720)')
        .hasMatch(input)) {
      return 'MASTERCARD';
    } else if (input.startsWith('4')) {
      return 'VISA';
    } else if (RegExp(r'^(6011|622[1-9]|64[4-9]|65)').hasMatch(input)) {
      return 'DISCOVER';
    } else if (RegExp(r'^(300|301|302|303|304|305|36|38)').hasMatch(input)) {
      return 'DINERS';
    }
    return 'UNKNOWN';
  }
}
