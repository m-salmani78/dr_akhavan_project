import 'dart:developer';
import 'dart:io';

import 'package:doctor_akhavan_project/pages/image_page/widgets/painter.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

import '../../../services/draw_image_provider.dart';

class Body extends StatelessWidget {
  const Body({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    final provider = context.watch<DrawImageProvider>();
    return GestureDetector(
      onPanStart: (details) {
        final box = context.findRenderObject() as RenderBox;
        final point = box.globalToLocal(details.globalPosition);
        log(point.toString());
        provider.setPoint(point);
      },
      child: RepaintBoundary(
        child: CustomPaint(
          child: Image.file(File(provider.image.path)),
          foregroundPainter: OpenPainter(provider),
        ),
      ),
    );
  }
}
