import 'package:draw_example/demo/gesture/handle_widget.dart';
import 'package:draw_example/demo/gesture/ruler_chooser.dart';
import 'package:flutter/material.dart';

class GestureWidget extends StatefulWidget {
  @override
  _GestureWidgetState createState() => _GestureWidgetState();
}

class _GestureWidgetState extends State<GestureWidget> {
  double _rotate = 0;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('gesture widget page'),
      ),
      body: Center(
          child: Column(
        children: <Widget>[
          Transform.rotate(
            angle: _rotate,
            child: Container(color: Colors.blue, width: 100, height: 100),
          ),
          HandleWidget(
            onMove: (double rotate, double distance) {
              _rotate = rotate;
              setState(() {});
            },
          ),
          RulerChooser(onChanged: (value) {
            print(value);
          })
        ],
      )),
    );
  }
}
