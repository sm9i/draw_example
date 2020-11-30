import 'package:draw_example/coordinate_canvas.dart';
import 'package:flutter/material.dart';
import 'dart:ui' as ui;
import 'dart:math';

///  1-6
class MPainter1 extends CustomPainter {
  final CoordinateCanvas coordinateCanvas = CoordinateCanvas(step: 25);

  @override
  void paint(Canvas canvas, Size size) {
    canvas.translate(size.width / 2, size.height / 2);
    coordinateCanvas.paint(canvas, size);
    // drawLine(canvas, size);

    // drawText(canvas, size);

    // drawPath(canvas, size);

    //drawPath2(canvas, size);

    // drawPath3(canvas, size);

    // drawPath4(canvas, size);

    // drawPath5(canvas, size);

    // drawPath6(canvas, size);

    drawPath7(canvas, size);
  }

  ///路径测量
  ///computeMetrics
  ///并且给路径的一半画圈
  void drawPath7(Canvas canvas, Size size) {
    Path path = Path();
    path
      ..relativeMoveTo(0, 0)
      ..relativeLineTo(-30, 120)
      ..relativeLineTo(30, -30)
      ..relativeLineTo(30, 30)
      ..close();
    path.addOval(Rect.fromCenter(center: Offset.zero, width: 50, height: 50));

    ui.PathMetrics computeMetrics = path.computeMetrics();
    computeMetrics.forEach((pm) {
      //获取当前线路 点位置信息 *0.5 表示获取中间的 位置
      final tangent = pm.getTangentForOffset(pm.length * 0.5);
      print("---length:-${pm.length}----contourIndex:-${pm.contourIndex}----isClosed:-${pm.isClosed}----");
      //给中间的位置画一个圆
      canvas.drawCircle(tangent.position, 3, Paint()..color = Colors.black);
    });
    canvas.drawPath(
      path,
      Paint()
        ..color = Colors.red
        ..style = PaintingStyle.stroke
        ..strokeWidth = .5,
    );
  }

  //路径的 判断点和 区域判断 路径联合
  // combine 联合路径
  void drawPath6(Canvas canvas, Size size) {
    Path path = Path();
    Paint paint = Paint()
      ..color = Colors.purpleAccent
      ..strokeWidth = 2
      ..style = PaintingStyle.fill;

    path
      ..moveTo(0, 0)
      ..relativeLineTo(25, 100)
      ..relativeLineTo(-25, -25)
      ..relativeLineTo(-25, 25)
      ..close();
    canvas.drawPath(path, paint);
    //判断是否再路径内
    print(path.contains(Offset.zero));
    print(path.contains(Offset(100, 100)));
    //获取path的矩形
    Rect bounds = path.getBounds();
    canvas.drawRect(
        bounds,
        Paint()
          ..color = Colors.orange
          ..style = PaintingStyle.stroke
          ..strokeWidth = 1);
    //旋转

    // canvas.drawPath(path.transform(Matrix4.rotationZ(pi).storage), paint);

    final pathOval = Path()..addOval(Rect.fromCenter(center: Offset.zero, width: 80, height: 80));
    canvas.drawPath(pathOval, paint);
    canvas.save();
    canvas.translate(-100, -250);
    canvas.drawPath(Path.combine(PathOperation.difference, path, pathOval), paint);

    canvas.translate(100, 0);
    canvas.drawPath(Path.combine(PathOperation.intersect, path, pathOval), paint);

    canvas.translate(100, 0);
    canvas.drawPath(Path.combine(PathOperation.union, path, pathOval), paint);
    canvas.restore();

    canvas.translate(100, 0);
    canvas.drawPath(Path.combine(PathOperation.xor, path, pathOval), paint);
  }

  //路径的 封闭和平移
  void drawPath5(Canvas canvas, Size size) {
    Path path = Path();
    Paint paint = Paint()
      ..color = Colors.purpleAccent
      ..strokeWidth = 2
      ..style = PaintingStyle.stroke;
    path
      ..lineTo(100, 100)
      ..relativeLineTo(0, -50)
      //封闭路径
      ..close();
    canvas.drawPath(path, paint);
    //平移 路径  shift
    canvas.drawPath(path.shift(Offset(0, 100)), paint);
  }

  ///贝塞尔曲线
  void drawPath4(Canvas canvas, Size size) {
    Paint paint = Paint();
    paint
      ..color = Colors.red
      ..style = PaintingStyle.stroke
      ..strokeWidth = 1;
    final path = Path();

    final Offset p1 = Offset(100, -100);
    final Offset p2 = Offset(160, 50);
    path.quadraticBezierTo(p1.dx, p1.dy, p2.dx, p2.dy);

    path.quadraticBezierTo(-100, 100, -50, -50);
    canvas.drawPath(path, paint);

    path.reset();
    path.cubicTo(25, -50, 50, 50, 100, 25);
    //w已有路径添加矩形
    path
      ..addRect(Rect.fromCenter(center: Offset(50, -100), width: 50, height: 50))
      ..addRRect(RRect.fromRectXY(
        Rect.fromCenter(center: Offset(50, -100), width: 50, height: 25),
        10,
        10,
      ))
      ..addArc(Rect.fromCenter(center: Offset(50, -100)), 0, pi);
    canvas.drawPath(path, paint);
  }

