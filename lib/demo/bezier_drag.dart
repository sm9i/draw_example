import 'dart:ui';

import 'package:flutter/material.dart';

import '../coordinate_canvas.dart';

///可拖动操控的贝塞尔
///
///

class BezierDragPage extends StatefulWidget {
  @override
  _BezierDragPageState createState() => _BezierDragPageState();
}

class _BezierDragPageState extends State<BezierDragPage> {
  final TouchInfo touchInfo = TouchInfo();

  @override
  void dispose() {
    touchInfo.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('bezier drag'),
      ),
      body: GestureDetector(
        onPanDown: onDown,
        onPanUpdate: onUpdate,
        child: Container(
          color: Colors.white,
          child: CustomPaint(
            size: MediaQuery.of(context).size,
            painter: _BezierDragPainter(repaint: touchInfo),
          ),
        ),
      ),
    );
  }

  void onUpdate(DragUpdateDetails details) => judgeSelect(details.localPosition, update: true);

  void onDown(DragDownDetails details) {
    if (touchInfo.points.length < 3) {
      touchInfo.addPoints(details.localPosition);
    } else {
      judgeSelect(details.localPosition);
    }
  }

  //判断当前选中的点
  void judgeSelect(Offset src, {bool update = false}) {
    for (int i = 0; i < touchInfo.points.length; i++) {
      if (judgeCircleArea(src, touchInfo.points[i], 5)) {
        touchInfo.selectIndex = i;
        //?
        if (update) {
          touchInfo.updatePoint(i, src);
        }
      }
    }
  }

  //判断点是否在 r为半径的圆内
  bool judgeCircleArea(Offset src, Offset dst, double r) => (src - dst).direction <= r;
}

class _BezierDragPainter extends CustomPainter {
  _BezierDragPainter({this.repaint}) : super(repaint: repaint);
  final TouchInfo repaint;
  CoordinateCanvas coordinateCanvas = CoordinateCanvas(step: 50);

  //点转为画布中点
  List<Offset> position;

  final Paint _positionPaint = Paint()
    ..color = Colors.red
    ..strokeCap = StrokeCap.round
    ..strokeWidth = 10;
  final Paint _linePaint = Paint()
    ..color = Colors.blue
    ..strokeWidth = 1
    ..style = PaintingStyle.stroke;

  @override
  void paint(Canvas canvas, Size size) {
    canvas.clipRect(Offset.zero & size);
    canvas.translate(size.width / 2, size.height / 2);
    coordinateCanvas.paint(canvas, size);
    //点转为以中点为坐标的点
    position = repaint.points.map((e) => e.translate(-size.width / 2, -size.height / 2)).toList();

    final path = Path();
    //如果选了小于九单纯画点
    if (position.length < 3) {
      canvas.drawPoints(PointMode.points, position, _positionPaint);
    } else {

      path.moveTo(position.first.dx, position.first.dy);
      path.quadraticBezierTo(position[1].dx, position[1].dy, position[2].dx, position[2].dy);
      canvas.drawPath(path, _linePaint);
    }
  }

  @override
  bool shouldRepaint(covariant _BezierDragPainter oldDelegate) {
    return oldDelegate.repaint != repaint;
  }
}

class TouchInfo extends ChangeNotifier {
  List<Offset> _points = [];
  int _selectIndex = -1;

  List<Offset> get points => _points;

  int get selectIndex => _selectIndex;

  set selectIndex(int value) {
    assert(value != null);
    if (_selectIndex == value) return;
    _selectIndex = value;
    notifyListeners();
  }

  void addPoints(Offset value) {
    points.add(value);
    notifyListeners();
  }

  void updatePoint(int index, Offset point) {
    points[index] = point;
    notifyListeners();
  }

  Offset get selectPoint => _selectIndex == -1 ? null : _points[_selectIndex];
}
