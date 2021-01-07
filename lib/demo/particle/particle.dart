import 'dart:math';

import 'package:flutter/material.dart';

class Particle {
  double x;
  double y;
  double vx; //水平速度
  double ax; //水平加速度
  double ay; //垂直速度
  double vy; //垂直加速度
  double size;
  Color color;

  Particle({
    this.x = 0,
    this.y = 0,
    this.vx = 0,
    this.ax = 0,
    this.ay = 0,
    this.vy = 0,
    this.size = 0,
    this.color = Colors.black,
  });

  Particle copyWith({double x, double y, double vx, double ax, double ay, double vy, double size, Color color}) {
    return Particle(
      x: x ?? this.x,
      y: y ?? this.y,
      vx: vx ?? this.vx,
      vy: vy ?? this.vy,
      ax: ax ?? this.ax,
      ay: ay ?? this.ay,
      size: size ?? this.size,
      color: color ?? this.color,
    );
  }
}
final random = Random();

Color randomRGB({
  int limitR = 0,
  int limitG = 0,
  int limitB = 0,
}) {
  var r = limitR + random.nextInt(256 - limitR); //红值
  var g = limitG + random.nextInt(256 - limitG); //绿值
  var b = limitB + random.nextInt(256 - limitB); //蓝值
  return Color.fromARGB(255, r, g, b); //生成argb模式的颜色
}

