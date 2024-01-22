import 'dart:math';
import 'dart:ui';
import 'package:flame/events.dart';
import 'package:flutter/material.dart';
import 'package:flame/game.dart';
import 'package:slink/ui/widgets/margin_widget.dart';

class BonusRound extends StatefulWidget {
  const BonusRound({super.key});

  @override
  State<BonusRound> createState() => _BonusRoundState();
}

class _BonusRoundState extends State<BonusRound> {
  late BubbleGame bubbleGame;

  @override
  void initState() {
    bubbleGame = BubbleGame();
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        body: Column(
      children: [
        const MarginWidget(
          factor: 3,
        ),
        const Padding(
          padding: EdgeInsets.symmetric(horizontal: 16),
          child: Text(
            "Keep tapping on a category that you want to eliminate until it’s bubble pops. Last one standing will win",
            textAlign: TextAlign.center,
          ),
        ),
        const MarginWidget(
          factor: 1,
        ),
        Expanded(
          child: Container(
            margin: const EdgeInsets.symmetric(horizontal: 10),
            decoration: BoxDecoration(
                borderRadius: BorderRadius.circular(16),
                color: Colors.white.withOpacity(0.5)),
            child: GestureDetector(
              child: GestureDetector(
                onTapDown: (details) {
                  print("tap");
                  bubbleGame.onTapDown(details);
                },
                child: GameWidget(
                  game: bubbleGame,
                ),
              ),
            ),
          ),
        )
      ],
    ));
  }
}

class BubbleGame with Game {
  late List<Ball> balls;
  late double screenWidth, screenHeight;

  @override
  backgroundColor() {
    return Colors.transparent;
  }

  @override
  Future<void>? onLoad() async {
    super.onLoad();
    screenWidth = MediaQueryData.fromWindow(window).size.width;
    screenHeight = MediaQueryData.fromWindow(window).size.height;

    // Initialize 10 balls with random positions
    balls = List.generate(
      10,
      (index) => Ball(
        index: index,
        position: Offset(
          Random().nextDouble() * screenWidth,
          Random().nextDouble() * screenHeight,
        ),
        speed: 100.0,
        direction: Offset(Random().nextDouble(), Random().nextDouble()),
      ),
    );
  }

  @override
  void render(Canvas canvas) {
    // Set background color to white
    final ball = canvas.drawRect(Rect.fromLTWH(0, 0, screenWidth, screenHeight),
        Paint()..color = Colors.transparent);

    // Draw each ball
    for (final ball in balls) {
      ball.render(canvas);
    }
  }

  @override
  void update(double dt) {
    // Update each ball's position
    for (int i = 0; i < balls.length; i++) {
      balls[i].update(dt, screenWidth, screenHeight);

      // Check for collisions with other balls
      for (int j = i + 1; j < balls.length; j++) {
        if (balls[i].collidesWith(balls[j])) {
          // Handle collision by adjusting positions
          balls[i].resolveCollision(balls[j]);
        }
      }
    }
  }

  @override
  void onTapDown(TapDownDetails details) {
    // Check if any ball is tapped
    for (final ball in balls) {
      if (ball.isTapped(details)) {
        print("Tapped on ball with index: ${ball.index}");
      } else {
        print("touch");
      }
    }
  }

// Other methods...

// Ball class
}

class Ball {
  late int index;
  late Paint _paint;
  late Rect _ballPos;
  late Offset _direction;
  late double _speed;

  Ball({
    required this.index,
    required Offset position,
    required double speed,
    required Offset direction,
  }) {
    _paint = Paint()..color = Colors.red;
    final ballSize = 50.0;
    _ballPos =
        Rect.fromCenter(center: position, width: ballSize, height: ballSize);
    _speed = speed;
    _direction = direction;
  }
  bool collidesWith(Ball other) {
    double distance = calculateDistance(_ballPos.center, other._ballPos.center);
    double totalRadius = _ballPos.width / 2 + other._ballPos.width / 2;
    return distance <= totalRadius;
  }
  void resolveCollision(Ball other) {
    // Move the balls away from each other
    double angle = atan2(other._ballPos.center.dy - _ballPos.center.dy, other._ballPos.center.dx - _ballPos.center.dx);
    double overlap = (_ballPos.width / 2 + other._ballPos.width / 2) - calculateDistance(_ballPos.center, other._ballPos.center);

    double dx = cos(angle) * overlap / 2;
    double dy = sin(angle) * overlap / 2;

    _ballPos = _ballPos.translate(-dx, -dy);
    other._ballPos = other._ballPos.translate(dx, dy);

    // Swap direction to simulate bouncing off
    Offset tempDirection = _direction;
    _direction = other._direction;
    other._direction = tempDirection;
  }
  void render(Canvas canvas) {
    // Draw the ball
    canvas.drawOval(_ballPos, _paint);

    // Draw the index inside the ball
    TextPainter textPainter = TextPainter(
      text: TextSpan(
        text: index.toString(),
        style: TextStyle(
          color: Colors.white,
          fontSize: 16.0,
          fontWeight: FontWeight.bold,
        ),
      ),
      textAlign: TextAlign.center,
      textDirection: TextDirection.ltr,
    );

    textPainter.layout();
    textPainter.paint(
      canvas,
      Offset(
        _ballPos.center.dx - textPainter.width / 2,
        _ballPos.center.dy - textPainter.height / 2,
      ),
    );
  }

  void update(double dt, double screenWidth, double screenHeight) {
    // Update the ball's position
    final newPosition = _ballPos.center + _direction * _speed * dt;

    // Check for collisions with walls and bounce back
    if (newPosition.dx - _ballPos.width / 2 < 0 ||
        newPosition.dx + _ballPos.width / 2 > screenWidth) {
      _direction = Offset(-_direction.dx, _direction.dy);
    }

    if (newPosition.dy - _ballPos.height / 2 < 0 ||
        newPosition.dy + _ballPos.height / 2 > screenHeight) {
      _direction = Offset(_direction.dx, -_direction.dy);
    }

    _ballPos = Rect.fromCenter(
        center: newPosition, width: _ballPos.width, height: _ballPos.height);
  }

  double calculateDistance(Offset point1, Offset point2) {
    double dx = point1.dx - point2.dx;
    double dy = point1.dy - point2.dy;
    return sqrt(dx * dx + dy * dy);
  }

  bool isTapped(TapDownDetails details) {
    // Create an Offset for the tap point
    Offset tapPoint = details.localPosition;

    // Calculate the distance between the tap point and the center of the ball
    double distance = calculateDistance(tapPoint, _ballPos.center);

    // Consider a tap if the distance is within the ball's radius + touch radius + error margin
    double touchRadius = 5.0; // Adjust this touch radius as needed
    double errorMargin = 2.0; // Adjust this error margin as needed
    double totalRadius = _ballPos.width / 2 + touchRadius + errorMargin;

    return distance <= totalRadius;
  }
}
