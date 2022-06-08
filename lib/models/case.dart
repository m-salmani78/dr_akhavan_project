import 'package:flutter/material.dart';
import 'package:hive/hive.dart';
import 'dart:convert';

import '../helpers/side_mode.dart';

part 'case.g.dart';

Case caseFromJson(String str) => Case.fromMap(jsonDecode(str));

String caseToJson(Case data) => jsonEncode(data.toMap());

@HiveType(typeId: 0)
class Case {
  Case({
    required this.patientId,
    required this.imageName,
    required this.dateTime,
    required this.sideMode,
    required this.points,
  });

  @HiveField(1)
  final int patientId;
  @HiveField(2)
  final String imageName;
  @HiveField(3)
  final DateTime dateTime;
  @HiveField(4)
  final SideMode sideMode;
  @HiveField(5)
  final List<Offset> points;

  factory Case.fromMap(Map<String, dynamic> json) => Case(
        patientId: json["patient_id"],
        imageName: json["image_name"],
        dateTime: DateTime.parse(json["date_time"]),
        sideMode: SideMode.values.firstWhere(
          (e) => e.name == json["side_mode"],
          orElse: () => SideMode.front,
        ),
        points: List<Offset>.from(json["points"].map(
          (x) => Offset(json["dx"].toDouble(), json["dy"].toDouble()),
        )),
      );

  Map<String, dynamic> toMap() => {
        "patient_id": patientId,
        "image_name": imageName,
        "date_time": dateTime.toString(),
        "side_mode": sideMode.name,
        "points": points
            .map<Map<String, double>>(
              (element) => {"dx": element.dx, "dy": element.dy},
            )
            .toList(),
      };
}
