import 'package:flutter/material.dart';

class AppBarWidget extends StatelessWidget implements PreferredSizeWidget {
  const AppBarWidget(
      {super.key,
      required this.title,
      this.isTitleCenter = true,
      this.fontSize = 20});

  final String title;
  final bool isTitleCenter;
  final double fontSize;

  @override
  Widget build(BuildContext context) {
    return AppBar(
      centerTitle: isTitleCenter,
      title: Text(
        title,
        style: TextStyle(
          fontSize: fontSize,
          fontWeight: FontWeight.bold,
        ),
      ),
    );
  }

  @override
  Size get preferredSize => const Size.fromHeight(kToolbarHeight);
}
