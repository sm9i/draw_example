import 'dart:math' as math;
import 'dart:ui';

import 'package:flutter/material.dart';

class CircularBezierPainter extends CustomPainter {
  Paint _painter;
  final Offset center = const Offset(100, 100);

//  final int count = 6;
  final double innerRadius = 80;
  final double outerRadius = 100;

  CircularBezierPainter() {
    _painter = Paint()
      ..color = const Color(0x660092F3)
      ..style = PaintingStyle.stroke
      ..strokeWidth = 2;
  }

  @override
  void paint(Canvas canvas, Size size) {
    canvas.translate(size.width / 2 - 100, size.height / 2 - 100);
    drawBezierCircle(canvas, 6);
    drawBezierCircle(canvas, 7, deflection: math.pi / 90);
  }

  void drawBezierCircle(Canvas canvas, int count, {double deflection = 0}) {
    final List<Offset> innerPoints = getOnCircleOffsets(
      innerRadius,
      center,
      deflection: deflection,
      count: count * 4,
    );
    // canvas.drawPoints(PointMode.lines, innerPoints, _painter);
    final List<Offset> outerPoints = getOnCircleOffsets(
      outerRadius,
      center,
      deflection: deflection,
      count: count * 4,
    );
    final Path path = Path();
    path.moveTo(innerPoints.first.dx, innerPoints.first.dy);
    for (int i = 0; i < count * 4; i += 2) {
      final Offset point1 =
          i == count * 4 - 2 ? innerPoints.first : innerPoints[i + 2];
      final Offset point2 =
          i == count * 4 - 2 ? outerPoints.first : outerPoints[i + 2];
      final Offset nextPoint1 =
          i == count * 4 - 1 ? innerPoints.first : innerPoints[i + 1];
      final Offset nextPoint2 =
          i == count * 4 - 1 ? outerPoints.first : outerPoints[i + 1];
      final Offset controlPoint2 =
          center + (nextPoint2 - center) / math.cos(math.pi / (count * 2));
      final Offset controlPoint1 =
          center + (nextPoint1 - center) / math.cos(math.pi / (count * 2));
      if (i % 4 == 0) {
        path.cubicTo(
          controlPoint1.dx,
          controlPoint1.dy,
          controlPoint2.dx,
          controlPoint2.dy,
          point2.dx,
          point2.dy,
        );
      } else {
        path.cubicTo(
          controlPoint2.dx,
          controlPoint2.dy,
          controlPoint1.dx,
          controlPoint1.dy,
          point1.dx,
          point1.dy,
        );
      }
    }
    canvas.drawPath(path, _painter);
  }

  List<Offset> getOnCircleOffsets(
    double radius,
    Offset center, {
    double deflection = 0,
    int count = 12,
  }) {
    assert(count > 3);
    List<Offset> offsets = [];
    final double dRadians = 2 * math.pi / count;

    for (int i = 0; i < count; i++) {
      final double radians = dRadians * i + deflection;
      final double dx = radius * math.cos(radians);
      final double dy = radius * math.sin(radians);
      offsets.add(center + Offset(dx, dy));
    }
    return offsets;
  }

  @override
  bool shouldRepaint(CustomPainter oldDelegate) {
    return true;
  }
}
