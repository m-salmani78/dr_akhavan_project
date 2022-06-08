import 'package:doctor_akhavan_project/helpers/side_mode.dart';
import 'package:flutter/material.dart';

class BodyPoints {
  final Map<String, Offset?> points;

  BodyPoints({required this.points});

  /// Returns last point has set
  /// If points are empty return null
  Offset? getLastPoint() {
    try {
      return points.values.lastWhere((e) => e != null);
    } catch (e) {
      return null;
    }
  }

  String? getBodyPartImage(SideMode sideMode) {
    try {
      final selectedPointKey = points.keys.firstWhere((e) => points[e] == null);
      return 'assets/images/${sideMode.name}/$selectedPointKey.png';
    } catch (e) {
      return null;
    }
  }

  /// Returns if the point is added or not
  bool addPoint(Offset newPoint) {
    try {
      final result = points.keys.firstWhere((e) => points[e] == null);
      points[result] = newPoint;
      return true;
    } catch (e) {
      return false;
    }
  }

  bool isFull() {
    return !points.values.any((element) => element == null);
  }

  /// Returns previous point has set
  /// If points are empty return null
  Offset? deletePoint() {
    try {
      final result = points.keys.lastWhere((e) => points[e] != null);
      final Offset deletingPoint = points[result]!;
      points[result] = null;
      return deletingPoint;
    } catch (e) {
      return null;
    }
  }

  List<Offset> toList() => points.values.whereType<Offset>().toList();
}
