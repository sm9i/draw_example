import 'dart:math';
import 'dart:ui';

import 'package:draw_example/coordinate_canvas.dart';
import 'package:flutter/material.dart';

class PathFitting extends CustomPainter {
  final CoordinateCanvas coordinateCanvas = CoordinateCanvas(step: 25);

  @override
  void paint(Canvas canvas, Size size) {
    canvas.clipRect(Offset.zero & size);
    canvas.translate(size.width / 2, size.height / 2);
    coordinateCanvas.paint(canvas, size);

    // drawCurve(canvas, size);

    drawCurve2(canvas, size);
  }

  void drawCurve(Canvas canvas, Size size) {
    final List<Offset> points = [];

    for (double x = -240; x <= 240; x += 20) {
      points.add(Offset(x, -x * x / 200 + 100));
    }

    canvas.drawPoints(
      PointMode.polygon,
      points,
      Paint()
        ..color = Colors.blue
        ..strokeWidth = 1,
    );
  }

  void drawCurve2(Canvas canvas, Size size) {
    final List<Offset> points = [];
    final double step = 1;
    final double min = 0;
    final double max = 360 * 2.0;

    for (int i = 0; i < 360; i++) {
      points.add(Offset(cos(pi / 90 * i), 0));
    }

    // double f(double thta) {
    //   double p = 200 * sin(2 * thta).abs();
    //   return p;
    // }
    //
    // for (double x = min; x <= max; x += step) {
    //   double thta = (pi / 90 * x); // 角度转化为弧度
    //
    //   points.add(Offset(cos(thta)*10, cos(thta)*10));
    // }
    //
    //
    //
    // canvas.drawPoints(
    //   PointMode.polygon,
    //   points,
    //   Paint()
    //     ..color = Colors.blue
    //     ..strokeWidth = 1,
    // );
    // Offset p1 = points[0];
    // Path path = Path()..moveTo(p1.dx, p1.dy);
    // for (var i = 1; i < points.length - 1; i++) {
    //   double xc = (points[i].dx + points[i + 1].dx) / 2;
    //   double yc = (points[i].dy + points[i + 1].dy) / 2;
    //   Offset p2 = points[i];
    //   path.quadraticBezierTo(p2.dx, p2.dy, xc, yc);
    // }
    // canvas.drawPath(
    //     path,
    //     Paint()
    //       ..color = Colors.red
    //       ..style = PaintingStyle.stroke);
  }

  @override
  bool shouldRepaint(CustomPainter oldDelegate) {
    return true;
  }
}
