import 'dart:ui';

///
/// https://juejin.cn/post/6904453408477380621
///

import 'package:flutter/material.dart';
import 'package:flutter/services.dart';

class BezierFittingPage extends StatefulWidget {
  @override
  _BezierFittingPageState createState() => _BezierFittingPageState();
}

class _BezierFittingPageState extends State<BezierFittingPage> {
  @override
  Widget build(BuildContext context) {
    SystemChrome.setEnabledSystemUIOverlays([]);
    return Scaffold(
      body: Container(
        color: Colors.white,
        child: CustomPaint(
          painter: _BezierFittingPainter(),
          size: MediaQuery.of(context).size,
        ),
      ),
    );
  }
}

class _BezierFittingPainter extends CustomPainter {
  final List<Offset> points = <Offset>[
    Offset(-240, -40),
    Offset(-200, 80),
    Offset(-160, -20),
    Offset(-120, 0),
    Offset(-80, 20),
    Offset(-40, -30),
    Offset(-20, 50),
    Offset(0, 20),
    Offset(40, 40),
    Offset(80, -20),
    Offset(120, -40),
    Offset(160, -80),
    Offset(200, -20),
    Offset(240, -40),
  ];

  final Paint _helpPaint = Paint()..color = Colors.orange;
  final Paint _linePaint = Paint();

  final Path path1 = Path();

  @override
  void paint(Canvas canvas, Size size) {
    //画板中心
    canvas.translate(size.width / 2, size.height / 2);
    //xy
    canvas.drawLine(
        Offset(-size.width, 0),
        Offset(size.width, 0),
        Paint()
          ..strokeWidth = 0.3
          ..color = Colors.grey);
    canvas.drawLine(
        Offset(0, -size.height),
        Offset(0, size.height),
        Paint()
          ..strokeWidth = 0.3
          ..color = Colors.grey);
    //
    drawHelper(canvas);

    drawBezier(canvas, points);
  }

  void drawHelper(Canvas canvas) {
    points.forEach((element) {
      canvas.drawCircle(element, 2, _helpPaint..strokeWidth = 1);
    });
    canvas.drawPoints(PointMode.polygon, points, _helpPaint..strokeWidth = 0.5);
  }

  void drawBezier(Canvas canvas, List<Offset> points) {
    for (int i = 0; i < points.length - 1; i++) {
      final Offset current = points[i];
      final Offset next = points[i + 1];
      if (i == 0) {
        //2介
        path1.moveTo(current.dx, current.dy);
        final double ctrlX = current.dx + (next.dx - current.dx) / 2;
        final double ctrlY = next.dy;
        path1.quadraticBezierTo(ctrlX, ctrlY, next.dx, next.dy);
      } else if (i < points.length - 2) {
        path1.moveTo(current.dx, current.dy);
        //3介
        final double ctrlX1 = current.dx + (next.dx - current.dx) / 2;
        final double ctrlY1 = current.dy;

        final double ctrlX2 = ctrlX1;
        final double ctrlY2 = next.dy;
        path1.cubicTo(ctrlX1, ctrlY1, ctrlX2, ctrlY2, next.dx, next.dy);
      } else {
        //2介
        path1.moveTo(current.dx, current.dy);
        final double ctrlX = current.dx + (next.dx - current.dx) / 2;
        final double ctrlY = current.dy;
        path1.quadraticBezierTo(ctrlX, ctrlY, next.dx, next.dy);
      }
    }

    canvas.drawPath(path1, _helpPaint..style = PaintingStyle.stroke);
  }

  @override
  bool shouldRepaint(covariant _BezierFittingPainter oldDelegate) {
    return false;
  }
}
