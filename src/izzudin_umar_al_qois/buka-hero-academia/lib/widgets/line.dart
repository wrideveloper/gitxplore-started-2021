import 'package:buka_hero_academia/utils/palette.dart';
import 'package:flutter/material.dart';

class UnderLine extends CustomPainter {
  final Color color;
  final double strokeWidth;
  final Offset p1;
  final Offset p2;
  UnderLine({this.color, this.strokeWidth, this.p1, this.p2});

  @override
  void paint(Canvas canvas, Size size) {
    final _p1 = Offset(45, 0);
    final _p2 = Offset(0, 0);
    final paint = Paint()
      ..color = color != null ? color : Palette.white
      ..strokeWidth = strokeWidth != null ? strokeWidth : 2.0
      ..strokeCap = StrokeCap.round;
    canvas.drawLine(p1 ?? _p1, p2 ?? _p2, paint);
  }

  @override
  bool shouldRepaint(CustomPainter old) {
    return false;
  }
}

class VerticalLine extends CustomPainter {
  final Color color;
  final double strokeWidth;
  VerticalLine({this.color, this.strokeWidth});

  @override
  void paint(Canvas canvas, Size size) {
    final p1 = Offset(0, 0);
    final p2 = Offset(0, 53);
    final paint = Paint()
      ..color = color != null ? color : Palette.white
      ..strokeWidth = strokeWidth != null ? strokeWidth : 1.0;
    canvas.drawLine(p1, p2, paint);
  }

  @override
  bool shouldRepaint(CustomPainter old) {
    return false;
  }
}