import 'dart:math';

import 'package:flutter/material.dart';

class HandleWidget extends StatefulWidget {
  const HandleWidget({Key key, this.size = 200, this.handleRadius = 30, this.onMove})
      : super(key: key);
  final double size;
  final double handleRadius;
  final Function(double rotate, double distance) onMove;

  @override
  _HandleWidgetState createState() => _HandleWidgetState();
}

class _HandleWidgetState extends State<HandleWidget> {
  ValueNotifier<Offset> notifier = ValueNotifier(Offset.zero);

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onPanEnd: onEnd,
      onPanUpdate: onUpdate,
      onPanDown: onDown,
      child: CustomPaint(
        painter: _HandlePainter(widget.handleRadius, notifier, color: Colors.green),
        size: Size(widget.size, widget.size),
      ),
    );
  }

  @override
  void dispose() {
    notifier.dispose();
    super.dispose();
  }

  void onEnd(DragEndDetails details) {
    notifier.value = Offset.zero;
    widget.onMove?.call(0, 0);
  }

  void onUpdate(DragUpdateDetails details) {
    final offset = details.localPosition;
    double dx = 0.0;
    double dy = 0.0;
    dx = offset.dx - widget.size / 2;
    dy = offset.dy - widget.size / 2;
    //atan2 计算 点位置的 弧度
    var rad = atan2(dx, dy);
    if (dx < 0) {
      //如果是坐标系左边
      rad += 2 * pi;
    }
    var bgR = widget.size / 2 - widget.handleRadius;
    var thta = rad - pi / 2; //旋转坐标系90度
    var d = sqrt(dx * dx + dy * dy);
    if (d > bgR) {
      dx = bgR * cos(thta);
      dy = -bgR * sin(thta);
    }
    widget.onMove?.call(dx, dy);
    print("$dx,$dy");
    notifier.value = Offset(dx, dy);
  }

  void onDown(DragDownDetails details) {
    final offset = details.localPosition;
    double dx = 0.0;
    double dy = 0.0;
    dx = offset.dx - widget.size / 2;
    dy = offset.dy - widget.size / 2;
    print(dx);
    print(dy);
  }
}

class _HandlePainter extends CustomPainter {
  final ValueNotifier<Offset> offset;
  final Color color;
  final Paint _paint = Paint();

  final double handleR;

  _HandlePainter(this.handleR, this.offset, {this.color = Colors.blue}) : super(repaint: offset);

  @override
  void paint(Canvas canvas, Size size) {
    canvas.clipRect(Offset.zero & size);
    final bgR = size.width / 2 - handleR;
    canvas.translate(size.width / 2, size.height / 2);
    _paint.style = PaintingStyle.fill;
    _paint.color = color.withAlpha(100);
    canvas.drawCircle(Offset(0, 0), bgR, _paint);

    _paint.color = color.withAlpha(150);
    canvas.drawCircle(Offset(offset.value.dx, offset.value.dy), handleR, _paint);

    _paint.color = color;
    _paint.style = PaintingStyle.stroke;
    canvas.drawLine(Offset.zero, offset.value, _paint);
  }

  @override
  bool shouldRepaint(covariant _HandlePainter oldDelegate) =>
      oldDelegate.handleR != handleR || oldDelegate.offset != offset || oldDelegate.color != color;
}
