import 'package:camera/camera.dart';
import 'package:flutter/material.dart';

class DrawImageProvider extends ChangeNotifier {
  final XFile image;
  List<Offset> points = [];
  bool isCompleted = false;

  DrawImageProvider(this.image);

  void setPoint(Offset point) {
    if (isCompleted) return;
    points.add(point);
    if (points.length >= 5) isCompleted = true;
    notifyListeners();
  }
}
