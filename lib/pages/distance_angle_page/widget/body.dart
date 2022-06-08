import 'package:flutter/material.dart';

import '../../../models/case.dart';

class Body extends StatelessWidget {
  final Case sideCase;
  final Widget image;
  final bool isDistanceMode;
  const Body(
      {Key? key,
      required this.isDistanceMode,
      required this.sideCase,
      required this.image})
      : super(key: key);

  @override
  Widget build(BuildContext context) {
    return CustomPaint(
      child: image,
      // foregroundPainter: isDistanceMode
      //     ? CustomDistancePainter(
      //         leftPoints: leftPoints, rightPoints: rightPoints)
      //     : CustomAnglePainter(
      //         leftPoints: leftPoints, rightPoints: rightPoints),
    );
  }
}
