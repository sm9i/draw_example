import 'package:draw_example/demo/particle/particle.dart';
import 'package:draw_example/demo/particle/particle_manage.dart';
import 'package:flutter/material.dart';

class ParticlePainter extends CustomPainter {
  ParticlePainter({this.manage}) : super(repaint: manage);

  final ParticleManage manage;

  final fillPaint = Paint();
  final stokePaint = Paint()
    ..strokeWidth = 0.5
    ..style = PaintingStyle.stroke;

  @override
  void paint(Canvas canvas, Size size) {
    canvas.drawRect(Offset.zero & size, stokePaint);
    manage.particles.forEach((particle) => drawParticle(canvas, particle));
  }

  void drawParticle(Canvas canvas, Particle particle) {
    fillPaint.color = particle.color;
    canvas.drawCircle(Offset(particle.x, particle.y), particle.size, fillPaint);
  }

  @override
  bool shouldRepaint(covariant ParticlePainter oldDelegate) {
    return oldDelegate.manage != manage;
  }
}
