import 'dart:ui';

import 'package:draw_example/coordinate_canvas.dart';
import 'package:flutter/material.dart';

class BezierPainter extends CustomPainter {
  CoordinateCanvas coordinateCanvas = CoordinateCanvas(step: 50);

  final Paint _paint = Paint()
    ..color = Colors.orange
    ..style = PaintingStyle.stroke
    ..strokeWidth = 2;

  @override
  void paint(Canvas canvas, Size size) {
    canvas.clipRect(Offset.zero & size);
    canvas.translate(size.width / 2, size.height / 2);
    coordinateCanvas.paint(canvas, size);
    draw1(canvas, size);
  }

  void draw1(Canvas canvas, Size size) {
    final path = Path();
    final offset1 = Offset(100, 100);
    final offset2 = Offset(120, -60);

    path.quadraticBezierTo(offset1.dx, offset1.dy, offset2.dx, offset2.dy);

    canvas.drawPath(path, _paint);
    _drawHelper(canvas, p1: offset1, p2: offset2);
  }

  void _drawHelper(Canvas canvas, {Offset p1, Offset p2}) {
    canvas.drawPoints(
      PointMode.polygon,
      [Offset.zero, p1, p2],
      _paint
        ..color = Colors.green
        ..strokeWidth = 1,
    );
    canvas.drawPoints(
      PointMode.points,
      [Offset.zero, p1, p1, p2],
      _paint
        ..color = Colors.black
        ..strokeWidth = 10
        ..strokeCap = StrokeCap.round,
    );
  }

  @override
  bool shouldRepaint(CustomPainter oldDelegate) {
    return true;
  }
}
