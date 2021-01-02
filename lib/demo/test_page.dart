import 'package:flutter/material.dart';

class TestPage extends StatefulWidget {
  @override
  _TestPageState createState() => _TestPageState();
}

class _TestPageState extends State<TestPage> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Test page '),
      ),
      body: Column(
        children: [
          TextField(
            autofocus: true,
          )
        ],
      ),
      // body: Center(
      //   child: Wrap(
      //     textDirection: TextDirection.rtl,
      //     spacing: 20,
      //     children: [
      //       RaisedButton(
      //         onPressed: () {},
      //         child: Text(
      //           '1',
      //           style: TextStyle(),
      //           textDirection: TextDirection.rtl,
      //         ),
      //       ),
      //       RaisedButton(onPressed: () {}, child: Text('2')),
      //       // RaisedButton(onPressed: () {}, child: Text('3')),
      //       SizedBox(width: 50, child: Text(' 2')),
      //       RaisedButton(onPressed: () {}, child: Text('4')),
      //     ],
      //     alignment: WrapAlignment.end,
      //   ),
      // ),
    );
  }
}
