import 'dart:developer';
import 'dart:math' as math;
import 'dart:ui';

import 'package:flutter/material.dart';

class CustomAnglePainter extends CustomPainter {
  final List<Offset> leftPoints;
  final List<Offset> rightPoints;

  CustomAnglePainter({required this.leftPoints, required this.rightPoints});

  @override
  void paint(Canvas canvas, Size size) {
    for (var i = 0; i < rightPoints.length; i++) {
      _drawHorizontalLines(
        canvas: canvas,
        size: size,
        p1: rightPoints[i],
        p2: leftPoints[i],
      );
    }
    _drawVerticalLines(
        canvas,
        size,
        List.generate(
          leftPoints.length,
          (index) => (leftPoints[index] + rightPoints[index]) / 2,
        ));
  }

  @override
  bool shouldRepaint(covariant CustomPainter oldDelegate) => true;

  void _drawPoints(
      {required Canvas canvas,
      required Color color,
      double strokeWidth = 3,
      required List<Offset> points}) {
    Paint paint = Paint()
      ..color = color
      ..strokeCap = StrokeCap.round
      ..strokeWidth = strokeWidth * 4;
    canvas.drawPoints(PointMode.points, points, paint);
    canvas.drawPoints(
        PointMode.points,
        points,
        paint
          ..color = Colors.white
          ..strokeWidth = strokeWidth * 2);
  }

  void _drawHorizontalLines({
    required Canvas canvas,
    required Size size,
    required Offset p1,
    required Offset p2,
  }) {
    const color = Colors.blue;
    Paint paint = Paint()
      ..color = color
      ..style = PaintingStyle.stroke
      ..strokeCap = StrokeCap.round
      ..strokeJoin = StrokeJoin.round
      ..strokeWidth = 3.0;
    try {
      canvas.drawLine(p1, p2, paint);
      _drawPoints(canvas: canvas, color: Colors.blue, points: [p1, p2]);
      final double angleRad = math.asin(math.sin((p1 - p2).direction));
      final double angleDeg = angleRad * 180 / math.pi;
      TextSpan textSpan = TextSpan(
        text: '${angleDeg.toStringAsFixed(2)}\u00B0',
        style: const TextStyle(
          color: color,
          backgroundColor: Colors.white,
        ),
      );
      TextPainter textPainter = TextPainter(
        text: textSpan,
        textDirection: TextDirection.ltr,
      );
      textPainter.layout(minWidth: size.width, maxWidth: size.width);
      textPainter.paint(canvas, p2);
    } catch (e) {
      log('Error in points $p1 , $p2:\n$e', name: 'drawHorizontalLines');
    }
  }

  void _drawVerticalLines(Canvas canvas, Size size, List<Offset> points) {
    Paint paint = Paint()
      ..color = Colors.purple
      ..style = PaintingStyle.stroke
      ..strokeCap = StrokeCap.round
      ..strokeJoin = StrokeJoin.round
      ..strokeWidth = 4;
    for (int i = 0; i < points.length - 1; i++) {
      try {
        canvas.drawLine(points[i], points[i + 1], paint);
        final double angleRad = (points[i + 1] - points[i]).direction;
        final double angleDeg = (angleRad * 180 / math.pi) - 90;
        TextSpan textSpan = TextSpan(
          text: '${angleDeg.toStringAsFixed(2)}\u00B0',
          style: const TextStyle(
            color: Colors.purple,
            backgroundColor: Colors.white,
          ),
        );
        TextPainter textPainter = TextPainter(
          text: textSpan,
          textDirection: TextDirection.ltr,
        );
        textPainter.layout(minWidth: size.width, maxWidth: size.width);
        textPainter.paint(canvas, (points[i] + points[i + 1]) / 2);
      } catch (e) {
        log('Error in points $i , ${i + 1}:\n$e', name: 'drawVerticalLines');
      }
    }
    _drawPoints(
        canvas: canvas, color: Colors.purple, points: points, strokeWidth: 4);
  }
}
