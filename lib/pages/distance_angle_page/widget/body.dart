import 'package:doctor_akhavan_project/pages/distance_angle_page/widget/angle_painter.dart';
import 'package:doctor_akhavan_project/pages/distance_angle_page/widget/distance_painter.dart';
import 'package:flutter/material.dart';

class Body extends StatelessWidget {
  final List<Offset> leftPoints;
  final List<Offset> rightPoints;
  final Widget image;
  final bool isDistanceMode;
  const Body(
      {Key? key,
      required this.isDistanceMode,
      required this.leftPoints,
      required this.rightPoints,
      required this.image})
      : super(key: key);

  @override
  Widget build(BuildContext context) {
    return CustomPaint(
      child: image,
      foregroundPainter: isDistanceMode
          ? CustomDistancePainter(
              leftPoints: leftPoints, rightPoints: rightPoints)
          : CustomAnglePainter(
              leftPoints: leftPoints, rightPoints: rightPoints),
    );
  }
}
