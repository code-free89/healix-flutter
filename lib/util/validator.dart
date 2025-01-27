import 'package:flutter/services.dart';

class Validator {
  static String? validateEmail(String? value) {
    final emailRegex = RegExp(r'^[\w-.]+@([\w-]+\.)+[\w-]{2,4}$');

    if (value == null || value.isEmpty) {
      return 'Please enter an email';
    } else if (!emailRegex.hasMatch(value)) {
      return 'Please enter a valid email address';
    }
    return null;
  }

  static String? validatePassword(String? value) {
    if (value == null || value.isEmpty) {
      return 'Please enter a password';
    }
    return null;
  }

  static String? validateUsername(String? value) {
    if (value == null || value.isEmpty) {
      return 'Please enter a username';
    }
    return null;
  }

  static String? validateAge(String? value) {
    if (value != null && value.isNotEmpty) {
      final int? age = int.parse(value);
      if (age != null && age > 100) {
        return 'Cannot be more than 100';
      }
    }
    return null;
  }

  static String? validateWeight(String? value) {
    if (value != null && value.isNotEmpty) {
      final double? weight = double.tryParse(value);
      if (weight != null && weight > 400) {
        return 'Cannot be more than 400';
      }
      if (value.contains('.') && value.split('.').last.length > 2) {
        return 'Maximum of two decimal places allowed';
      }
    }
    return null;
  }

  static String? validateHeight(String? value) {
    if (value != null && value.isNotEmpty) {
      final double? height = double.tryParse(value);
      if (height != null && height > 280) {
        return 'Cannot be more than 280';
      }
      if (value.contains('.') && value.split('.').last.length > 2) {
        return 'Maximum of two decimal places allowed';
      }
    }
    return null;
  }
}

class MaxNumberInputFormatter extends TextInputFormatter {
  final int max;

  MaxNumberInputFormatter(this.max);

  @override
  TextEditingValue formatEditUpdate(
    TextEditingValue oldValue,
    TextEditingValue newValue,
  ) {
    // Check if the new input is a valid number and is within the max limit
    if (newValue.text.isEmpty) return newValue; // Allow empty input

    final int? number = int.tryParse(newValue.text);
    if (number != null && number <= max) {
      return newValue;
    }

    // If input exceeds the max value, keep the old value
    return oldValue;
  }
}

// Modify the input formatter for the "Weight" field
class WeightFormatter extends TextInputFormatter {
  @override
  TextEditingValue formatEditUpdate(
      TextEditingValue oldValue, TextEditingValue newValue) {
    final String newText = newValue.text;

    // Ensure value is numeric and <= 3 digits
    if (RegExp(r'^\d{1,3}\$').hasMatch(newText)) {
      return newValue;
    }

    return oldValue; // Revert to the old value if invalid
  }
}
