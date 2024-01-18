import 'package:flutter/material.dart';
import 'package:slink/utils/extensions.dart';

class MarginWidget extends StatelessWidget {
  const MarginWidget(
      {super.key,
      this.factor = 1,
      this.isSliver = false,
      this.isHorizontal = false});

  final bool isSliver;
  final bool isHorizontal;
  final double factor;

  @override
  Widget build(BuildContext context) {
    double height = context.height;
    double width = context.width;
    if (isSliver) {
      return SliverToBoxAdapter(
        child: sizedBox(height, width),
      );
    } else {
      return sizedBox(height, width);
    }
  }

  Widget sizedBox(double height, double width) {
    return SizedBox(
      height: isHorizontal ? null : height * 0.02 * factor,
      width: isHorizontal ? width * 0.02 * factor : null,
    );
  }
}
