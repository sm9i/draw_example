import 'package:flutter/material.dart';

/// path 绘制坐标系
class CoordinateCanvas {
  CoordinateCanvas({this.step});

  final double step;
  final _gridPaint = Paint()
    ..style = PaintingStyle.stroke
    ..strokeWidth = .5
    ..color = Colors.grey;
  final _gridPath = Path();

  void paint(Canvas canvas, Size size) {
    for (int i = 0; i < size.width / 2 / step; i++) {
      _gridPath.moveTo(step * i, -size.height / 2);
      _gridPath.relativeLineTo(0, size.height);
      _gridPath.moveTo(-step * i, -size.height / 2);
      _gridPath.relativeLineTo(0, size.height);
    }

    for (int i = 0; i < size.height / 2 / step; i++) {
      _gridPath.moveTo(-size.width / 2, step * i);
      _gridPath.relativeLineTo(size.width, 0);
      _gridPath.moveTo(-size.width / 2, -step * i);
      _gridPath.relativeLineTo(size.width, 0);
    }
    canvas.drawPath(_gridPath, _gridPaint);
    canvas.drawCircle(
        Offset.zero,
        3,
        Paint()
          ..color = Colors.red
          ..style = PaintingStyle.fill);
  }
}
