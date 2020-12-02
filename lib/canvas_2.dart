import 'package:flutter/material.dart';

import 'coordinate_canvas.dart';

class MPainter2 extends CustomPainter {
  final CoordinateCanvas coordinateCanvas = CoordinateCanvas(step: 25);

  @override
  void paint(Canvas canvas, Size size) {
    canvas.clipRect(Offset.zero & size);
    canvas.translate(size.width / 2, size.height / 2);
    coordinateCanvas.paint(canvas, size);
    final double radius = size.width / 2;
  }

  void drawHead(Canvas canvas, Size size) {
    
  }

  @override
  bool shouldRepaint(CustomPainter oldDelegate) => true;
}
