import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:image/image.dart' as image;

class ImageColorPage extends StatefulWidget {
  @override
  _ImageColorPageState createState() => _ImageColorPageState();
}

class _ImageColorPageState extends State<ImageColorPage> {
  List<Ball> balls = [];
  double d = 5;

  @override
  void initState() {
    _initImage();
    super.initState();
  }

  Future<void> _initImage() async {
    var image = await loadImageFromAssets('assets/wx.png');
    for (int i = 0; i < image.width; i++) {
      for (int j = 0; j < image.height; j++) {
        Ball ball = Ball();
        ball.x = i * d + d / 2;
        ball.y = j * d + d / 2;
        ball.r = d / 2;
        var color = Color(image.getPixel(i, j));
        ball.color = Color.fromARGB(color.alpha, color.blue, color.green, color.red);
        balls.add(ball);
      }
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(),
      body: CustomPaint(
        painter: _DrawImage(balls),
        size: MediaQuery.of(context).size,
      ),
    );
  }

  Future<image.Image> loadImageFromAssets(String path) async {
    var byteData = await rootBundle.load(path);
    return image.decodeImage(byteData.buffer.asUint8List(byteData.offsetInBytes, byteData.lengthInBytes));
  }
}

class _DrawImage extends CustomPainter {
  _DrawImage(this.balls);

  final List<Ball> balls;

  @override
  void paint(Canvas canvas, Size size) {
    balls.forEach((ball) {
      canvas.drawCircle(Offset(ball.x, ball.y), ball.r, Paint()..color = ball.color);
    });
  }

  @override
  bool shouldRepaint(CustomPainter oldDelegate) => true;
}

class Ball {
  Ball({this.x, this.y, this.color, this.r});

  double x;
  double y;
  Color color;
  double r;
}
