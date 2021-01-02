import 'dart:math';
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
        child: SingleChildScrollView(
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
              Container(
                width: 381,
                height: 261,
                padding: EdgeInsets.all(20),
                color: Colors.blueAccent.withAlpha(33),
                child: _Chart2(),
              ),
            ],
          ),
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
      painter: _ChartPainter1(_controller),
    );
  }
}

class _ChartPainter1 extends CustomPainter {
  _ChartPainter1(this.repaint) : super(repaint: repaint);
  final Animation<double> repaint;
  final List<double> yData = [88, 98, 11, 64, 95];
  final List<String> xDate = ["7y", "8y", "9y", "10y", "11y"];

  //折线图 点的位置
  final List<Offset> line = [];
  Paint axisPaint = Paint()
    ..style = PaintingStyle.stroke
    ..strokeWidth = 1;

  Paint gridPaint = Paint()
    ..style = PaintingStyle.stroke
    ..color = Colors.grey
    ..strokeWidth = 0.5;

  Paint fillPaint = Paint()..color = Colors.redAccent;
  Paint linePaint = Paint()..color = Colors.greenAccent;

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
    canvas.save();
    drawChart(canvas, size);
    canvas.restore();
    drawLineChart(canvas, size);
  }

  ///折线图
  void drawLineChart(Canvas canvas, Size size) {
    line.clear();
    canvas.translate(10, -10);
    // canvas.drawCircle(Offset.zero, 10, axisPaint);
    double yNum = (size.width - 10) / xDate.length;
    for (int i = 0; i < xDate.length; i++) {
      double height = -yData[i] / 100 * (size.height - 10);
      line.add(Offset(yNum * i + yNum / 2, height));
    }
    canvas.drawPoints(
        PointMode.points,
        line,
        linePaint
          ..strokeWidth = 5
          ..strokeCap = StrokeCap.round);

    Offset p1 = line[0];
    Path path = Path()..moveTo(p1.dx, p1.dy);
    for (int i = 1; i < line.length; i++) {
      path.lineTo(line[i].dx, line[i].dy);
    }
    fillPaint.strokeWidth = 1;
    final PathMetrics pms = path.computeMetrics();
    pms.forEach((element) {
      canvas.drawPath(
          element.extractPath(0, element.length * repaint.value),
          linePaint
            ..style = PaintingStyle.stroke
            ..strokeWidth = 2);
    });
  }

  void drawChart(Canvas canvas, Size size) {
    canvas.translate(10, -10);
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
  bool shouldRepaint(covariant _ChartPainter1 oldDelegate) {
    return oldDelegate.repaint != repaint;
  }
}

class _Chart2 extends StatefulWidget {
  @override
  __Chart2State createState() => __Chart2State();
}

class __Chart2State extends State<_Chart2> with SingleTickerProviderStateMixin {
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
      painter: _ChartPainter2(_controller),
    );
  }
}

class _ChartPainter2 extends CustomPainter {
  _ChartPainter2(this.repaint) : super(repaint: repaint);
  final List<double> value = [0.12, 0.25, 0.1, 0.18, 0.15, 0.2];
  final List<String> valueKey = ['语文', '数学', '英语', '化学', '物理', '政治'];
  final List<Color> valueColor = [Colors.redAccent, Colors.blueAccent, Colors.lightGreenAccent, Colors.pink, Colors.blueGrey, Colors.purple];
  final Animation<double> repaint;
  final Paint _linePaint = Paint()
    ..strokeWidth = 1
    ..style = PaintingStyle.stroke
    ..color = Colors.red;

  @override
  void paint(Canvas canvas, Size size) {
    double radius = size.height / 2 - 10;
    canvas.drawRect(Offset.zero & size, Paint()..color = Colors.black.withAlpha(22));
    canvas.translate(size.width / 2, size.height / 2);
    canvas.rotate(-pi / 2);
    //通过裁剪 来搞出 动画
    Path clipPath = Path();
    clipPath.lineTo(radius, 0);
    clipPath.arcTo(Rect.fromCenter(center: Offset.zero, width: radius*3 , height: radius*3 ), 0, 2 * pi * repaint.value, false);
    clipPath.close();
    if (repaint.value != 1.0) {
      canvas.clipPath(clipPath);
    }

    drawRadio(canvas, size);
    drawInfo(canvas, size);
  }

  void drawInfo(Canvas canvas, Size size) {
    canvas.save();
    double radius = size.height / 2 - 10;
    for (int i = 0; i < value.length; i++) {
      Color color = valueColor[i];
      canvas.rotate(2 * pi * value[i] / 2);
      _drawText(
        canvas,
        "${(value[i] / 100).toStringAsFixed(1)}%",
        offset: Offset(radius / 2 + 5, 0),
        color: Colors.white,
      );
      Path textPath = Path();
      textPath.moveTo(radius, 0);
      textPath.relativeLineTo(15, 0);
      textPath.relativeLineTo(5, 10);
      canvas.drawPath(
          textPath,
          _linePaint
            ..color = color
            ..style = PaintingStyle.stroke);
      _drawText(canvas, valueKey[i], offset: Offset(radius + 10, 10));
      canvas.rotate(2 * pi * value[i] / 2);
    }

    canvas.restore();
  }

  void drawRadio(Canvas canvas, Size size) {
    canvas.save();
    double radius = size.height / 2 - 10;

    for (int i = 0; i < value.length; i++) {
      Path path = Path();
      path.lineTo(radius, 0);
      path.arcTo(
        Rect.fromCenter(center: Offset.zero, width: radius * 2, height: radius * 2),
        0,
        2 * pi * value[i],
        false,
      );
      path.close();
      canvas.drawPath(
          path,
          _linePaint
            ..style = PaintingStyle.fill
            ..color = valueColor[i]);
      canvas.rotate(2 * pi * value[i]);
    }
    canvas.restore();
  }

  void _drawText(Canvas canvas, String str, {@required Offset offset, Color color = Colors.black}) {
    final painter = TextPainter(
      text: TextSpan(
        text: str,
        style: TextStyle(color: color, fontSize: 10),
      ),
      textDirection: TextDirection.ltr,
    );
    painter.layout();
    painter.paint(canvas, offset);
  }

  @override
  bool shouldRepaint(covariant _ChartPainter2 oldDelegate) {
    return oldDelegate.repaint != repaint;
  }
}
