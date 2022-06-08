import 'package:camera/camera.dart';
import 'package:doctor_akhavan_project/helpers/side_mode.dart';
import 'package:doctor_akhavan_project/models/body_points.dart';
import 'package:flutter/material.dart';
import 'package:hive_flutter/adapters.dart';

import '../constants/app_constants.dart';
import '../models/case.dart';
import '../models/patient.dart';

const int maxPointsNum = 5;

class DrawImageProvider extends ChangeNotifier {
  final XFile image;
  final SideMode sideMode;
  final Offset _defaultPoint;
  BodyPoints bodyPoints;
  Offset selectedPoint;
  bool isEmpty = true;
  bool isFinished = false;

  DrawImageProvider({
    required this.image,
    required this.sideMode,
    required this.selectedPoint,
  })  : _defaultPoint = selectedPoint,
        bodyPoints = BodyPoints(
          points: {
            for (var element in sideMode == SideMode.front
                ? frontBodyPartsName
                : sideMode == SideMode.back
                    ? backBodyPartsName
                    : rightBodyPartsName)
              element: null
          },
        );

  void updateSelectedPoint(Offset delta) {
    selectedPoint = selectedPoint + delta;
    notifyListeners();
  }

  void setPoint() {
    if (isFinished) return;
    // if (_isRightSide) {
    //   rightPoints.addPoint(selectedPoint);
    // } else {
    //   isFinished = leftPoints.addPoint(selectedPoint);
    // }
    // _isRightSide = !_isRightSide;
    bodyPoints.addPoint(selectedPoint);
    isFinished = bodyPoints.isFull();
    selectedPoint = _defaultPoint;
    isEmpty = false;
    notifyListeners();
  }

  void undoSetPoint() {
    if (isEmpty) return;
    // if (_isRightSide) {
    // result = leftPoints.deletePoint();
    // } else {
    // result = rightPoints.deletePoint();
    // isEmpty = result == null;
    // }
    // _isRightSide = !_isRightSide;
    final result = bodyPoints.deletePoint();
    isEmpty = result == null;
    selectedPoint = result ?? _defaultPoint;
    isFinished = false;
    notifyListeners();
  }

  Case generateCase() {
    final box = Hive.box<Patient>(patientBox);
    final id = box.getAt(0)!.id;
    return Case(
      patientId: id,
      imageName: '${id}_${sideMode.name}.png',
      dateTime: DateTime.now(),
      sideMode: sideMode,
      points: bodyPoints.toList(),
    );
  }
}
