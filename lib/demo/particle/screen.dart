import 'dart:async';

import 'package:draw_example/demo/particle/particle.dart';
import 'package:draw_example/demo/particle/particle_manage.dart';
import 'package:draw_example/demo/particle/particle_painter.dart';
import 'package:draw_example/helper.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'dart:math';

class ParticleScreen extends StatefulWidget {
  @override
  _ParticleScreenState createState() => _ParticleScreenState();
}

class _ParticleScreenState extends State<ParticleScreen> with SingleTickerProviderStateMixin {
  AnimationController _controller;

  ParticleManage pm = ParticleManage(size: Size(300, 200));

  Timer timer;

  @override
  void initState() {
    super.initState();
    initParticleManage();
    // timer = Timer.periodic(Duration(seconds: 1), (timer) {
    //   if (pm.particles.length > 20) {
    //     timer.cancel();
    //   }
    //   pm.particles.add(
    //     Particle(
    //       color: randomRGB(),
    //       size: 5 + 4 * random.nextDouble(),
    //       vx: 3 * random.nextDouble() * pow(-1, random.nextInt(20)),
    //       vy: 3 * random.nextDouble() * pow(-1, random.nextInt(20)),
    //       ay: 0.1,
    //       x: 150,
    //       y: 100,
    //     ),
    //   );
    // });
    _controller = AnimationController(vsync: this, duration: Duration(seconds: 1))
      ..addListener(pm.tick)
      ..repeat();
  }

  @override
  void dispose() {
    _controller?.dispose();
    timer?.cancel();
    pm.dispose();
    super.dispose();
  }

  void initParticleManage() {
    // Particle particle = Particle(x: 0, y: 0, vx: 3, vy: 0, ay: 0.05, color: Colors.blue, size: 8);
    // pm.particles = [particle];

    ///随机粒子
    // for (var i = 0; i < 30; i++) {
    //   pm.particles.add(
    //     Particle(
    //       color: randomRGB(),
    //       size: 5 + 4 * random.nextDouble(),
    //       vx: 3 * random.nextDouble() * pow(-1, random.nextInt(20)),
    //       vy: 3 * random.nextDouble() * pow(-1, random.nextInt(20)),
    //       ay: 0.1,
    //       x: 150,
    //       y: 100,
    //     ),
    //   );
    // }

    ///生成新粒子
    pm.addParticle(Particle(
        color: Colors.blue,
        size: 50,
        vx: 4 * random.nextDouble() * pow(-1, random.nextInt(20)),
        vy: 4 * random.nextDouble() * pow(-1, random.nextInt(20)),
        ay: 0.1,
        ax: 0.1,
        x: 150,
        y: 100));
  }

  void theWorld() {
    if (_controller.isAnimating) {
      _controller.stop();
    } else {
      _controller.repeat();
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('particle'),
      ),
      body: Center(
        child: CustomPaint(
          size: pm.size,
          painter: ParticlePainter(manage: pm),
        ),
      ),
    );
  }
}

