import 'package:flutter/services.dart';

class ExpiryDateFormatter extends TextInputFormatter {
  @override
  TextEditingValue formatEditUpdate(
      TextEditingValue oldValue, TextEditingValue newValue) {
    String text = newValue.text.replaceAll(RegExp(r'[^0-9]'), '');

    if (text.length > 4) {
      text = text.substring(0, 4);
    }

    String formattedText = '';
    for (int i = 0; i < text.length; i++) {
      if (i == 2) formattedText += '/';
      formattedText += text[i];
    }

    return TextEditingValue(
      text: formattedText,
      selection: TextSelection.collapsed(offset: formattedText.length),
    );
  }
}

class PhoneNumberFormatter extends TextInputFormatter {
  final VoidCallback onComplete;

  PhoneNumberFormatter({required this.onComplete});

  @override
  TextEditingValue formatEditUpdate(
    TextEditingValue oldValue,
    TextEditingValue newValue,
  ) {
    final newText = newValue.text
        .replaceAll(RegExp(r'\D'), ''); // Remove non-digit characters
    final buffer = StringBuffer();

    for (int i = 0; i < newText.length; i++) {
      if (i == 3 || i == 6)
        buffer.write('-'); // Add hyphen after 3rd and 6th digits
      buffer.write(newText[i]);
    }

    final formattedText = buffer.toString();

    // Trigger the onComplete callback when 10 digits are entered
    if (newText.length == 10) {
      onComplete();
    }

    final newSelectionIndex =
        newValue.selection.baseOffset + (formattedText.length - newText.length);

    return TextEditingValue(
      text: formattedText,
      selection: TextSelection.collapsed(
        offset: newSelectionIndex > formattedText.length
            ? formattedText.length
            : newSelectionIndex,
      ),
    );
  }
}

class NoSpecialCharactersFormatter extends TextInputFormatter {
  final RegExp _regex = RegExp(r'^[a-zA-Z0-9\s@.]*$');

  @override
  TextEditingValue formatEditUpdate(
      TextEditingValue oldValue, TextEditingValue newValue) {
    if (_regex.hasMatch(newValue.text)) {
      return newValue;
    }
    return oldValue;
  }
}

bool isValidFullName(String fullName) {
  fullName = fullName.trim(); // Remove leading/trailing spaces
  return RegExp(r'^[A-Za-z]{2,} [A-Za-z]{2,}$').hasMatch(fullName);
}
