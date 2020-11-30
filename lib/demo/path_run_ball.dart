import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';

class PathRunBallPage extends StatefulWidget {
  @override
  _PathRunBallPageState createState() => _PathRunBallPageState();
}

class _PathRunBallPageState extends State<PathRunBallPage> with SingleTickerProviderStateMixin {
  AnimationController _animationController;

  @override
  void initState() {
    _animationController = AnimationController(
      vsync: this,
      duration: Duration(seconds: 3),
    )..repeat();
    super.initState();
  }

  @override
  void dispose() {
    _animationController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(),
      body: CustomPaint(
        painter: _RunBallPainter(progress: _animationController),
        size: MediaQuery.of(context).size,
      ),
    );
  }
}

class _RunBallPainter extends CustomPainter {
  _RunBallPainter({@required this.progress}) : super(repaint: progress);
  final Animation<double> progress;

  @override
  void paint(Canvas canvas, Size size) {
    canvas.translate(size.width / 2, size.height / 2);
    Paint paint = Paint()
      ..color = Colors.orange
      ..strokeWidth = 1
      ..style = PaintingStyle.stroke;
    Path path = Path();
    path
      ..relativeMoveTo(0, -100)
      ..relativeLineTo(-50, 180)
      ..relativeLineTo(50, -50)
      ..relativeLineTo(50, 50)
      ..close();
    path.addOval(Rect.fromCenter(center: Offset(0, -100), width: 100, height: 100));

    canvas.drawPath(path, paint);
    path.computeMetrics().forEach((cm) {
      final tangent = cm.getTangentForOffset(cm.length * progress.value);
      canvas.drawCircle(tangent.position, 5, Paint()..color = Colors.deepPurple);
    });
  }

  @override
  bool shouldRepaint(CustomPainter oldDelegate) => true;
}
