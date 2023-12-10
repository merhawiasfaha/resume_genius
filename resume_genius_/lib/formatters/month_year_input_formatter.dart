import 'package:flutter/services.dart';

class MonthYearInputFormatter extends TextInputFormatter {
  @override
  TextEditingValue formatEditUpdate(
      TextEditingValue oldValue, TextEditingValue newValue) {
    final StringBuffer newText = StringBuffer();

    for (int i = 0; i < newValue.text.length; i++) {
      if (RegExp(r'[0-9]').hasMatch(newValue.text[i])) {
        // Allow numbers
        newText.write(newValue.text[i]);

        if (newText.length == 2) {
          // Insert a forward slash after the first two digits
          newText.write('/');
        }

        if (newText.length == 3) {
          // Allow only 4 digits after the slash
          newText.write(newValue.text.substring(i + 1, i + 5));
          break;
        }
      } else if (newValue.text[i] == '/' && newText.length >= 3) {
        // Allow the forward slash only if there are at least two digits before it
        newText.write('/');
      }
    }

    if (newValue.text.length < oldValue.text.length) {
      // Handle the case where the user is deleting characters
      newText.clear();
      newText.write(newValue.text);
    }

    final TextEditingValue modifiedValue = TextEditingValue(
      text: newText.toString(),
      selection: TextSelection.collapsed(offset: newText.length),
    );

    return modifiedValue;
  }
}