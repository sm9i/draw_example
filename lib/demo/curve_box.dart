import 'package:flutter/material.dart';
import 'dart:math';

class CurveDemoPage extends StatelessWidget {
  final List<Curve> curves = [
    Curves.bounceIn,
    Curves.bounceInOut,
    Curves.bounceOut,
    Curves.decelerate,
    Curves.easeInToLinear,
    Curves.ease,
    Curves.easeIn,
    Curves.easeInBack,
    Curves.easeInCirc,
    Curves.easeInCubic,
    Curves.easeInExpo,
    Curves.easeInOut,
    Curves.easeInOutBack,
    Curves.easeInOutCirc,
    Curves.easeInOutCubic,
    Curves.easeInOutExpo,
    Curves.easeInOutQuad,
    Curves.easeInOutQuart,
    Curves.easeInOutQuint,
    Curves.easeInOutSine,
    Curves.easeOut,
    Curves.easeOutBack,
    Curves.easeOutCirc,
    Curves.easeOutCubic,
    Curves.easeOutExpo,
    Curves.easeOutQuad,
    Curves.easeOutQuart,
    Curves.easeOutQuint,
    Curves.easeInOutSine,
    Curves.fastLinearToSlowEaseIn,
    Curves.fastOutSlowIn,
    Curves.linearToEaseOut,
    Curves.linear,
    Curves.slowMiddle,
  ];

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('curve demo '),
      ),
      body: Center(
        child: SingleChildScrollView(
          child: Wrap(
            runSpacing: 10,
            alignment: WrapAlignment.center,
            spacing: 10,
            children: curves
                .map((e) => Column(
                      mainAxisSize: MainAxisSize.min,
                      children: <Widget>[
                        SizedBox(
                          child: CurveBox(curve: e),
                          width: 80,
                          height: 80,
                        ),
                        Padding(
                          padding: const EdgeInsets.only(top: 10),
                          child: Text(
                            '${e.toString()}',
                            style: TextStyle(fontSize: 10),
                          ),
                        )
                      ],
                    ))
                .toList(),
          ),
        ),
      ),
    );
  }
}

class CurveBox extends StatefulWidget {
  const CurveBox({Key key, this.color = Colors.lightBlue, this.curve = Curves.linear}) : super(key: key);
  final Color color;

  final Curve curve;

  @override
  _CurveBoxState createState() => _CurveBoxState();
}

class _CurveBoxState extends State<CurveBox> with SingleTickerProviderStateMixin {
  AnimationController _controller;
  Animation<double> _angleAnimation;

  @override
  void initState() {
    _controller = AnimationController(vsync: this, duration: const Duration(seconds: 3));
    _angleAnimation = CurveTween(curve: widget.curve).animate(_controller);
    _controller.repeat();
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
      painter: _CurveCustomPainter(_controller, _angleAnimation),
    );
  }
}

class _CurveCustomPainter extends CustomPainter {
  _CurveCustomPainter(this.repaint, this.angleAnimation) : super(repaint: repaint);
  final Animation<double> repaint;
  Animation<double> angleAnimation;
  final Paint _paint = Paint();

  @override
  void paint(Canvas canvas, Size size) {
    //超出部分裁剪
    canvas.clipRect(Offset.zero & size);
    canvas.translate(size.width / 2, size.height / 2);

    _drawRing(canvas, size);
    _drawGreen(canvas, size);
    _drawRed(canvas, size);
  }

  void _drawRing(Canvas canvas, Size size) {
    _paint
      ..color = Colors.blue
      ..style = PaintingStyle.stroke
      ..strokeWidth = 3;
    canvas.drawCircle(Offset.zero, size.width / 2 - 3, _paint);
  }

  void _drawGreen(Canvas canvas, Size size) {
    canvas.save();
    canvas.translate(0, angleAnimation.value * (size.height - 6));
    _paint
      ..color = Colors.green
      ..style = PaintingStyle.fill;
    canvas.drawCircle(Offset.zero.translate(0, -(size.width / 2 - 3)), 3, _paint);
    canvas.restore();
  }

  void _drawRed(Canvas canvas, Size size) {
    canvas.save();
    canvas.rotate(angleAnimation.value * 2 * pi);
    _paint
      ..color = Colors.red
      ..style = PaintingStyle.fill;
    canvas.drawCircle(Offset.zero.translate(0, -(size.width / 2 - 5)), 3, _paint);
    canvas.restore();
  }

  @override
  bool shouldRepaint(covariant _CurveCustomPainter oldDelegate) {
    return oldDelegate.repaint != repaint;
  }
}
