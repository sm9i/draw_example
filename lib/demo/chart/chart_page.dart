import 'dart:ui';

import 'package:flutter/material.dart';

class ChartPage extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('chart demo '),
      ),
      body: Center(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            Container(
              width: 381,
              height: 261,
              padding: EdgeInsets.all(20),
              color: Colors.blueAccent.withAlpha(33),
              child: _Chart1(),
            ),
          ],
        ),
      ),
    );
  }
}

class _Chart1 extends StatefulWidget {
  @override
  __Chart1State createState() => __Chart1State();
}

class __Chart1State extends State<_Chart1> with SingleTickerProviderStateMixin {
  AnimationController _controller;

  @override
  void initState() {
    _controller = AnimationController(vsync: this, duration: Duration(milliseconds: 1500))..forward();
    super.initState();
  }

  @override
  void dispose() {
    _controller.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return CustomPaint(
      painter: ChartPainter1(_controller),
    );
  }
}

class ChartPainter1 extends CustomPainter {
  ChartPainter1(this.repaint) : super(repaint: repaint);
  final Animation<double> repaint;
  final List<double> yData = [88, 98, 11, 64, 95];
  final List<String> xDate = ["7y", "8y", "9y", "10y", "11y"];

  Paint axisPaint = Paint()
    ..style = PaintingStyle.stroke
    ..strokeWidth = 1;

  Paint gridPaint = Paint()
    ..style = PaintingStyle.stroke
    ..color = Colors.grey
    ..strokeWidth = 0.5;

  Paint fillPaint = Paint()..color = Colors.red;

  @override
  void paint(Canvas canvas, Size size) {
    canvas.drawRect(Offset.zero & size, Paint()..color = Colors.black.withAlpha(22));
    canvas.translate(0, size.height);
    // canvas.drawCircle(Offset.zero, 10, axisPaint);

    Path xyPath = Path();
    xyPath.moveTo(10, 0);
    xyPath.lineTo(10, -size.height);
    xyPath.moveTo(0, -10);
    xyPath.lineTo(size.width, -10);

    canvas.drawPath(xyPath, axisPaint);

    canvas.save();
    drawYText(canvas, size);
    canvas.restore();
    canvas.save();
    drawXText(canvas, size);

    canvas.restore();

    drawChart(canvas, size);
  }

  void drawChart(Canvas canvas, Size size) {
    canvas.translate(10, -10);
    canvas.drawCircle(Offset.zero, 10, axisPaint);
    double yNum = (size.width - 10) / xDate.length;

    for (int i = 0; i < xDate.length; i++) {
      canvas.drawRect(Rect.fromLTWH(15, 0, 30, -yData[i] / 100 * (size.height - 10) * repaint.value), fillPaint);
      canvas.translate(yNum, 0);
    }
  }

  void drawXText(Canvas canvas, Size size) {
    double yNum = (size.width - 10) / xDate.length;
    for (int i = 0; i < xDate.length; i++) {
      canvas.drawLine(Offset(10, 0), Offset(10, -10), axisPaint);
      _drawText(canvas, xDate[i], offset: Offset(yNum / 2, 0));
      canvas.translate(yNum, 0);
    }
  }

  void drawYText(Canvas canvas, Size size) {
    canvas.translate(0, -10);
    double yNum = (size.height - 10) / 5;
    for (int i = 0; i <= 5; i++) {
      if (i == 0) {
        _drawText(canvas, '0', offset: Offset(-10, 2));
        canvas.translate(0, -yNum);
        continue;
      }
      canvas.drawLine(Offset(0, 0), Offset(size.width, 0), gridPaint);
      canvas.drawLine(Offset(0, 0), Offset(10, 0), axisPaint);
      _drawText(canvas, (100 / 5 * i).toStringAsFixed(0), offset: Offset(-10, 2));
      canvas.translate(0, -yNum);
    }
  }

  void _drawText(Canvas canvas, String str, {Offset offset}) {
    final painter = TextPainter(
      text: TextSpan(
        text: str,
        style: TextStyle(color: Colors.black, fontSize: 10),
      ),
      textDirection: TextDirection.ltr,
    );
    painter.layout();
    painter.paint(canvas, offset);
  }

  @override
  bool shouldRepaint(covariant ChartPainter1 oldDelegate) {
    return oldDelegate.repaint != repaint;
  }
}
