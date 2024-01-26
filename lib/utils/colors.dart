import 'package:flutter/material.dart';

class CColors {
  static List<List<Color>> ballColors = [
    [
      const Color.fromRGBO(255, 255, 0, 0.90), // Yellow
      const Color.fromRGBO(255, 255, 0, 0.50), // Yellow
      const Color.fromRGBO(255, 255, 0, 0.39), // Yellow
    ],
    [
      const Color.fromRGBO(0, 255, 0, 0.90), // Green
      const Color.fromRGBO(0, 255, 0, 0.50), // Green
      const Color.fromRGBO(0, 255, 0, 0.39), // Green
    ],
    [
      const Color.fromRGBO(0, 0, 255, 0.90), // Blue
      const Color.fromRGBO(0, 0, 255, 0.50), // Blue
      const Color.fromRGBO(0, 0, 255, 0.39), // Blue
    ],
    [
      const Color.fromRGBO(255, 0, 0, 0.90), // Red
      const Color.fromRGBO(255, 0, 0, 0.50), // Red
      const Color.fromRGBO(255, 0, 0, 0.39), // Red
    ],
    [
      const Color.fromRGBO(255, 105, 180, 0.90), // Pink
      const Color.fromRGBO(255, 105, 180, 0.50), // Pink
      const Color.fromRGBO(255, 105, 180, 0.39), // Pink
    ],
    [
      const Color.fromRGBO(255, 165, 0, 0.90), // Orange
      const Color.fromRGBO(255, 165, 0, 0.50), // Orange
      const Color.fromRGBO(255, 165, 0, 0.39), // Orange
    ],
    [
      const Color.fromRGBO(0, 0, 0, 0.90), // Black
      const Color.fromRGBO(0, 0, 0, 0.50), // Black
      const Color.fromRGBO(0, 0, 0, 0.39), // Black
    ],

    [
      const Color.fromRGBO(128, 0, 0, 0.90), // Maroon
      const Color.fromRGBO(128, 0, 0, 0.50), // Maroon
      const Color.fromRGBO(128, 0, 0, 0.39), // Maroon
    ]
  ];

  static Gradient ballGradient({double? radius, required List<Color> colors}) {
    return RadialGradient(radius: radius ?? 4, colors: colors);
  }
}
