import 'dart:math';
import 'dart:ui';

import 'package:flutter/material.dart';

class PolygonPage extends StatefulWidget {
  @override
  _PolygonPageState createState() => _PolygonPageState();
}

class _PolygonPageState extends State<PolygonPage>
    with SingleTickerProviderStateMixin {
  AnimationController _controller;

  @override
  void initState() {
    _controller =
        AnimationController(vsync: this, duration: Duration(seconds: 1));
    super.initState();
  }

  @override
  void dispose() {
    _controller.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('任意多边形？'),
      ),
      body: Center(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            RepaintBoundary(
              child: CustomPaint(
                painter: _PolygonCustom(repaint: _controller, edge: 5),
                size: Size(200, 200),
              ),
            ),
            RaisedButton(onPressed: () {})
          ],
        ),
      ),
    );
  }
}

class _PolygonCustom extends CustomPainter {
  _PolygonCustom({this.edge = 3, this.repaint}) : super(repaint: repaint);

  final int edge;
  final Animation repaint;

  @override
  void paint(Canvas canvas, Size size) {
    assert(edge > 2);
    //裁剪布局
    canvas.clipRect(Offset.zero & size);
    //中心点
    canvas.translate(size.width / 2, size.height / 2);
    //半径
    final double r = min(size.width / 2, size.height / 2);
    //点集
    List<Offset> points = [];
    //一边的弧度
    final double rArc = pi * 2 / edge;
    //旋转布局 使定点or 顶边在上边
    //
    canvas.rotate(pi / edge / (edge % 2 == 0 ? 1 : 2));
    for (int i = 0; i < edge; i++) {
      final double radius = i * rArc;
      final dx = r * cos(radius);
      final dy = r * sin(radius);
      points.add(Offset(dx, dy));
    }

    points.add(points.first);
    canvas.drawPoints(
      PointMode.polygon,
      points,
      Paint()
        ..color = Colors.red
        ..strokeWidth = 2,
    );
  }

  @override
  bool shouldRepaint(covariant _PolygonCustom oldDelegate) =>
      oldDelegate.edge != edge || oldDelegate.repaint != repaint;
}
