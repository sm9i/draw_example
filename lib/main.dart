import 'package:draw_example/demo/example/example_1.dart';
import 'package:flutter/services.dart';

import 'demo/bezier_fitting.dart';
import 'demo/particle/screen.dart';
import 'demo/polygon/polygon_page.dart';
import 'demo/random/random_bg_page.dart';
import 'demo/test_page.dart';
import 'package:flutter/material.dart';

import 'demo/canvas_2.dart';
import 'demo/bezier.dart';
import 'demo/bezier_drag.dart';
import 'demo/chart/chart2_page.dart';
import 'demo/chart/chart_page.dart';
import 'demo/chart/china.dart';
import 'demo/curve_box.dart';
import 'demo/dou_dou_people.dart';
import 'demo/gesture/gesture_widget.dart';
import 'demo/image_color.dart';
import 'demo/loading_widget.dart';
import 'demo/path_fitting.dart';
import 'demo/path_run_ball.dart';

void main() {
  WidgetsFlutterBinding.ensureInitialized();
  SystemChrome.setPreferredOrientations([
    DeviceOrientation.portraitUp,
  ]);
  SystemChrome.setEnabledSystemUIOverlays([]);
  runApp(MyApp());
}

class MyApp extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Flutter Demo',
      theme: ThemeData(
        primarySwatch: Colors.blue,
        visualDensity: VisualDensity.adaptivePlatformDensity,
      ),
      home: MyHomePage(title: 'Flutter Demo Home Page'),
    );
  }
}

class MyHomePage extends StatefulWidget {
  MyHomePage({Key key, this.title}) : super(key: key);

  final String title;

  @override
  _MyHomePageState createState() => _MyHomePageState();
}

class _MyHomePageState extends State<MyHomePage> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text(widget.title),
        actions: <Widget>[
          //PathRunBallPage
          //ImageColorPage
          //DouDouPage
          //CurveDemoPage
          //GestureWidget
          //BezierDragPage
          //LoadingPage
          //ChartPage
          //ChinaPage
          //TestPage
          //ParticleScreen
          //BezierFittingPage
          //PolygonPage
          //RandomBgPage
          IconButton(
            icon: Icon(Icons.menu),
            onPressed: () => goPage(context, child: RandomBgPage()),
          ),
        ],
      ),
      body: Center(
        child: CustomPaint(
          painter: CircularBezierPainter(),
          // painter: ChartPainter3(),
          size: MediaQuery.of(context).size,
        ),
      ),
    );
  }
}

void goPage(BuildContext context, {@required Widget child}) {
  Navigator.push(context, MaterialPageRoute(builder: (_) => child));
}
