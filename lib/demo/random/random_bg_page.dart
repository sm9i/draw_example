import 'package:draw_example/demo/particle/particle.dart';
import 'package:draw_example/helper.dart';
import 'package:flutter/material.dart';
import 'dart:math' as math;

class RandomBgPage extends StatefulWidget {
  @override
  _RandomBgPageState createState() => _RandomBgPageState();
}

class _RandomBgPageState extends State<RandomBgPage> {
  List<Alignment> alignments = [
    Alignment.center,
    Alignment.centerRight,
    Alignment.centerLeft,
    Alignment.bottomCenter,
    Alignment.bottomLeft,
    Alignment.bottomRight,
    Alignment.topCenter,
    Alignment.topLeft,
    Alignment.topRight,
  ];

  List<Gradient> randomGradient() {
    List<Gradient> res = [];
    List.generate(10, (index) {
      List<Color> colors = [];
      List.generate(randomInt(max: 4,min: 2), (index) {
        colors.add(randomRGB().withOpacity(randomInt(max: 7) / 10));
      });
      // res.add(LinearGradient(
      //   colors: colors,
      //   begin: randomList(alignments),
      //   end: randomList(alignments),
      // ));
      res.add(SweepGradient(
        colors: colors,
        center: randomList(List.of(alignments)..remove(Alignment.center)),
      ));
      // res.add(RadialGradient(
      //   colors: colors,
      //   center: randomList(alignments),
      //   focal: randomList(alignments),
      // ));
    });
    return res;
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('random color'),
      ),
      // body: Container(
      //   decoration: BoxDecoration(
      //     gradient: RadialGradient(
      //       colors: [
      //         randomRGB(),
      //         randomRGB(),
      //       ],
      //       center: Alignment.topLeft,
      //       radius: 0.8,
      //     ),
      //   ),
      // ),
      body: Stack(
        children: randomGradient()
            .map((e) => Container(
                  decoration: BoxDecoration(gradient: e),
                ))
            .toList(),
      ),
    );
  }
}
