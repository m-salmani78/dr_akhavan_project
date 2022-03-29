import 'dart:io';

import 'package:doctor_akhavan_project/services/image_distance_provider.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

import 'distance_painter.dart';

class Body extends StatelessWidget {
  const Body({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    final provider = context.watch<ImageDistanceProvider>();
    return GestureDetector(
      onPanStart: (details) {
        provider.selectPoint(details.localPosition);
      },
      child: RepaintBoundary(
        child: CustomPaint(
          child: Image.file(File(provider.image.path)),
          foregroundPainter: CustomDistancePainter(
            points: provider.points,
            selectedPoint: provider.selectedPoint,
          ),
        ),
      ),
    );
  }
}
