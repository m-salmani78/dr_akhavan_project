import 'package:camera/camera.dart';
import 'package:doctor_akhavan_project/models/front_body_points.dart';
import 'package:flutter/material.dart';

const int maxPointsNum = 5;

class DrawImageProvider extends ChangeNotifier {
  final XFile image;
  final Offset _defaultPoint;
  final FrontBodyPoints rightPoints = FrontBodyPoints();
  final FrontBodyPoints leftPoints = FrontBodyPoints();
  Offset selectedPoint;
  bool _isRightSide = true;
  bool isEmpty = true;
  bool isFinished = false;

  List<List<Offset>> get points => List.generate(
        2,
        (index) => index == 0 ? rightPoints.toList() : leftPoints.toList(),
        growable: false,
      );

  DrawImageProvider({required this.image, required this.selectedPoint})
      : _defaultPoint = selectedPoint;

  void updateSelectedPoint(Offset delta) {
    selectedPoint = selectedPoint + delta;
    notifyListeners();
  }

  void setPoint() {
    if (isFinished) return;
    if (_isRightSide) {
      rightPoints.addPoint(selectedPoint);
    } else {
      isFinished = leftPoints.addPoint(selectedPoint);
    }
    _isRightSide = !_isRightSide;
    selectedPoint = _defaultPoint;
    isEmpty = false;
    notifyListeners();
  }

  void undoSetPoint() {
    if (isEmpty) return;
    Offset? result;
    if (_isRightSide) {
      result = leftPoints.deletePoint();
    } else {
      result = rightPoints.deletePoint();
      isEmpty = result == null;
    }
    _isRightSide = !_isRightSide;
    selectedPoint = result ?? _defaultPoint;
    isFinished = false;
    notifyListeners();
  }
}
