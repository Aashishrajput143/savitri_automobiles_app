import 'package:flutter/material.dart';

/// Reusable widget to dismiss the keyboard when tapping outside a TextField.
Widget dismissKeyboardOnTap({required Widget child}) {
  return GestureDetector(
    onTap: () {
      FocusManager.instance.primaryFocus?.unfocus();
    },
    child: child,
  );
}
