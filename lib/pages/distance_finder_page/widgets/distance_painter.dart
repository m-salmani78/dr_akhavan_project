import 'dart:ui';

import 'package:arrow_path/arrow_path.dart';
import 'package:doctor_akhavan_project/helpers/calculate_real_distance.dart';
import 'package:flutter/material.dart';

class CustomDistancePainter extends CustomPainter {
  final Offset? selectedPoint;
  final List<Offset> points;
  CustomDistancePainter({this.selectedPoint, required this.points});

  @override
  void paint(Canvas canvas, Size size) {
    // Draw arrows
    if (selectedPoint == null) {
      for (var i = 0; i < points.length; i++) {
        _drawLine(
            canvas: canvas,
            size: size,
            startPoint: points[i],
            endPoint: points[(i + 1) % points.length],
            isDoubleSided: true);
      }
    } else {
      for (var point in points) {
        if (point == selectedPoint) continue;
        _drawLine(
            canvas: canvas,
            startPoint: selectedPoint!,
            endPoint: point,
            size: size);
      }
    }

    Paint paint = Paint()
      ..color = Colors.red
      ..strokeCap = StrokeCap.round
      ..strokeWidth = 8;
    canvas.drawPoints(PointMode.points, points, paint);
  }

  @override
  bool shouldRepaint(covariant CustomPainter oldDelegate) => true;

  void _drawLine({
    required Canvas canvas,
    required Size size,
    required Offset startPoint,
    required Offset endPoint,
    bool isDoubleSided = false,
  }) {
    Paint paint = Paint()
      ..color = Colors.blue
      ..style = PaintingStyle.stroke
      ..strokeCap = StrokeCap.round
      ..strokeJoin = StrokeJoin.round
      ..strokeWidth = 2.0;
    Path path = Path()
      ..moveTo(startPoint.dx, startPoint.dy)
      ..lineTo(endPoint.dx, endPoint.dy);
    path =
        ArrowPath.make(path: path, isDoubleSided: isDoubleSided, tipLength: 10);
    canvas.drawPath(path, paint);
    final distance = calculateRealDistance(startPoint, endPoint);
    TextSpan textSpan = TextSpan(
      text: '${distance.toStringAsFixed(1)} cm',
      style: const TextStyle(
        color: Colors.blue,
        backgroundColor: Colors.white,
      ),
    );
    TextPainter textPainter = TextPainter(
      text: textSpan,
      // textAlign: TextAlign.center,
      textDirection: TextDirection.ltr,
    );
    textPainter.layout(minWidth: size.width);
    textPainter.paint(
        canvas,
        Offset(
          (startPoint.dx + endPoint.dx) / 2,
          (startPoint.dy + endPoint.dy) / 2,
        ));
  }
}
