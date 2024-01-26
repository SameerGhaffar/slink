import 'package:flutter/material.dart';

class Functions {
  static showSnackBar(BuildContext context, String message) {
    var snackBar = SnackBar(
      duration: const Duration(seconds: 3),
      content: Text(
        message,
        style: TextStyle(
          color: Colors.white, // Text color
          fontSize: 16.0, // Text size
          fontWeight: FontWeight.bold, // Text weight
        ),
      ),
      backgroundColor: Colors.black, // SnackBar background color
      behavior: SnackBarBehavior.floating, // Floating style
      shape: RoundedRectangleBorder(
        borderRadius: BorderRadius.circular(10.0), // Rounded corners
      ),
      action: SnackBarAction(
        label: 'Close',
        onPressed: () {
          // Action to close the SnackBar
        },
      ),
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
