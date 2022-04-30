import 'dart:developer';
import 'dart:io';

import 'package:camera/camera.dart';
import 'package:flutter/material.dart';
import 'dart:convert';

import 'package:path_provider/path_provider.dart';

Case caseFromJson(String str) => Case.fromMap(jsonDecode(str));

String caseToJson(Case data) => jsonEncode(data.toMap());

enum SideMode { front, back, right }

class Case {
  Case({
    required this.caseId,
    required this.patientId,
    required this.imageName,
    required this.sideMode,
    required this.points,
  });

  final int caseId;
  final int patientId;
  final String imageName;
  final SideMode sideMode;
  final List<Offset> points;

  factory Case.fromMap(Map<String, dynamic> json) => Case(
        caseId: json["case_id"],
        patientId: json["patient_id"],
        imageName: json["image_name"],
        sideMode: SideMode.values[json["side_mode"].toInt()],
        points: List<Offset>.from(json["points"].map(
          (x) => Offset(json["dx"].toDouble(), json["dy"].toDouble()),
        )),
      );

  Map<String, dynamic> toMap() => {
        "case_id": caseId,
        "patient_id": patientId,
        "image_name": imageName,
        "side_mode": sideMode.index,
        "points": points
            .map<Map<String, double>>(
              (element) => {"dx": element.dx, "dy": element.dy},
            )
            .toList(),
      };

  Future<bool> saveToFile(XFile image) async {
    try {
      String? dir;
      if (Platform.isAndroid) {
        dir = (await getExternalStorageDirectory())?.path;
      } else if (Platform.isIOS) {
        dir = (await getApplicationDocumentsDirectory()).path;
      }
      if (dir == null) return false;
      await image.saveTo(dir + imageName);
      final jsonFile = File('$dir/data_${patientId}_$caseId.json');
      log('json : ${jsonFile.path}', name: 'save to file');
      await jsonFile.writeAsString(caseToJson(this));
      log('json : ${jsonFile.path}', name: 'save to file');
      return true;
    } catch (e) {
      log('error: $e', name: 'saveToFile');
      return false;
    }
  }
}
