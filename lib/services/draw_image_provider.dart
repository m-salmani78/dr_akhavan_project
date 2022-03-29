import 'package:camera/camera.dart';
import 'package:flutter/material.dart';

const int maxPointsNum = 5;

class DrawImageProvider extends ChangeNotifier {
  final XFile image;
  final List<Offset> points = [];
  // bool isCompleted = false;

  DrawImageProvider(this.image);

  void setPoint(Offset point) {
    if (points.length >= maxPointsNum) return;
    points.add(point);
    notifyListeners();
  }
}
