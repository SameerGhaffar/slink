import 'dart:math';
import 'package:flutter/material.dart';
import 'package:flame/game.dart';
import 'package:slink/utils/colors.dart';

class BonusRound extends StatefulWidget {
  const BonusRound({super.key});

  @override
  State<BonusRound> createState() => _BonusRoundState();
}

class _BonusRoundState extends State<BonusRound> {
  late BubbleGame bubbleGame;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: SafeArea(
        child: Padding(
          padding: const EdgeInsets.all(8.0),
          child: Center(
            child: Container(
              color: Colors.black.withOpacity(0.2),
              height: 600,
              child: GestureDetector(
                onTapDown: (details) {
                  bubbleGame.onTapDown(details);
                },
                child: GameWidget(
                  game: bubbleGame = BubbleGame(
                    screenWidth: MediaQuery.of(context).size.width - 16 * 0.95,
                    screenHeight: 600,
                    ballColor: CColors.ballColors,
                  ),
                ),
              ),
            ),
          ),
        ),
      ),
    );
  }
}

class BubbleGame with Game {
  late List<Ball> balls;
  late double screenWidth, screenHeight;
  late List<List<Color>> ballColor;

  BubbleGame({
    required this.screenHeight,
    required this.screenWidth,
    required this.ballColor,
  });

  @override
  backgroundColor() {
    return Colors.transparent;
  }

  @override
  Future<void>? onLoad() async {
    super.onLoad();
    balls = List.generate(
      ballColor.length,
      (index) {
        double ballSize = screenWidth * 0.25;
        double angle = 2 * pi * Random().nextDouble();

        Offset randomPosition = Offset(
          screenWidth / 2 + cos(angle) * (screenWidth / 2 - ballSize),
          screenHeight / 2 + sin(angle) * (screenHeight / 2 - ballSize),
        );

        return Ball(
          gradientColors: ballColor[index],
          ballSize: ballSize,
          index: index,
          position: randomPosition,
          speed: 100,
          direction: Offset(Random().nextDouble(), Random().nextDouble()),
        );
      },
    );
  }

  @override
  void render(Canvas canvas) {
    // Set background color to white
    canvas.drawRect(Rect.fromLTWH(0, 0, screenWidth, screenHeight),
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
      for (int j = i + 1; j < balls.length; j++) {
        if (balls[i].collidesWith(balls[j])) {
          // Handle collision by adjusting positions
          balls[i].resolveCollision(balls[j], screenHeight, screenWidth);
        }
      }
    }

    // Update each ball's position
    for (int i = 0; i < balls.length; i++) {
      balls[i].update(dt, screenWidth, screenHeight);
    }
  }

  void onTapDown(TapDownDetails details) {
    balls.removeWhere((ball) {
      if (ball.ballSize >= 140) {
        // If the ball is removed, update the index of other balls
        for (int i = ball.index + 1; i < balls.length; i++) {
          balls[i].index = i - 1;
        }
        return true;
      }
      return false;
    });
    // Check if any ball is tapped
    for (final ball in balls) {
      if (ball.isTapped(details)) {
        print("Tapped on ball with index: ${ball.index}");
        if (ball.ballSize < 140) {
          ball.increaseSize();
        } else {}
      }
    }
  }
}

class Ball {
  late int index;
  late Paint paint;
  late Rect _ballPos;
  late Offset _direction;
  late double _speed;
  late double ballSize;
  late List<Color> gradientColors;

  Ball(
      {required this.index,
      required Offset position,
      required double speed,
      required Offset direction,
      required this.gradientColors,
      required this.ballSize}) {
    _ballPos =
        Rect.fromCenter(center: position, width: ballSize, height: ballSize);
    paint = Paint()
      ..shader = RadialGradient(
        colors: gradientColors,
        radius: 4,
      ).createShader(_ballPos);
    _speed = speed;
    _direction = direction;
  }

  void increaseSize() {
    print(index);
    print(ballSize);
    ballSize = ballSize + 2;
    // Update the ball position with the new size
    _ballPos = Rect.fromCenter(
      center: _ballPos.center,
      width: ballSize,
      height: ballSize,
    );
    print(ballSize);
  }

  bool collidesWith(Ball other) {
    double distance = calculateDistance(_ballPos.center, other._ballPos.center);
    double totalRadius = _ballPos.width / 2 + other._ballPos.width / 2;
    return distance <= totalRadius;
  }

