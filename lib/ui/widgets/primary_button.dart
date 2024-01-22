import 'package:flutter/material.dart';
import 'package:slink/utils/extensions.dart';
import 'package:slink/utils/state.dart';

class PrimaryButton extends StatelessWidget {
  const PrimaryButton({
    super.key,
    required this.text,
    this.bColor = Colors.black,
    this.color = Colors.white,
    this.onPressed,
    this.isLoading = DataState.success,
  });

  final String text;
  final Color bColor;
  final Color color;
  final void Function()? onPressed;
  final DataState isLoading;

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
        child: textWithLoading(),
      ),
    );
  }

  Widget textWithLoading() {
    if (isLoading == DataState.loading) {
      return CircularProgressIndicator(
        color: color,
        backgroundColor: Colors.grey,
      );
    } else if (isLoading == DataState.fail) {
      return Text(
        text,
        style: const TextStyle(color: Colors.red),
      );
    } else {
      return Text(
        text,
        style: TextStyle(color: color),
      );
    }
  }
}
