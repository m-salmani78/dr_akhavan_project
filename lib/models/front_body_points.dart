import 'package:flutter/material.dart';

class FrontBodyPoints {
  Offset? head;
  Offset? shoulder;
  Offset? stomach;
  Offset? knee;
  Offset? foot;

  FrontBodyPoints();

  /// Returns last point has set
  /// If points are empty return null
  Offset? getLastPoint() => foot ?? knee ?? stomach ?? shoulder ?? head;

  /// Returns true if points are full
  bool addPoint(Offset newPoint) {
    if (head == null) {
      head = newPoint;
    } else if (shoulder == null) {
      shoulder = newPoint;
    } else if (stomach == null) {
      stomach = newPoint;
    } else if (knee == null) {
      knee = newPoint;
    } else if (foot == null) {
      foot = newPoint;
      return true;
    } else {
      return true;
    }
    return false;
  }

  /// Returns previous point has set
  /// If points are empty return null
  Offset? deletePoint() {
    Offset result;
    if (foot != null) {
      result = foot!;
      foot = null;
    } else if (knee != null) {
      result = knee!;
      knee = null;
    } else if (stomach != null) {
      result = stomach!;
      stomach = null;
    } else if (shoulder != null) {
      result = shoulder!;
      shoulder = null;
    } else if (head != null) {
      result = head!;
      head = null;
    } else {
      return null;
    }
    return result;
  }

  List<Offset> toList() =>
      [head, shoulder, stomach, knee, foot].whereType<Offset>().toList();
}
