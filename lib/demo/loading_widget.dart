import 'dart:io';

import 'package:flutter/material.dart';

class LoadingPage extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('loading demo '),
      ),
      body: LoadingWidget(),
    );
  }
}

class LoadingWidget extends StatefulWidget {
  @override
  _LoadingWidgetState createState() => _LoadingWidgetState();
}

class _LoadingWidgetState extends State<LoadingWidget> with SingleTickerProviderStateMixin {
  AnimationController _controller;

  @override
  void initState() {
    _controller = AnimationController(vsync: this, duration: Duration(milliseconds: 600))..repeat();
    super.initState();
  }

  @override
  void dispose() {
    _controller.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Center(
      child: CustomPaint(
        painter: _LoadingPainter(CurveTween(curve: Curves.linear).animate(_controller)),
      ),
    );
  }
}

class _LoadingPainter extends CustomPainter {
  _LoadingPainter(this.repaint) : super(repaint: repaint);
  double waveWidth = 100;
  double waveHeight = 10;
  final Animation<double> repaint;

  @override
  void paint(Canvas canvas, Size size) {
    canvas.translate(size.width / 2, size.height / 2);
    canvas.clipRect(Rect.fromCenter(center: Offset(waveWidth, 0), width: waveWidth*2 , height: 200));

    Paint paint = Paint()
      ..color = Colors.orange
      ..style = PaintingStyle.fill
      ..strokeWidth = 2;

    Path path = getWavePath();
    canvas.translate(-4 * waveWidth + 2 * waveWidth * repaint.value, 0);
    canvas.drawPath(path, paint..color = Colors.orange);

    canvas.translate(2*waveWidth* repaint.value, 0);
    canvas.drawPath(path, paint..color = Colors.orange.withAlpha(88));

  }

  Path getWavePath() {
    Path path = Path();
    path.moveTo(0, 0);
    path.relativeQuadraticBezierTo( waveWidth / 2, -waveHeight * 2, waveWidth, 0);
    path.relativeQuadraticBezierTo( waveWidth / 2, waveHeight * 2, waveWidth, 0);
    path.relativeQuadraticBezierTo( waveWidth / 2, -waveHeight * 2, waveWidth, 0);
    path.relativeQuadraticBezierTo( waveWidth / 2, waveHeight * 2, waveWidth, 0);
    path.relativeQuadraticBezierTo( waveWidth / 2, -waveHeight * 2, waveWidth, 0);
    path.relativeQuadraticBezierTo(  waveWidth / 2, waveHeight * 2, waveWidth, 0);
    path.relativeLineTo(0, 80);
    path.relativeLineTo(-waveWidth * 3 * 2, 0);
    path.close();
    return path;
  }

  @override
  bool shouldRepaint(covariant _LoadingPainter oldDelegate) {
    return oldDelegate.repaint != repaint;
  }
}
