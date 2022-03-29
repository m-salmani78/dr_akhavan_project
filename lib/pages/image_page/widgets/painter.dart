import 'dart:ui';

import 'package:doctor_akhavan_project/services/draw_image_provider.dart';
import 'package:flutter/material.dart';

class CustomPointPainter extends CustomPainter {
  final DrawImageProvider provider;

  CustomPointPainter(this.provider);

  @override
  void paint(Canvas canvas, Size size) {
    Paint paint = Paint()
      ..color = Colors.red
      ..strokeCap = StrokeCap.round
      ..strokeWidth = 8;
    //draw points on canvas
    canvas.drawPoints(PointMode.points, provider.points, paint);
  }

  @override
  bool shouldRepaint(CustomPainter oldDelegate) => true;
}
