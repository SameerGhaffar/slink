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

  static LinearGradient outerLinearGradient() {
    return const LinearGradient(
      colors: [
        Color(0xffD8DFED),
        Color(0xff96A9D0),
        Color(0xff84759B),
      ],
      begin: Alignment.topCenter,
      end: Alignment.bottomCenter,
    );
  }

  static LinearGradient innerBodyLinearGradient() {
    return const LinearGradient(
      colors: [Color(0xff29C5FF), Color(0xff0D90CB), Color(0xff14AAFD)],
      begin: Alignment.topCenter,
      end: Alignment.bottomCenter,
    );
  }

  static LinearGradient top() {
    return const LinearGradient(
      colors: [
        Color(0xff705AB6),
        Color(0xff181D3B),
      ],
      begin: Alignment.topCenter,
      end: Alignment.bottomCenter,
    );
  }

  static LinearGradient bottom() {
    return const LinearGradient(
      colors: [
        Color(0xff84759B),
        Color(0xff96A9D0),
        Color(0xffD8DFED),
      ],
      begin: Alignment.topCenter,
      end: Alignment.bottomCenter,
    );
  }

  static LinearGradient right() {
    return const LinearGradient(
      colors: [
        Color(0xff7571A3),
        Color(0xff595173),
      ],
      begin: Alignment.centerRight,
      end: Alignment.centerLeft,
    );
  }

  static LinearGradient left() {
    return const LinearGradient(
      colors: [
        Color(0xff7571A3),
        Color(0xff595173),
      ],
      begin: Alignment.centerLeft,
      end: Alignment.centerRight,
    );
  }
}
