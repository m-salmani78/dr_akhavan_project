import 'dart:developer';
import 'dart:ui';

import 'package:arrow_path/arrow_path.dart';
import 'package:doctor_akhavan_project/helpers/calculate_real_distance.dart';
import 'package:flutter/material.dart';

class CustomDistancePainter extends CustomPainter {
  final List<Offset> leftPoints;
  final List<Offset> rightPoints;

  CustomDistancePainter({required this.rightPoints, required this.leftPoints});

  @override
  void paint(Canvas canvas, Size size) {
    _drawVerticalLines(canvas, size, leftPoints);
    _drawVerticalLines(canvas, size, rightPoints);
    _drawPoints(canvas);
    for (var i = 0; i < rightPoints.length; i++) {
      _drawHorizontalLines(
          canvas: canvas, size: size, p1: rightPoints[i], p2: leftPoints[i]);
    }
  }

  @override
  bool shouldRepaint(covariant CustomPainter oldDelegate) => true;

  void _drawPoints(Canvas canvas) {
    Paint paint = Paint()
      ..color = Colors.purple
      ..strokeCap = StrokeCap.round
      ..strokeWidth = 16;
    final list = rightPoints + leftPoints;
    canvas.drawPoints(PointMode.points, list, paint);
    canvas.drawPoints(
        PointMode.points,
        list,
        paint
          ..color = Colors.white
          ..strokeWidth = 8);
  }

  void _drawHorizontalLines({
    required Canvas canvas,
    required Size size,
    required Offset p1,
    required Offset p2,
  }) {
    Paint paint = Paint()
      ..color = Colors.blue
      ..style = PaintingStyle.stroke
      ..strokeCap = StrokeCap.round
      ..strokeJoin = StrokeJoin.round
      ..strokeWidth = 3.0;
    try {
      Path path = Path()
        ..moveTo(p1.dx, p1.dy)
        ..lineTo(p2.dx, p2.dy);
      path = ArrowPath.make(path: path, isDoubleSided: true, tipLength: 10);
      canvas.drawPath(path, paint);
      final distance = calculateRealDistance(p1, p2);
      TextSpan textSpan = TextSpan(
        text: '${distance.toStringAsFixed(1)} cm',
        style: TextStyle(
          color: paint.color,
          backgroundColor: Colors.white,
        ),
      );
      TextPainter textPainter = TextPainter(
        text: textSpan,
        textDirection: TextDirection.ltr,
      );
      textPainter.layout(minWidth: size.width, maxWidth: size.width);
      textPainter.paint(canvas, Offset((p1 + p2).dx / 2, (p1 + p2).dy / 2));
    } catch (e) {
      log('Error in points ($p1 , $p2):\n$e', name: 'drawHorizontalLines');
    }
  }

  void _drawVerticalLines(Canvas canvas, Size size, List<Offset> points) {
    Paint paint = Paint()
      ..color = Colors.purple
      ..style = PaintingStyle.stroke
      ..strokeCap = StrokeCap.round
      ..strokeJoin = StrokeJoin.round
      ..strokeWidth = 4.0;
    for (int i = 0; i < points.length - 1; i++) {
      try {
        canvas.drawLine(points[i], points[i + 1], paint);
        final distance = calculateRealDistance(points[i], points[i + 1]);
        TextSpan textSpan = TextSpan(
          text: '${distance.toStringAsFixed(1)} cm',
          style: TextStyle(
            color: paint.color,
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
            (points[i] + points[i + 1]).dx / 2,
            (points[i] + points[i + 1]).dy / 2,
          ),
        );
      } catch (e) {
        log('Error in points $i , ${i + 1}:\n$e', name: 'drawVerticalLines');
      }
    }
  }
}
