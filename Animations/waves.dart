import 'package:flutter/material.dart';
import 'dart:math';
import 'package:simple_animations/simple_animations/controlled_animation.dart';

class AnimatedWave extends StatelessWidget {
  final double height;
  final double speed;
  final double offset;
  final Color color;

  AnimatedWave({this.height, this.speed, this.offset = 0.0, this.color});

  @override
  Widget build(BuildContext context) {
    return LayoutBuilder(builder: (context, constraints) {
      return Container(
        height: height,
        width: constraints.biggest.width,
        child: ControlledAnimation(
            playback: Playback.LOOP,
            duration: Duration(milliseconds: (5000 / speed).round()),
            tween: Tween(begin: 0.0, end: 2 * pi),
            builder: (context, value) {
              return CustomPaint(
                foregroundPainter: CurvePainter(value + offset, color),
              );
            }),
      );
    });
  }
}

class CurvePainter extends CustomPainter {
  final double value;
  final Color color;
  CurvePainter(this.value, this.color);

  @override
  void paint(Canvas canvas, Size size) {
    final black = Paint()..color = color.withAlpha(90);
    final path = Path();

    final y1 = sin(value);
    final y2 = sin(value + pi / 2);
    final y3 = sin(value + pi);

    final startPointY = size.height * (0.5 + 0.4 * y1);
    final controlPointY = size.height * (0.5 + 0.4 * y2);
    final endPointY = size.height * (0.5 + 0.4 * y3);

    path.moveTo(size.width * 0, startPointY);
    path.quadraticBezierTo(
        size.width * 0.5, controlPointY, size.width, endPointY);
    path.lineTo(size.width, size.height);
    path.lineTo(0, size.height);
    path.close();
    canvas.drawPath(path, black);
  }

  @override
  bool shouldRepaint(CustomPainter oldDelegate) {
    return true;
  }
}
