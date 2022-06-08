import 'dart:ui';

import 'package:doctor_akhavan_project/services/draw_image_provider.dart';
import 'package:flutter/material.dart';

const double selectableAreaRadius = 70;

class CustomPointPainter extends CustomPainter {
  final DrawImageProvider provider;

  CustomPointPainter(this.provider);

  @override
  void paint(Canvas canvas, Size size) {
    Paint paint = Paint()
      ..color = Colors.red
      ..strokeCap = StrokeCap.round
      ..strokeWidth = 6;
    //draw points on canvas
    canvas.drawPoints(
        PointMode.points,
        [
          ...provider.bodyPoints.toList(),
          if (!provider.isFinished) provider.selectedPoint
        ],
        paint);
    if (!provider.isFinished) {
      _drawSelectableArea(canvas);
    }
  }

  @override
  bool shouldRepaint(CustomPainter oldDelegate) => true;

  void _drawSelectableArea(Canvas canvas) {
    Paint paint = Paint()
      ..strokeWidth = 1
      ..color = Colors.yellow
      ..style = PaintingStyle.stroke;
    canvas.drawCircle(provider.selectedPoint, selectableAreaRadius, paint);
    canvas.drawCircle(
        provider.selectedPoint,
        selectableAreaRadius,
        paint
          ..color = Colors.yellow.withOpacity(0.1)
          ..style = PaintingStyle.fill);
  }
}
