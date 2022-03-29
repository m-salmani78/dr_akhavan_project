import 'dart:developer';

import 'package:camera/camera.dart';
import 'package:flutter/material.dart';

class ImageDistanceProvider extends ChangeNotifier {
  final XFile image;
  final List<Offset> points;
  Offset? _selectedPoint;

  Offset? get selectedPoint => _selectedPoint;

  ImageDistanceProvider({required this.image, required this.points});

  void selectPoint(Offset value) {
    for (var point in points) {
      final dx = (value.dx - point.dx).abs();
      final dy = (value.dy - point.dy).abs();
      if (dx <= 8 && dy <= 8) {
        _selectedPoint = point;
        log('selected point = $point');
        notifyListeners();
        return;
      }
      log("didn't select any point = $value");
    }
  }
}
