import 'package:flutter/material.dart';

class DeviceAccelerometerPainter extends CustomPainter {
  final double dx, dy;
  final bool rightAngle;
  DeviceAccelerometerPainter(this.dx, this.dy, {required this.rightAngle});

  @override
  void paint(Canvas canvas, Size size) {
    _paintTarget(canvas, Offset(size.width / 2, size.height / 2),
        rightState: rightAngle);
    _paintPhoneState(canvas, Offset(size.width / 2, size.height / 2),
        dx: dx, dy: dy);
  }

  @override
  bool shouldRepaint(covariant CustomPainter oldDelegate) => true;

  void _paintTarget(Canvas canvas, Offset offset, {required bool rightState}) {
    Paint paint = Paint()
      ..color = rightState ? Colors.green : Colors.red
      ..strokeCap = StrokeCap.round
      ..strokeJoin = StrokeJoin.round
      ..style = PaintingStyle.stroke
      ..strokeWidth = 3;
    canvas.drawCircle(offset, 100, paint);
    canvas.drawCircle(offset, 15, paint);
    canvas.drawLine(
      Offset(offset.dx - 20, offset.dy),
      Offset(offset.dx + 20, offset.dy),
      paint,
    );
    canvas.drawLine(
      Offset(offset.dx, offset.dy - 20),
      Offset(offset.dx, offset.dy + 20),
      paint,
    );
    canvas.drawLine(
      Offset(offset.dx, offset.dy - 110),
      Offset(offset.dx, offset.dy - 90),
      paint,
    );
    canvas.drawLine(
      Offset(offset.dx, offset.dy + 110),
      Offset(offset.dx, offset.dy + 90),
      paint,
    );
    canvas.drawLine(
      Offset(offset.dx - 110, offset.dy),
      Offset(offset.dx - 90, offset.dy),
      paint,
    );
    canvas.drawLine(
      Offset(offset.dx + 90, offset.dy),
      Offset(offset.dx + 110, offset.dy),
      paint,
    );
  }

  void _paintPhoneState(Canvas canvas, Offset offset,
      {required double dx, required double dy}) {
    Paint paint = Paint()
      ..color = Colors.green
      ..strokeCap = StrokeCap.round
      ..strokeJoin = StrokeJoin.round
      ..style = PaintingStyle.stroke
      ..strokeWidth = 3;

    canvas.drawLine(
      Offset(offset.dx - dx, offset.dy - dy),
      Offset(offset.dx + dx, offset.dy + dy),
      paint,
    );
    canvas.drawLine(
      Offset(offset.dx - dy, offset.dy + dx),
      Offset(offset.dx + dy, offset.dy - dx),
      paint,
    );
  }
}
