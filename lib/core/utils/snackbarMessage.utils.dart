import 'package:flutter/material.dart';

SnackBar snackbarMessage(String message, Color colorType) {
  return SnackBar(
    showCloseIcon: true,
    elevation: 8,
    content: Text(message),
    backgroundColor: colorType,
    behavior: SnackBarBehavior.floating,
    duration: const Duration(seconds: 3),
    shape: RoundedRectangleBorder(
      borderRadius: BorderRadius.circular(12),
    ),
    margin: const EdgeInsets.symmetric(horizontal: 20, vertical: 10),
  );
}
