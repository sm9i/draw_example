import 'package:flutter/material.dart';
import 'dart:math';

class DouDouPage extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(),
      body: Padding(
        padding: const EdgeInsets.all(8.0),
        child: Center(
          child: Wrap(
            spacing: 20,
            runSpacing: 20,
            children: buildChildren(),
          ),
        ),
      ),
    );
  }

  List<Widget> buildChildren() => List.generate(
        6,
        (index) => DouDouPeoplePage(
          color: Colors.lightBlue,
          angle: (1 + index) * 6.0,
        ),
      );
}

class DouDouPeoplePage extends StatefulWidget {
  const DouDouPeoplePage({Key key, this.color, this.angle}) : super(key: key);
  final Color color;
  final double angle;

  @override
  _DouDouPeoplePageState createState() => _DouDouPeoplePageState();
}

class _DouDouPeoplePageState extends State<DouDouPeoplePage> with SingleTickerProviderStateMixin {
  AnimationController _controller;
  Animation<Color> _colorCtrl; //颜色
  Animation<double> _angleCtrl; //角度

  @override
  void initState() {
    super.initState();
    _controller = AnimationController(
      duration: const Duration(seconds: 1),
      vsync: this,
    );
    _angleCtrl = _controller.drive(Tween(begin: 10, end: 40));
    _colorCtrl = ColorTween(begin: Colors.blue, end: Colors.red).animate(_controller);
    _controller.repeat(reverse: true);
  }

  @override
  void dispose() {
    _controller.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return CustomPaint(
      size: Size(100, 100),
      painter: _DouDouPainter(angle: _angleCtrl, color: _colorCtrl, repaint: _controller),
    );
  }
}

class _DouDouPainter extends CustomPainter {
  _DouDouPainter({this.repaint, this.color, this.angle}) : super(repaint: repaint);
  final Animation<double> repaint;
  final Animation<Color> color;
  final Animation<double> angle;

  final Paint _paint = Paint();

  @override
  void paint(Canvas canvas, Size size) {
    canvas.clipRect(Offset.zero & size);
    final double radius = size.width / 2;
    canvas.translate(radius, size.height / 2);
    drawHead(canvas, size);
    drawEye(canvas, radius);
  }

  void drawHead(Canvas canvas, Size size) {
    var rect = Rect.fromCenter(center: Offset.zero, height: size.height, width: size.width);
    var c = angle.value / 180 * pi;
    canvas.drawArc(rect, c, 2 * pi - c.abs() * 2, true, _paint..color = color.value);
  }

  void drawEye(Canvas canvas, double radius) {
    canvas.drawCircle(Offset(radius * 0.25, -radius * 0.5), radius * 0.12, _paint..color = Colors.white);
  }

  @override
  bool shouldRepaint(covariant _DouDouPainter oldDelegate) => oldDelegate.color != color || oldDelegate.angle != angle;
}
