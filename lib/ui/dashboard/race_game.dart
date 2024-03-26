// import 'package:flame/components.dart';
// import 'package:flame/extensions.dart';
// import 'package:flutter/cupertino.dart';
// import 'package:flutter/material.dart';
//
// class Race extends StatefulWidget {
//   const Race({super.key});
//
//   @override
//   State<Race> createState() => _RaceState();
// }
//
// class _RaceState extends State<Race> {
//   @override
//   Widget build(BuildContext context) {
//     return Scaffold(
//       body: Container(
//         child: Center(
//           child: Container(
//             color: Colors.green,
//             height: 100,
//             width: 100,
//           ),
//         ),
//       ),
//     );
//   }
// }
//
// class Player extends SpriteComponent {
//   double velocityX = 0;
//   double velocityY = 0;
//   double jumpForce = 10;
//   bool isJumping = false;
//
//   Player(Image spriteImage)
//       : super(size: Vector2.all(50), sprite: Sprite(spriteImage));
//
//   @override
//   void update(double dt) {
//     super.update(dt);
//
//     // Move right
//     position.x += velocityX * dt;
//
//     // Apply gravity
//     velocityY += 9.8 * dt;
//     position.y += velocityY * dt;
//
//     // Collision detection and ground adjustment
//     if (position.y >= 200) {
//       // Assuming ground is at y=200
//       position.y = 200;
//       velocityY = 0;
//       isJumping = false;
//     }
//   }
//
//   void jump() {
//     if (!isJumping) {
//       velocityY = -jumpForce;
//       isJumping = true;
//     }
//   }
// }
