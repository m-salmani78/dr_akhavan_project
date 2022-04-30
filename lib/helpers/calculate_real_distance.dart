import 'package:flutter/material.dart';

double calculateRealDistance(Offset a, Offset b) {
  double distance = (a - b).distance;
  return distance / 3;
}
