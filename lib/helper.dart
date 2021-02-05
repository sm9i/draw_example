import 'dart:math';

import 'package:flutter/material.dart';

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

int randomInt({int max, int min = 0}) {
  int r = random.nextInt(max ?? 10);
  if(r<min){
    return randomInt(max: max,min: min);
  }
  return r;

}

E randomList<E>(List<E> list) {
  if (list == null || list.length == 0) {
    return null;
  }
  return list[randomInt(max: list.length - 1)];
}
