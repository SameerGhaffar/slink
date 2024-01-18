import 'package:flutter/material.dart';

class Functions {
  static showSnackBar(BuildContext context, String message) {
    var snackBar = SnackBar(
      duration: const Duration(milliseconds: 1000),
      content: Text(
        message,
      ),
      backgroundColor: Colors.white,
    );
    ScaffoldMessenger.of(context).showSnackBar(snackBar);
  }

  static String? validator(value) {
    if (value == null || value.isEmpty) {
      return "Please enter some text";
    } else {
      return null;
    }
  }
}
