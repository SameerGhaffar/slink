import 'package:flutter/material.dart';
import 'package:slink/utils/extensions.dart';

class TextButtonWidget extends StatelessWidget {
  const TextButtonWidget({
    super.key,
    required this.text,
    this.bColor = Colors.black,
    this.textColor = Colors.white,
    this.onPressed,
  });

  final String text;
  final Color bColor;
  final Color textColor;
  final void Function()? onPressed;

  @override
  Widget build(BuildContext context) {
    return TextButton(
      style: ButtonStyle(
        backgroundColor: bColor.toMaterialStateProperty(),
        shape: RoundedRectangleBorder(
          side: BorderSide(
            color: Colors.white.withOpacity(0.2),
            width: 4,
          ),
          borderRadius: BorderRadius.circular(12.0),
        ).toMaterialStateProperty(),
      ),
      onPressed: onPressed,
      child: Padding(
        padding: const EdgeInsets.all(5.0),
        child: Text(
          text,
          style: TextStyle(color: textColor),
        ),
      ),
    );
  }
}
