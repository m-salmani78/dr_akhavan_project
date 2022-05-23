import 'dart:io';

import 'package:doctor_akhavan_project/pages/image_select_pints/widgets/painter.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

import '../../../services/draw_image_provider.dart';

class Body extends StatelessWidget {
  const Body({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    final provider = context.watch<DrawImageProvider>();
    return GestureDetector(
      onPanUpdate: (DragUpdateDetails details) {
        final distance =
            (provider.selectedPoint - details.localPosition).distance;
        if (distance <= selectableAreaRadius) {
          provider.updateSelectedPoint(details.delta);
        }
      },
      child: RepaintBoundary(
        child: CustomPaint(
          child: Image.file(File(provider.image.path)),
          foregroundPainter: CustomPointPainter(provider),
        ),
      ),
    );
  }
}
