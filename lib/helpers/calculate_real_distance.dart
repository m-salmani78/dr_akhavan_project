import 'dart:math' as math;

import 'package:flutter/material.dart';

double calculateRealDistance(Offset a, Offset b) {
  double distance = math.pow(a.dx - b.dx, 2).toDouble();
  distance += math.pow(a.dy - b.dy, 2).toDouble();
  distance = math.sqrt(distance);
  return distance / 15;
}