  ///圆锥曲线
  void drawPath3(Canvas canvas, Size size) {
    Paint paint = Paint();
    paint
      ..color = Colors.red
      ..style = PaintingStyle.stroke
      ..strokeWidth = 1;
    final path = Path();

    final p1 = Offset(80, -100);
    final p2 = Offset(160, 0);

    canvas.drawRect(Rect.fromPoints(p1, p2), paint);

    //椭圆
    path.conicTo(p1.dx, p1.dy, p2.dx, p2.dy, 0.5);
    canvas.drawPath(path, paint);
    path.reset();
    //抛物线
    path.conicTo(p1.dx, p1.dy, p2.dx, p2.dy, 1);
    canvas.drawPath(path, paint..color = Colors.blue);
    path.reset();

    //双曲线
    path.conicTo(p1.dx, p1.dy, p2.dx, p2.dy, 2.3);
    canvas.drawPath(path, paint..color = Colors.green);
    path.reset();
  }

  ///画弧度
  ///[Path.arcToPoint] 给路径加弧度
  void drawPath2(Canvas canvas, Size size) {
    Paint paint = Paint();
    paint
      ..color = Colors.red
      ..style = PaintingStyle.stroke
      ..strokeWidth = 1;
    final path = Path();
    path.lineTo(100, -40);
    path
      ..arcToPoint(Offset(40, 40), radius: Radius.circular(60), largeArc: false)
      ..close();
    canvas.drawPath(path, paint);

    path.reset();

    ///优弧
    canvas.translate(-150, 0);
    path.lineTo(100, -40);
    path
      ..arcToPoint(Offset(40, 40), radius: Radius.circular(60), largeArc: true, clockwise: false)
      ..close();
    canvas.drawPath(path, paint);

    path.reset();

    ///优弧
    canvas.translate(150, 150);
    path.lineTo(100, -40);
    path
      ..arcToPoint(Offset(40, 40), radius: Radius.circular(60), largeArc: true)
      ..close();
    canvas.drawPath(path, paint);
  }

  //路线 1
  void drawPath(Canvas canvas, Size size) {
    Paint paint = Paint();
    paint
      ..color = Colors.red
      ..style = PaintingStyle.fill;

    Path path = Path();
    path
      ..moveTo(0, -50)
      ..lineTo(50, 0)
      ..lineTo(50, 50)
      ..lineTo(0, 0)
      ..close();

    canvas.drawPath(path, paint);

    paint
      ..style = PaintingStyle.stroke
      ..strokeWidth = 2;

    path
      ..moveTo(0, -50)
      ..lineTo(-50, 0)
      ..lineTo(-50, 50)
      ..lineTo(0, 0)
      ..close();
    canvas.drawPath(path, paint);

    //relative 是相对与前点的位移
    path
      ..relativeMoveTo(50, 100)
      ..relativeLineTo(100, 100)
      ..relativeLineTo(-100, 100)
      ..close();
    canvas.drawPath(path, paint);
  }

  void drawText(Canvas canvas, Size size) {
    // final builder = ui.ParagraphBuilder(ui.ParagraphStyle(
    //   textAlign: TextAlign.center,
    //   fontSize: 30,
    // ));
    // builder.pushStyle(ui.TextStyle(color: Colors.red));
    // builder.addText('hello world');
    // canvas.drawParagraph(builder.build(), Offset.zero);

    final textPainter = TextPainter(
      text: TextSpan(
        text: 'Hello ',
        style: TextStyle(
          fontSize: 40,
          //设置画笔 不可和color 冲突
          foreground: Paint()
            ..style = PaintingStyle.stroke
            ..strokeWidth = 1
            ..color = Colors.blue,
        ),
      ),
      textDirection: TextDirection.ltr,
      textAlign: TextAlign.center,
    );
    textPainter.layout();
    print(textPainter.width);
    textPainter.paint(canvas, Offset(-textPainter.size.width / 2, -textPainter.size.height / 2));
  }

  ///绘制一个网格
  void drawLine(Canvas canvas, Size size) {
    //设置offset.zero 为屏幕中心
    canvas.translate(size.width / 2, size.height / 2);
    void drawInLine() {
      final double space = 20;

      final paint = Paint()
        ..color = Colors.grey
        ..strokeWidth = 0.5;

      //保存画布
      canvas.save();
      //每次画一条横  然后画布向下平移 [space]
      for (int i = 0; i < size.height / 2 / space; i++) {
        canvas.drawLine(Offset(0, 0), Offset(size.width / 2, 0), paint);
        canvas.translate(0, space);
      }
      //画布归位
      canvas.restore();

      canvas.save();
      for (int i = 0; i < size.width / 2 / space; i++) {
        canvas.drawLine(Offset.zero, Offset(0, size.height / 2), paint);
        canvas.translate(space, 0);
      }
      canvas.restore();
    }

    drawInLine();

    //右下角的网格绘完 然后旋转画布
    canvas.save();
    canvas.scale(1, -1);
    drawInLine();
    canvas.restore();

    canvas.save();
    canvas.scale(-1, -1);
    drawInLine();
    canvas.restore();
    canvas.save();
    canvas.scale(-1, 1);
    drawInLine();
    canvas.restore();
  }

  @override
  bool shouldRepaint(CustomPainter oldDelegate) {
    return true;
  }
}
