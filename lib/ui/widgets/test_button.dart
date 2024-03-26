import 'package:flutter/material.dart';
import 'package:slink/utils/colors.dart';

class Frame extends StatelessWidget {
  final Widget child;
  final Color? bgColor;
  final LinearGradient? bgGradient;

  const Frame({
    super.key,
    required this.child,
    this.bgColor,
    this.bgGradient,
  });

  @override
  Widget build(BuildContext context) {
    return frameWidget();
  }

  CustomPaint frameWidget() {
    return CustomPaint(
      painter: NamePlatePainter(
        bgGradient: bgGradient,
        bgColor: bgColor,
        borderGradient: CColors.outerLinearGradient(),
      ),
      child: Padding(
        padding: const EdgeInsets.symmetric(vertical: 2.2, horizontal: 1.7),
        child: CustomPaint(
          painter: NamePlatePainter2(
            bottomBorderGradient: CColors.bottom(),
            leftBorderGradient: CColors.left(),
            rightBorderGradient: CColors.right(),
            topBorderGradient: CColors.top(),
          ),
          child: Center(child: child),
        ),
      ),
    );
  }
}

class NamePlatePainter extends CustomPainter {
  final Color? bgColor;
  final LinearGradient? bgGradient;
  final LinearGradient? borderGradient;

  NamePlatePainter({
    this.bgGradient,
    this.borderGradient,
    this.bgColor,
  });

  @override
  void paint(Canvas canvas, Size size) {
    var paint = Paint()..color = Colors.transparent;
    var path = Path();

    path.moveTo(0, 0); // Set starting x-coordinate to 0
    path.lineTo(size.width, 0); // Set ending x-coordinate to size.width
    path.arcToPoint(
      Offset(size.width, size.height),
      radius: Radius.circular(size.height), // Circular corner on the right
    );
    path.lineTo(0, size.height);
    path.arcToPoint(
      const Offset(0, 0),
      radius: Radius.circular(size.height), // Circular corner on the left
    );

    path.close();

    if (bgGradient != null) {
      paint = Paint()
        ..shader = bgGradient!
            .createShader(Rect.fromLTWH(0, 0, size.width, size.height));
    }
    if (bgColor != null) {
      paint = Paint()..color = bgColor!;
    }
    canvas.drawPath(path, paint);
    if (borderGradient != null) {
      var borderPaint = Paint()
        ..shader = borderGradient!
            .createShader(Rect.fromLTWH(0, 0, size.width, size.height))
        ..style = PaintingStyle.stroke
        ..strokeWidth = 3;
      canvas.drawPath(path, borderPaint);
    }
  }

  @override
  bool shouldRepaint(CustomPainter oldDelegate) => false;
}

class NamePlatePainter2 extends CustomPainter {
  final Color? bgColor;
  final LinearGradient? bgGradient;
  final LinearGradient? topBorderGradient;
  final LinearGradient? rightBorderGradient;
  final LinearGradient? bottomBorderGradient;
  final LinearGradient? leftBorderGradient;

  NamePlatePainter2({
    this.bgGradient,
    this.topBorderGradient,
    this.rightBorderGradient,
    this.bottomBorderGradient,
    this.leftBorderGradient,
    this.bgColor,
  });

  @override
  void paint(Canvas canvas, Size size) {
    var paint = Paint()..color = Colors.transparent;

    // Background path
    var bgPath = Path()
      ..moveTo(0, 0)
      ..lineTo(size.width, 0)
      ..arcToPoint(
        Offset(size.width, size.height),
        radius: Radius.circular(size.height),
      )
      ..lineTo(0, size.height)
      ..arcToPoint(
        const Offset(0, 0),
        radius: Radius.circular(size.height),
      )
      ..close();

    if (bgGradient != null) {
      paint = Paint()
        ..shader = bgGradient!
            .createShader(Rect.fromLTWH(0, 0, size.width, size.height));
    }
    if (bgColor != null) {
      paint = Paint()..color = bgColor!;
    }
    canvas.drawPath(bgPath, paint);

    // Border paths for each side
    if (topBorderGradient != null) {
      var topBorderPath = Path()
        ..moveTo(0, 0)
        ..lineTo(size.width, 0)
        ..close();

      var topBorderPaint = Paint()
        ..shader = topBorderGradient!
            .createShader(Rect.fromLTWH(0, 0, size.width, size.height / 2))
        ..style = PaintingStyle.stroke
        ..strokeWidth = 2.5;

      canvas.drawPath(topBorderPath, topBorderPaint);
    }
    if (bottomBorderGradient != null) {
      var bottomBorderPath = Path()
        ..moveTo(0, size.height)
        ..lineTo(size.width, size.height)
        ..close();

      var bottomBorderPaint = Paint()
        ..shader = bottomBorderGradient!.createShader(
            Rect.fromLTWH(0, size.height / 2, size.width, size.height / 2))
        ..style = PaintingStyle.stroke
        ..strokeWidth = 2.5;

      canvas.drawPath(bottomBorderPath, bottomBorderPaint);
    }

    if (rightBorderGradient != null) {
      var rightBorderPath = Path()
        ..moveTo(size.width, 0)
        ..arcToPoint(
          Offset(size.width, size.height),
          radius: Radius.circular(size.height),
        );

      var rightBorderPaint = Paint()
        ..shader = rightBorderGradient!.createShader(
            Rect.fromLTWH(size.width / 2, 0, size.width / 2, size.height))
        ..style = PaintingStyle.stroke
        ..strokeWidth = 2.5;

      canvas.drawPath(rightBorderPath, rightBorderPaint);
    }
    if (leftBorderGradient != null) {
      var leftBorderPath = Path()
        ..moveTo(0, size.height)
        ..arcToPoint(
          const Offset(0, 0),
          radius: Radius.circular(size.height),
        );
      var leftBorderPaint = Paint()
        ..shader = leftBorderGradient!.createShader(
            Rect.fromLTWH(size.width / 2, 0, size.width / 2, size.height))
        ..style = PaintingStyle.stroke
        ..strokeWidth = 2.5;

      canvas.drawPath(leftBorderPath, leftBorderPaint);
    }
  }

  @override
  bool shouldRepaint(CustomPainter oldDelegate) => false;
}
