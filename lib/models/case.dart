import 'dart:developer';
import 'dart:io';

import 'package:flutter/material.dart';
import 'package:hive/hive.dart';
import 'dart:convert';

part 'case.g.dart';

Case caseFromJson(String str) => Case.fromMap(jsonDecode(str));

String caseToJson(Case data) => jsonEncode(data.toMap());

enum SideMode { front, back, right }

@HiveType(typeId: 0)
class Case {
  Case({
    required this.caseId,
    required this.patientId,
    required this.imagePath,
    required this.dateTime,
    required this.sideMode,
    required this.points,
    required this.fileName,
  });

  @HiveField(0)
  final int caseId;
  @HiveField(1)
  final int patientId;
  @HiveField(2)
  final String imagePath;
  @HiveField(3)
  final DateTime dateTime;
  @HiveField(4)
  final SideMode sideMode;
  @HiveField(5)
  final List<Offset> points;
  @HiveField(6)
  final String fileName;

  factory Case.fromMap(Map<String, dynamic> json) => Case(
        caseId: json["case_id"],
        patientId: json["patient_id"],
        imagePath: json["image_path"],
        fileName: json["file_name"],
        dateTime: DateTime.parse(json["date_time"]),
        sideMode: SideMode.values[json["side_mode"].toInt()],
        points: List<Offset>.from(json["points"].map(
          (x) => Offset(json["dx"].toDouble(), json["dy"].toDouble()),
        )),
      );

  Map<String, dynamic> toMap() => {
        "case_id": caseId,
        "patient_id": patientId,
        "image_path": imagePath,
        "file_name": fileName,
        "date_time": dateTime.toString(),
        "side_mode": sideMode.index,
        "points": points
            .map<Map<String, double>>(
              (element) => {"dx": element.dx, "dy": element.dy},
            )
            .toList(),
      };

  Future<bool> saveToFile(String dir) async {
    try {
      final jsonFile = File('$dir/$fileName.json');
      await jsonFile.writeAsString(caseToJson(this));
      return true;
    } catch (e) {
      log('error: $e', name: 'saveToFile');
      return false;
    }
  }
}
