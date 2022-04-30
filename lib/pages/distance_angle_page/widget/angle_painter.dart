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
    _drawVerticalLines(canvas, size, leftPoints);
    _drawVerticalLines(canvas, size, rightPoints);
    for (var i = 0; i < rightPoints.length; i++) {
      _drawHorizontalLines(
        canvas: canvas,
        size: size,
        p1: rightPoints[i],
        p2: leftPoints[i],
      );
    }
    _drawPoints(canvas);
  }

  @override
  bool shouldRepaint(covariant CustomPainter oldDelegate) => true;

  void _drawPoints(Canvas canvas) {
    Paint paint = Paint()
      ..color = Colors.blue
      ..strokeCap = StrokeCap.round
      ..strokeWidth = 12;
    final list = rightPoints + leftPoints;
    // canvas.drawPoints(PointMode.points, list, paint);
    canvas.drawPoints(
        PointMode.points,
        list,
        paint
          ..color = Colors.white
          ..strokeWidth = 6);
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
      canvas.drawPoints(PointMode.points, [p1, p2], paint..strokeWidth = 12);
      canvas.drawPoints(
        PointMode.points,
        [p1, p2],
        paint
          ..strokeWidth = 6
          ..color = Colors.white,
      );
      final double angleRad = math.asin(math.sin((p1 - p2).direction)).abs();
      final double angleDeg = angleRad * 180 / math.pi;
      TextSpan textSpan = TextSpan(
        text: '${angleDeg.toStringAsFixed(1)}\u00B0',
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
      ..strokeWidth = 3.0;
    for (int i = 0; i < points.length - 1; i++) {
      try {
        canvas.drawLine(points[i], points[i + 1], paint);
        // final double angleRad =
        //     math.asin(math.sin((points[i] - points[i + 1]).direction)).abs();
        // final double angleDeg = angleRad * 180 / math.pi;
        // TextSpan textSpan = TextSpan(
        //   text: '${angleDeg.toStringAsFixed(1)}\u00B0',
        //   style: TextStyle(
        //     color: paint.color,
        //     backgroundColor: Colors.white,
        //   ),
        // );
        // TextPainter textPainter = TextPainter(
        //   text: textSpan,
        //   // textAlign: TextAlign.center,
        //   textDirection: TextDirection.ltr,
        // );
        // textPainter.layout(minWidth: size.width);
        // textPainter.paint(
        //   canvas,
        //   Offset(
        //     (points[i] + points[i + 1]).dx / 2,
        //     (points[i] + points[i + 1]).dy / 2,
        //   ),
        // );
      } catch (e) {
        log('Error in points $i , ${i + 1}:\n$e', name: 'drawVerticalLines');
      }
    }
  }
}
