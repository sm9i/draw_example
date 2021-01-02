import 'dart:math';
import 'dart:ui';

import 'package:flutter/material.dart';
import 'package:flutter/rendering.dart';

const double _kPiePadding = 20; // 圆边距
const double _kStrokeWidth = 12; // 圆弧宽
const double _kAngle = 270; // 圆弧角度
const int _kMax = 220; // 最大刻度值
const int _kMin = 0; // 最小刻度值
const double _kScaleHeightLever1 = 14; // 短刻度线
const double _kScaleHeightLever2 = 18; // 逢5线
const double _kScaleHeightLever3 = 20; // 逢10线
const double _kScaleDensity = 0.5; // 逢10线
const double _kColorStopRate = 0.2; // 颜色变化分率
const List<Color> _kColors = [
  // 颜色列表
  Colors.green,
  Colors.blue,
  Colors.red,
];

class ChartPainter3 extends CustomPainter {
  final TextPainter _textPainter = TextPainter(textDirection: TextDirection.ltr);

  double value = 150;
  double radius = 0;
  Paint fillPaint = Paint();
  Paint stokePaint = Paint()
    ..strokeWidth = 1
    ..style = PaintingStyle.stroke;

  @override
  void paint(Canvas canvas, Size size) {
    radius = size.shortestSide / 2 - _kPiePadding;
    canvas.translate(size.width / 2, size.height / 2);
    drawArrow(canvas);
    drawText(canvas);
    canvas.rotate(pi / 2);
    drawScale(canvas);
    drawOutLine(canvas);
  }

  void drawText(Canvas canvas) {
    //上方文字
    _drawAxisText(canvas, 'km/s', fontStyle: FontStyle.italic, fontWeight: FontWeight.bold, alignment: Alignment.center, color: Colors.black, offset: Offset(0, -radius / 1.5));
    //下方文字
    _drawAxisText(canvas, '${value.toStringAsFixed(1)}', fontSize: 16, alignment: Alignment.center, color: Colors.black, offset: Offset(0, radius / 2));
    int count = (_kMax - _kMin) * _kScaleDensity ~/ 10;
    Color color = Colors.red;
    for (int i = _kMin; i <= count; i++) {
      var thta = pi / 180 * (90 + initAngle + (_kAngle / count) * i);
      if (i < count * _kColorStopRate) {
        color = _kColors[0];
      } else if (i < count * (1 - _kColorStopRate)) {
        color = _kColors[1];
      } else {
        color = _kColors[2];
      }
      Rect rect = Rect.fromLTWH((radius - 40) * cos(thta) - 12, (radius - 40) * sin(thta) - 8, 24, 16);
      canvas.drawRRect(RRect.fromRectAndRadius(rect, Radius.circular(3)), fillPaint..color = color);
      _drawAxisText(canvas, '${i * 10 ~/ _kScaleDensity}',
          fontSize: 11, alignment: Alignment.center, color: Colors.white, offset: Offset((radius - 40) * cos(thta), (radius - 40) * sin(thta)));
    }
  }

  void drawArrow(Canvas canvas) {
    double now = value / _kMax;
    Color color = Colors.red;
    canvas.save();
    // *动画插值
    canvas.rotate(pi / 180 * (-_kAngle / 2 + now * _kAngle));

    Path arrowPath = Path();
    arrowPath.moveTo(0, 18);
    arrowPath.relativeLineTo(-6, -10);
    arrowPath.relativeLineTo(6, -radius + 10);
    arrowPath.relativeLineTo(6, radius - 10);
    arrowPath.close();
    if (now < _kColorStopRate) {
      color = _kColors[0];
    } else if (now < (1 - _kColorStopRate)) {
      color = _kColors[1];
    } else {
      color = _kColors[2];
    }
    canvas.drawPath(arrowPath, fillPaint..color = color);
    canvas.drawCircle(Offset.zero, 3, fillPaint..color = Colors.white);
    canvas.restore();
  }

  void drawScale(Canvas canvas) {
    canvas.save();
    canvas.rotate(pi / 180 * initAngle);
    double len = 0;
    Color color = Colors.red;
    double lineCount = _kMax * _kScaleDensity;
    for (int i = _kMin; i <= lineCount; i++) {
      //判断当前标是长短
      if (i % 5 == 0 && i % 10 != 0) {
        len = _kScaleHeightLever2;
      } else if (i % 10 == 0) {
        len = _kScaleHeightLever3;
      } else {
        len = _kScaleHeightLever1;
      }
      //判断颜色
      if (i < lineCount * _kColorStopRate) {
        color = Colors.green;
      } else if (i < lineCount * (1 - _kColorStopRate)) {
        color = Colors.blue;
      } else {
        color = Colors.red;
      }
      canvas.drawLine(Offset(radius + _kStrokeWidth / 2, 0), Offset(radius - len, 0), stokePaint..color = color);
      canvas.rotate(pi / 180 / _kMax * _kAngle / _kScaleDensity);
    }
    canvas.restore();
  }

  void drawOutLine(Canvas canvas) {
    Path path = Path()..moveTo(radius, 0);
    path.arcTo(Rect.fromCenter(center: Offset.zero, width: radius * 2, height: radius * 2), pi / 180 * initAngle, pi / 180 * _kAngle, true);
    PathMetrics pms = path.computeMetrics();
    stokePaint..strokeWidth = _kStrokeWidth;
    pms.forEach((PathMetric pm) {
      canvas.drawPath(pm.extractPath(0, pm.length * _kColorStopRate), stokePaint..color = _kColors[0]);
      canvas.drawPath(pm.extractPath(pm.length * _kColorStopRate, pm.length * (1 - _kColorStopRate)), stokePaint..color = _kColors[1]);
      canvas.drawPath(pm.extractPath(pm.length * (1 - _kColorStopRate), pm.length), stokePaint..color = _kColors[2]);
    });
  }

  double get initAngle => (360 - _kAngle) / 2;

  void _drawAxisText(
    Canvas canvas,
    String str, {
    double fontSize,
    FontStyle fontStyle,
    FontWeight fontWeight,
    Alignment alignment,
    Color color,
    Offset offset,
  }) {
    _textPainter.text = TextSpan(
      text: str,
      style: TextStyle(
        fontSize: fontSize,
        fontStyle: fontStyle,
        fontWeight: fontWeight,
        color: color,
      ),
    );
    _textPainter.layout();
    Size size = _textPainter.size;
    _textPainter.paint(canvas, Offset(offset.dx - size.width / 2, offset.dy - size.height / 2));
  }

  @override
  bool shouldRepaint(covariant ChartPainter3 oldDelegate) {
    return false;
  }
}
