import 'dart:io';

import 'package:doctor_akhavan_project/pages/distance_angle_page/widget/angle_painter.dart';
import 'package:flutter/material.dart';

import '../../../services/draw_image_provider.dart';

class Body extends StatelessWidget {
  final DrawImageProvider provider;
  const Body({Key? key, required this.provider}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return CustomPaint(
      child: Image.file(File(provider.image.path)),
      foregroundPainter: CustomAnglePainter(
        leftPoints: provider.leftPoints.toList(),
        rightPoints: provider.rightPoints.toList(),
      ),
    );
  }
}