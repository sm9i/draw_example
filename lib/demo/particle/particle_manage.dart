import 'package:draw_example/demo/particle/particle.dart';
import 'package:flutter/material.dart';

class ParticleManage extends ChangeNotifier {
  ParticleManage({this.size});

  List<Particle> particles = [];

  Size size;

  ///新增一个粒子
  void addParticle(Particle particle) {
    particles.add(particle);
    notifyListeners();
  }

  void tick() {
    for (int i = 0; i < particles.length; i++) {
      doUpdate(particles[i]);
    }
    notifyListeners();
  }

  ///更新粒子
  void doUpdate(Particle particle) {
    particle.vy += particle.ay;
    particle.vx += particle.ax;
    particle.x += particle.vx;
    particle.y += particle.vy;

    if (particle.x > size.width) {
      particle.x = size.width;
      var newSize = particle.size / 2;
      if (newSize > 1) {
        Particle p = particle.copyWith(
          size: newSize,
          vx: -particle.vx,
          vy: -particle.vy,
          color: randomRGB(),
        );
        particles.add(p);
        particle.size = newSize;
        particle.vx = -particle.vx;
      }
    }
    if (particle.x < 0) {
      particle.x = 0;
      particle.vx = -particle.vx;
    }
    if (particle.y > size.height) {
      particle.y = size.height;
      var newSize = particle.size / 2;
      if (newSize > 1) {
        Particle p = particle.copyWith(size: newSize, vx: -particle.vx, vy: -particle.vy, color: randomRGB());
        particles.add(p);
        particle.size = newSize;
        particle.vy = -particle.vy;
      }
    }
    if (particle.y < 0) {
      particle.y = 0;
      particle.vy = -particle.vy;
    }
  }
}
