import 'dart:convert';
import 'dart:developer';
import 'dart:io';

import 'package:doctor_akhavan_project/models/case.dart';
import 'package:doctor_akhavan_project/services/patient_provider.dart';
import 'package:hive/hive.dart';

part 'patient.g.dart';

enum Gender { male, female }

String patientToJson(Patient data) => jsonEncode(data.toMap());

@HiveType(typeId: 1)
class Patient {
  @HiveField(0)
  final int id;
  @HiveField(1)
  final String name;
  @HiveField(2)
  final int age;
  @HiveField(3)
  final Gender gender;
  @HiveField(4)
  Case? frontSideCase;
  @HiveField(5)
  Case? backSideCase;
  @HiveField(6)
  Case? rightSideCase;
  @HiveField(7)
  int? height;
  @HiveField(8)
  int? weight;
  @HiveField(9)
  int? activityLevel;
  @HiveField(10)
  int? bustSize;
  @HiveField(11)
  int? waistSize;
  @HiveField(12)
  int? highHipSize;
  @HiveField(13)
  int? hipSize;

  Patient({
    required this.id,
    required this.name,
    required this.age,
    required this.gender,
    this.height,
    this.weight,
    this.activityLevel,
    this.bustSize,
    this.waistSize,
    this.highHipSize,
    this.hipSize,
    this.frontSideCase,
    this.backSideCase,
    this.rightSideCase,
  });

  Patient.init({
    required this.name,
    required this.age,
    required this.gender,
    this.height,
    this.weight,
    this.activityLevel,
    this.bustSize,
    this.waistSize,
    this.highHipSize,
    this.hipSize,
    this.frontSideCase,
    this.backSideCase,
    this.rightSideCase,
  }) : id = DateTime.now().hashCode;

  factory Patient.fromMap(Map<String, dynamic> json) => Patient(
        id: json["id"].toInt(),
        name: json["name"],
        age: json["age"].toInt(),
        gender: Gender.values.firstWhere(
          (e) => json["gender"] == e.name,
          orElse: () => Gender.male,
        ),
        height: json["height"]?.toInt(),
        weight: json["weight"]?.toInt(),
        activityLevel: json["activity_level"].toInt(),
        bustSize: json["bust_size"]?.toInt(),
        waistSize: json["waist_size"]?.toInt(),
        highHipSize: json["high_hip_size"]?.toInt(),
        hipSize: json["hip_size"]?.toInt(),
        frontSideCase: Case.fromMap(json["front_side_case"]),
        backSideCase: Case.fromMap(json["back_side_case"]),
        rightSideCase: Case.fromMap(json["right_side_case"]),
      );

  Map<String, dynamic> toMap() => {
        "id": id,
        "name": name,
        "age": age,
        "gender": gender.name,
        "height": height ?? -1,
        "weight": weight ?? -1,
        "activity_level": activityLevel ?? -1,
        "bust_size": bustSize ?? -1,
        "waist_size": waistSize ?? -1,
        "high_hip_size": highHipSize ?? -1,
        "hip_size": hipSize ?? -1,
        "front_side_case": frontSideCase?.toMap(),
        "back_side_case": backSideCase?.toMap(),
        "right_side_case": rightSideCase?.toMap(),
      };

  Future<String?> saveToFile() async {
    try {
      String dir = await PatientAccount().getDirection(name);
      final jsonFile = File('$dir/$name.json');
      await jsonFile.writeAsString(patientToJson(this));
      log('save file done sucessfully.');
      return dir;
    } catch (e) {
      log('error: $e', name: 'saveToFile');
      return null;
    }
  }

  @override
  operator ==(other) {
    if (other is Patient) {
      return id == other.id;
    } else {
      return false;
    }
  }

  @override
  int get hashCode => id.hashCode;
}