  void resolveCollision(Ball other, double screenHeight, screenWidth) {
    // Move the balls away from each other
    double angle = atan2(other._ballPos.center.dy - _ballPos.center.dy,
        other._ballPos.center.dx - _ballPos.center.dx);
    double overlap = (_ballPos.width / 2 + other._ballPos.width / 2) -
        calculateDistance(_ballPos.center, other._ballPos.center);

    double dx = cos(angle) * overlap;
    double dy = sin(angle) * overlap;

    // Move the current ball
    _ballPos = _ballPos.translate(-dx / 2, -dy / 2);

    // Move the other ball
    other._ballPos = other._ballPos.translate(dx / 2, dy / 2);

    // this will reverse the direction after collision
    // _direction = Offset(-_direction.dx, -_direction.dy);
//------------------------------------------------------------------------------
    // this will random the direction after collision
    _direction =
        Offset(Random().nextDouble() * 2 - 1, Random().nextDouble() * 2 - 1);

    // Swap direction to simulate bouncing off
    double dx1 = _direction.dx;
    double dy1 = _direction.dy;
    double dx2 = other._direction.dx;
    double dy2 = other._direction.dy;

    _direction = Offset(dx2, dy2);
    other._direction = Offset(dx1, dy1);

    // Check if the current ball is out of bounds after collision
    if (_ballPos.left < 0 ||
        _ballPos.right > screenWidth ||
        _ballPos.top < 0 ||
        _ballPos.bottom > screenHeight) {
      print("ball is out of the bound$index");
      // Ball is out of bounds, reset it
      resetBall(screenWidth, screenHeight);
    }
  }
  void resetBall(final double screenWidth, final double screenHeight) {
    // Slightly change the position of the ball
    _ballPos = _ballPos.translate(
        Random().nextDouble() * 10 - 5, Random().nextDouble() * 10 - 5);

    // Ensure the ball stays within the screen boundaries
    if (_ballPos.left < 0) {
      _ballPos = _ballPos.translate(0 - _ballPos.left, 0);
      _direction = Offset(-_direction.dx, _direction.dy);
    } else if (_ballPos.right > screenWidth) {
      _ballPos = _ballPos.translate(screenWidth - _ballPos.right, 0);
      _direction = Offset(-_direction.dx, _direction.dy);
    }
    if (_ballPos.top < 0) {
      _ballPos = _ballPos.translate(0, 0 - _ballPos.top);
      _direction = Offset(_direction.dx, -_direction.dy);
    } else if (_ballPos.bottom > screenHeight) {
      _ballPos = _ballPos.translate(0, screenHeight - _ballPos.bottom);
      _direction = Offset(_direction.dx, -_direction.dy);
    }

    // Keep the speed the same
    _speed = 100;
  }
  // void resetBall(final double screenWidth, final double screenHeight) {
  //   // Slightly change the position of the ball
  //   _ballPos = _ballPos.translate(
  //       Random().nextDouble() * 10 - 5, Random().nextDouble() * 10 - 5);
  //
  //   // Ensure the ball stays within the screen boundaries
  //   if (_ballPos.left < 0) {
  //     _ballPos = _ballPos.translate(0 - _ballPos.left, 0);
  //     _direction = Offset(-_direction.dx, _direction.dy);
  //   } else if (_ballPos.right > screenWidth) {
  //     _ballPos = _ballPos.translate(screenWidth - _ballPos.right, 0);
  //     _direction = Offset(-_direction.dx, _direction.dy);
  //   }
  //   if (_ballPos.top < 0) {
  //     _ballPos = _ballPos.translate(0, 0 - _ballPos.top);
  //     _direction = Offset(_direction.dx, -_direction.dy);
  //   } else if (_ballPos.bottom > screenHeight) {
  //     _ballPos = _ballPos.translate(0, screenHeight - _ballPos.bottom);
  //     _direction = Offset(_direction.dx, -_direction.dy);
  //   }
  //
  //   // Keep the speed the same
  //   _speed = 100;
  // }


  void render(Canvas canvas) {
    paint.shader = RadialGradient(
      colors: gradientColors,
    ).createShader(_ballPos);
    // Draw the ball
    canvas.drawOval(_ballPos, paint);

    // Draw the index inside the ball
    TextPainter textPainter = TextPainter(
      text: TextSpan(
        children: [
          TextSpan(
            text: "${ballSize.toInt()}\n",
            style: const TextStyle(
              color: Colors.white,
              fontSize: 16.0,
              fontWeight: FontWeight.bold,
            ),
          ),
          const TextSpan(
            text: "physics",
            style: TextStyle(
              color: Colors.white,
              fontSize: 20,
              fontWeight: FontWeight.bold,
            ),
          ),
        ],
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
    // Calculate the new position of the ball
    final newPosition = _ballPos.center + _direction * _speed * dt;

    // Check for ball-wall collisions
    if (newPosition.dx - _ballPos.width / 2 < 0 || newPosition.dx + _ballPos.width / 2 > screenWidth) {
      // Colliding with a wall
      _direction = Offset(-_direction.dx, _direction.dy);
    }

    if (newPosition.dy - _ballPos.height / 2 < 0 || newPosition.dy + _ballPos.height / 2 > screenHeight) {
      // Colliding with a wall
      _direction = Offset(_direction.dx, -_direction.dy);
    }

    // Update the ball position after collision handling
    _ballPos = Rect.fromCenter(
        center: newPosition, width: _ballPos.width, height: _ballPos.height);
  }
  // void update(double dt, double screenWidth, double screenHeight) {
  //   // Update the ball's position
  //   final newPosition = _ballPos.center + _direction * _speed * dt;
  //
  //   // Ensure the new position does not go beyond the screen boundaries
  //   if (newPosition.dx - _ballPos.width / 2 < 0) {
  //     // Colliding with left wall
  //     _ballPos = _ballPos.translate(-(_ballPos.left - _ballPos.width / 2), 0);
  //     _direction = Offset(-_direction.dx, _direction.dy);
  //   } else if (newPosition.dx + _ballPos.width / 2 > screenWidth) {
  //     // Colliding with right wall
  //     _ballPos = _ballPos.translate(
  //         screenWidth - (_ballPos.right - _ballPos.width / 2), 0);
  //     _direction = Offset(-_direction.dx, _direction.dy);
  //   }
  //
  //   if (newPosition.dy - _ballPos.height / 2 < 0) {
  //     // Colliding with top wall
  //     _ballPos = _ballPos.translate(0, -(_ballPos.top - _ballPos.height / 2));
  //     _direction = Offset(_direction.dx, -_direction.dy);
  //   } else if (newPosition.dy + _ballPos.height / 2 > screenHeight) {
  //     // Colliding with bottom wall
  //     _ballPos = _ballPos.translate(
  //         0, screenHeight - (_ballPos.bottom - _ballPos.height / 2));
  //     _direction = Offset(_direction.dx, -_direction.dy);
  //   }
  //
  //   // Update the ball position after collision handling
  //   _ballPos = Rect.fromCenter(
  //       center: newPosition, width: _ballPos.width, height: _ballPos.height);
  // }

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
