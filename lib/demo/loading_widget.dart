import 'package:flutter/material.dart';

class LoadingWidget extends StatefulWidget {
  @override
  _LoadingWidgetState createState() => _LoadingWidgetState();
}

class _LoadingWidgetState extends State<LoadingWidget> with SingleTickerProviderStateMixin {
  AnimationController _controller;

  @override
  void initState() {
    _controller = AnimationController(vsync: this, duration: Duration(milliseconds: 500))..repeat();
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
        title: Text('data'),
      ),
    );
  }
}

CustomPainter get loadingPainter => _LoadingPainter();

class _LoadingPainter extends CustomPainter {
  _LoadingPainter({
    this.width = 80,
    this.height = 20,
    this.warpHeight = 100,
  });

  final double width;
  final double height;
  final double warpHeight;

  @override
  void paint(Canvas canvas, Size size) {
    canvas.translate(size.width / 2, size.height / 2);
    final Paint paint = Paint()
      ..color = Colors.blueAccent
      ..style = PaintingStyle.fill
      ..strokeWidth = 2;
    final Path path = Path();

    canvas.translate(-2 * width, 0);
    path.relativeQuadraticBezierTo(width / 2, -height * 2, width, 0);
    path.relativeQuadraticBezierTo(width / 2, height * 2, width, 0);
    path.relativeQuadraticBezierTo(width / 2, -height * 2, width, 0);
    path.relativeQuadraticBezierTo(width / 2, height * 2, width, 0);
    //包裹下面的
    path.relativeLineTo(0, warpHeight);
    //左边
    path.relativeLineTo(-width * 2 * 2.0, 0);
    path.close();
    canvas.drawPath(path, paint..style = PaintingStyle.fill);
  }

  @override
  bool shouldRepaint(CustomPainter oldDelegate) {
    return false;
  }
}
